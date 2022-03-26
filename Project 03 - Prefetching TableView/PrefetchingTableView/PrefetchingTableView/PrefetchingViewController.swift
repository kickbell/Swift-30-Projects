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
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 300
    return tableView
  }()
  
  private let viewModel = (1...100).map { "row \($0)" }
  
  private let url = "https://source.unsplash.com/random/\(300)x\(300)"

  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    addConstraints()
    setupViews()
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
  }
}


extension PrefetchingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = viewModel[indexPath.row]
    return cell
  }
}

