//
//  Coordinator.swift
//  GithubSearch
//
//  Created by jc.kim on 3/31/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
