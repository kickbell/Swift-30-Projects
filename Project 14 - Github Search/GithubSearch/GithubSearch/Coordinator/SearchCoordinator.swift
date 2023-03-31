//
//  SearchCoordinator.swift
//  GithubSearch
//
//  Created by jc.kim on 3/31/23.
//

import UIKit

class SearchCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  
  var navigationController: UINavigationController
  
  init(
    navigationController: UINavigationController
  ) {
    self.navigationController = navigationController
  }
  
  func start() {
    let searchViewController = SearchViewController()
    searchViewController.coordinator = self
    navigationController.pushViewController(searchViewController, animated: true)
  }
  
  func searchRepositories(query: String) {
    let detailViewController = DetailViewController(query: query)
    detailViewController.coordinator = self
    navigationController.pushViewController(detailViewController, animated: true)
  }
  
  func selectSearchOption(with options: [SearchOptionType], on viewController: UIViewController) {
    let searchOptionsController = SearchOptionsController(options: options)
    searchOptionsController.coordinator = self
    let navigationController = UINavigationController(rootViewController: searchOptionsController)
    viewController.present(navigationController, animated: true)
  }
  
  func didSelectSearchOption(with selectSearchOption: String, on viewController: UIViewController) {
    let detailViewController = DetailViewController()
    detailViewController.selectSearchOption = selectSearchOption
    viewController.dismiss(animated: true) { detailViewController.viewWillAppear(true) }
    //이렇게 처리하거나. 또는 디테일 뷰컨트롤러에서 특정 메소드를 실행해서 sorting을 reload하게 할수도있겠다.
  }
  
  func dismiss(on viewController: UIViewController) {
    viewController.dismiss(animated: true)
  }
  
}
