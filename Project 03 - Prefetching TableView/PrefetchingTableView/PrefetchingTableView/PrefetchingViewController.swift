//
//  ViewController.swift
//  PrefetchingTableView
//
//  Created by jc.kim on 3/27/22.
//

import UIKit

class PrefetchingViewController: UIViewController {
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .systemBackground
    tableView.register(PhotoCell.self, forCellReuseIdentifier: "cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 300
    return tableView
  }()
  
  private let viewModel = (1...100).map { _ in ViewModel() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    addConstraints()
    setupViews()
    
    
    print(1...10 ~= 4, "sadfasf")
  }
  
  private func addSubviews() {
    view.addSubview(tableView)
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
  
  private func setupViews() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.prefetchDataSource = self
  }
}


extension PrefetchingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoCell
    cell.configure(with: viewModel[indexPath.row])
    return cell
  }
}

extension PrefetchingViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    let a = indexPaths.indices
    print(a)
    
    
  }
  
  
  
  
}




extension Array {
    subscript (safe index: Int) -> Element? {
      // iOS 9 or later
      
      //Range<Int>
        return indices ~= index ? self[index] : nil
        // iOS 8 or earlier
        // return startIndex <= index && index < endIndex ? self[index] : nil
        // return 0 <= index && index < self.count ? self[index] : nil
    }
}
