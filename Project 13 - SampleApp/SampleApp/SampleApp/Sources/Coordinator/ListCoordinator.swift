//
//  StoreCoordinator.swift
//  SampleApp
//
//  Created by jc.kim on 3/27/23.
//

import Foundation
import UIKit

class ListCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    
    setupViews()
  }
  
  private func setupViews() {
    self.navigationController.navigationBar.prefersLargeTitles = true
  }
  
  func start() {
    let vc = UserViewController()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }
  
  func detail(_ user: User) {
    let vc = DetailViewController(user: user)
    navigationController.pushViewController(vc, animated: true)
  }
}
