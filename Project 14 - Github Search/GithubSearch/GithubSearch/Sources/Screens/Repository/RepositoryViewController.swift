//
//  DetailViewController.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

// MARK: - UI & Properties

class RepositoryViewController: UIViewController {
  
  // MARK: - Views
  
  private lazy var rightBarButtonItem: UIBarButtonItem = {
    let rightBarButtonItem = UIBarButtonItem()
    rightBarButtonItem.image = UIImage(systemName: "ellipsis.circle")
    rightBarButtonItem.target = self
    rightBarButtonItem.action = #selector(rightBarButtonItemDidTap)
    return rightBarButtonItem
  }()
  
  private let activityIndicator: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView(style: .large)
    activity.translatesAutoresizingMaskIntoConstraints = false
    activity.hidesWhenStopped = true
    activity.stopAnimating()
    return activity
  }()
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(cellType: RepositoryCell.self)
    tableView.setEmptyMessage("검색 결과가 없습니다.")
    return tableView
  }()
  
  // MARK: - Properties
  
  weak var coordinator: SearchCoordinator?
  
  var queryItem: QueryItem?
  
  var disposeBag = DisposeBag()
  
  // MARK: - ViewLifeCycle
  
  init(with queryItem: QueryItem? = nil) {
    self.queryItem = queryItem
    super.init(nibName: nil, bundle: nil)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupViews()
  }
  
}

// MARK: - Binding

extension RepositoryViewController: View {
  
  func bind(reactor: RepositoryReactor) {
    // Action
    rx.viewWillAppear
      .withUnretained(self)
      .map(\.0)
      .compactMap { owner in owner.queryItem }
      .map { Reactor.Action.updateQuery($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    tableView.rx.contentOffset
      .withUnretained(self)
      .filter { owner, offset in
        guard owner.tableView.frame.height > 0 else { return false }
        return offset.y + owner.tableView.frame.height >= owner.tableView.contentSize.height - 100
      }
      .map { _ in Reactor.Action.loadNextPage }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    // State
    reactor.state.map(\.repos)
      .observe(on: MainScheduler.instance)
      .bind(to: tableView.rx.items(cellIdentifier: RepositoryCell.reuseIdentifier, cellType: RepositoryCell.self)) { row, repository, cell in
        cell.configure(with: repository)
      }
      .disposed(by: disposeBag)
    
    reactor.state.map(\.isLoading)
      .withUnretained(self)
      .map(\.1)
      .observe(on: MainScheduler.instance)
      .bind(onNext: {
        self.tableView.backgroundView?.isHidden = $0
        $0 == true ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
      })
      .disposed(by: disposeBag)
        
    reactor.error
      .withUnretained(self)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { owner, error in
        guard let urlError = error as? RxCocoaURLError,
              case let .httpRequestFailed(response, _) = urlError else {
          owner.alert(title: "ERROR", message: error.localizedDescription.uppercased())
          owner.activityIndicator.stopAnimating()
          return
        }
        owner.alert(
          title: "ERROR: \(response.statusCode)",
          message: urlError.localizedDescription.uppercased()
        )
        owner.activityIndicator.stopAnimating()
      })
      .disposed(by: disposeBag)
        
    // View
    tableView.rx.itemSelected
      .withUnretained(self)
      .subscribe(onNext: { owner, indexPath in
        owner.view.endEditing(true)
        owner.tableView.deselectRow(at: indexPath, animated: false)
        guard let htmlUrl = reactor.currentState.repos[indexPath.row].htmlUrl else { return }
        guard let url = URL(string: htmlUrl) else { return }
        
        owner.coordinator?.repositoryItemSelected(with: url, on: self)
      })
      .disposed(by: disposeBag)
    }

}


// MARK: - Methods

extension RepositoryViewController {
  
  private func setupViews() {
    title = "Repositories"
    navigationItem.rightBarButtonItem = rightBarButtonItem
    
    view.backgroundColor = .systemBackground
    view.addSubview(tableView)
    view.addSubview(activityIndicator)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  @objc
  private func rightBarButtonItemDidTap() {
    let alertController = UIAlertController(title: "Search options", message: nil, preferredStyle: .actionSheet)
    let sortAction = UIAlertAction(title: "Sort", style: .default) { _ in
      self.coordinator?.selectSearchOption(with: Sort.allCases, item: self.queryItem, on: self)
    }
    let orderAction = UIAlertAction(title: "Order", style: .default) { _ in
      self.coordinator?.selectSearchOption(with: Order.allCases, item: self.queryItem, on: self)
    }
    let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
    
    [sortAction, orderAction, cancelAction].forEach { alertController.addAction($0) }
    self.present(alertController, animated: true, completion: nil)
  }
  
}
