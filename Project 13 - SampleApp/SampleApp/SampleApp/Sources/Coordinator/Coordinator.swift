//
//  Coordinator.swift
//  SampleApp
//
//  Created by jc.kim on 3/27/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
