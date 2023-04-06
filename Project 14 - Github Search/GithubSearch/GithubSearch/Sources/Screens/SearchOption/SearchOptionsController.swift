//
//  SearchOptionsController.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import Foundation
import UIKit

final class SearchOptionsController: UITableViewController {
  
  private var options: [SearchOptionable] = []
  
  var queryItem: QueryItem?
    
  weak var coordinator: SearchCoordinator?
  
  init(options: [SearchOptionable]) {
    self.options = options
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
  }
  
  private func setupViews() {
    view.backgroundColor = .systemBackground
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(leftBarButtonItemDidTap))
  }
  
  @objc
  private func leftBarButtonItemDidTap() {
    coordinator?.dismiss(on: self)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    let target = options[indexPath.row]
    
    switch target {
    case let sort as Sort:
      title = String(describing: Sort.self)
      cell.textLabel?.text = sort.rawValue
    case let order as Order:
      title = String(describing: Order.self)
      cell.textLabel?.text = order.rawValue
    default: break
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return options.count
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let target = options[indexPath.row]
    
    guard let queryItem = self.queryItem else { return }
    
    switch target {
    case let sort as Sort:
      let queryItem = QueryItem(query: queryItem.query, sort: sort, order: queryItem.order)
      coordinator?.didSelectSearchOption(with: queryItem, on: self)
    case let order as Order:
      let queryItem = QueryItem(query: queryItem.query, sort: queryItem.sort, order: order)
      coordinator?.didSelectSearchOption(with: queryItem, on: self)
    default: break
    }
    
  }
  
}
