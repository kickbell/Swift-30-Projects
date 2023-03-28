//
//  ViewController.swift
//  SampleApp
//
//  Created by jc.kim on 3/27/23.
//

import UIKit
import Combine
import CommonUI
import NetworkImp

final class UserViewController: UITableViewController {
  
  // MARK: - Views
  
  private let activityIndicator: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView(style: .medium)
    activity.translatesAutoresizingMaskIntoConstraints = false
    activity.hidesWhenStopped = true
    activity.stopAnimating()
    return activity
  }()
  
  // MARK: - Propertis
  
  private var users: [User] = [] {
    didSet {
      updateUI()
    }
  }
  
  var coordinator: ListCoordinator?
  
  private let service = UserRepositoryImp(networkService: NetworkImp())
  
  
  // MARK: - LifeCycle
  
  init () {
    super.init(nibName: nil, bundle: nil)
    
    setupViews()
    fetchData()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupViews()
    fetchData()
  }
  
}

// MARK: - Method

extension UserViewController {
  
  private func setupViews() {
    title = "User Info"
    view.backgroundColor = .white
    view.addSubview(activityIndicator)
    tableView.register(cellType: UserCell.self)
    tableView.refreshControl = UIRefreshControl()
    tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
    ])
  }
  
  private func updateUI() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
      self.stopLoading()
      self.refreshControl?.endRefreshing()
    }
  }
  
  private func startLoading() {
    activityIndicator.startAnimating()
  }
  
  private func stopLoading() {
    activityIndicator.stopAnimating()
  }
  
  @objc
  private func refresh() {
    fetchData()
  }
  
  private func fetchData() {
    startLoading()
    
    Task(priority: .background) {
      let result = await service.users()
      switch result {
      case let .success(users):
        self.users = users
      case let .failure(error):
        self.alert(message: error.description)
        self.stopLoading()
      }
    }
  }
  
}

// MARK: - TableView

extension UserViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier) as? UserCell else {
      return UserCell()
    }
    cell.configure(with: users[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    coordinator?.detail(users[indexPath.row])
  }
  
}


