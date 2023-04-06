//
//  ViewController.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import UIKit
import ReactorKit
import RxSwift

class RecentSearchViewController: UIViewController, View {
  
  private lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.placeholder = "Search Repositories"
    searchController.searchBar.autocapitalizationType = .none
    return searchController
  }()
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(cellType: RecentSearchCell.self)
    tableView.register(headerFooterType: RecentSearchHeaderView.self)
    tableView.isHidden = true
    return tableView
  }()
  
  private let service: RecentSearchService = RecentSearchServiceImp(repository: UserDefaultService())
  
  weak var coordinator: SearchCoordinator?
  
  var disposeBag = DisposeBag()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupViews()
  }
  
  private func setupViews() {
    title = "Github"
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    
    view.backgroundColor = .systemBackground
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
  
}

extension RecentSearchViewController {
  
  func bind(reactor: RecentSearchReactor) {
    //Action
    searchController.searchBar.rx.text
      .map { $0 ?? "" }
      .map { Reactor.Action.updateQuery($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    searchController.searchBar.rx.searchButtonClicked
      .withUnretained(self)
      .map { owner, _ in owner.searchController.searchBar.text ?? "" }
      .map { Reactor.Action.insertQuery($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    //State
    reactor.state.map(\.recentSearches)
      .observe(on: MainScheduler.instance)
      .bind(to: tableView.rx.viewForHeaderInSection(
        identifier: RecentSearchHeaderView.reuseIdentifier,
        viewType: RecentSearchHeaderView.self)) { _,_,headerView in
          headerView.clearButton.rx.tap
            .map { Reactor.Action.removeAll }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        }
        .disposed(by: disposeBag)
    
    reactor.state.map(\.recentSearches)
      .observe(on: MainScheduler.instance)
      .bind(to: tableView.rx.items(cellIdentifier: RecentSearchCell.reuseIdentifier, cellType: RecentSearchCell.self)) { row, element, cell in
        cell.configure(with: element)
        cell.removeButton.rx.tap
          .map { cell.titleLabel.text ?? "" }
          .map { Reactor.Action.removeQuery($0) }
          .bind(to: reactor.action)
          .disposed(by: self.disposeBag)
      }
      .disposed(by: disposeBag)
    
    // UI
    searchController.searchBar.rx.textDidBeginEditing
      .map { false }
      .bind(to: tableView.rx.isHidden)
      .disposed(by: disposeBag)
    
    Observable.merge([
      searchController.searchBar.rx.searchButtonClicked
        .withUnretained(self)
        .map { owner, _ in owner.searchController.searchBar.text ?? ""},
      tableView.rx.modelSelected(String.self).asObservable()
    ])
    .withUnretained(self)
    .subscribe(onNext: { owner, query in
      let queryItem = QueryItem(query: query, sort: .default, order: .desc)
      owner.coordinator?.searchRepositories(queryItem)
    })
    .disposed(by: disposeBag)
    
  }
  
}
