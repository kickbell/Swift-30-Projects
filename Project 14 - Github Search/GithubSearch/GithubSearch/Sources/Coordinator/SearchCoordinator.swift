//
//  SearchCoordinator.swift
//  GithubSearch
//
//  Created by jc.kim on 3/31/23.
//

import UIKit
import SafariServices

class SearchCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  
  var navigationController: UINavigationController
    
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let searchViewController = RecentSearchViewController()
    let service = RecentSearchServiceImp(repository: UserDefaultService())
    searchViewController.reactor = RecentSearchReactor(service: service)
    searchViewController.coordinator = self
    navigationController.pushViewController(searchViewController, animated: true)
  }
  
  func searchRepositories(_ queryItem: QueryItem) {
    let repositoryViewController = RepositoryViewController(with: queryItem)
    repositoryViewController.coordinator = self
    let network = NetworkImp()
    repositoryViewController.reactor = RepositoryReactor(service: RepositorySearchServiceImp(network: network))
    navigationController.navigationBar.prefersLargeTitles = false
    navigationController.pushViewController(repositoryViewController, animated: true)
  }
  
  func selectSearchOption(with options: [SearchOptionable], item queryItem: QueryItem?, on viewController: UIViewController) {
    let searchOptionsController = SearchOptionsController(options: options)
    searchOptionsController.coordinator = self
    searchOptionsController.queryItem = queryItem
    viewController.present(searchOptionsController, animated: true) {
      self.navigationController.popViewController(animated: false)
    }
  }
  
  func didSelectSearchOption(with queryItem: QueryItem, on viewController: UIViewController) {
    let repositoryViewController = RepositoryViewController()
    repositoryViewController.queryItem = queryItem
    repositoryViewController.coordinator = self
    let network = NetworkImp()
    repositoryViewController.reactor = RepositoryReactor(service: RepositorySearchServiceImp(network: network))
    navigationController.pushViewController(repositoryViewController, animated: false)
    viewController.dismiss(animated: true)
  }
  
  func repositoryItemSelected(with url: URL, on viewController: UIViewController) {
    let safiriViewController = SFSafariViewController(url: url)
    viewController.present(safiriViewController, animated: true)
  }
  
  func dismiss(on viewController: UIViewController) {
    viewController.dismiss(animated: true)
  }
  
}



