//
//  DetailViewController.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import Foundation
import UIKit

class DetailViewController: UITableViewController {
  
  private lazy var rightBarButtonItem: UIBarButtonItem = {
    let rightBarButtonItem = UIBarButtonItem()
    rightBarButtonItem.image = UIImage(systemName: "ellipsis.circle")
    rightBarButtonItem.target = self
    rightBarButtonItem.action = #selector(rightBarButtonItemDidTap)
    return rightBarButtonItem
  }()
  
  var repos: [Repository] = []
  
  weak var coordinator: SearchCoordinator?
  
  private var query: String?
  
  var selectSearchOption: String = "default"
  
  init(
    query: String? = nil
  ) {
    self.query = query
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func setupViews() {
    title = "Repositories"
    navigationItem.rightBarButtonItem = rightBarButtonItem
    navigationController?.navigationBar.prefersLargeTitles = false
    
    view.backgroundColor = .systemBackground
    
    tableView.register(cellType: RepositoryCell.self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    print(#function, selectSearchOption)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    fetchData()
  }
  
  private func fetchData() {
    let repos = Response.loadFromFile("repos.json", type(of: self))
    self.repos = repos.items
    tableView.reloadData()
  }
  
  @objc
  private func rightBarButtonItemDidTap() {
    let alertController = UIAlertController(title: "Search options", message: nil, preferredStyle: .actionSheet)
    let sortAction = UIAlertAction(title: "Sort", style: .default) { _ in
      self.coordinator?.selectSearchOption(with: Sort.allCases, on: self)
    }
    let orderAction = UIAlertAction(title: "Order", style: .default) { _ in
      self.coordinator?.selectSearchOption(with: Order.allCases, on: self)
    }
    let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
    
    [sortAction, orderAction, cancelAction].forEach { alertController.addAction($0) }
    self.present(alertController, animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.reuseIdentifier, for: indexPath) as? RepositoryCell else {
      return UITableViewCell()
    }
    cell.configure(with: repos[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repos.count
  }
  
}
