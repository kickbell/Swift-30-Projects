//
//  SceneDelegate.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  var coordinator: SearchCoordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let navigationController = UINavigationController()
    navigationController.navigationBar.prefersLargeTitles = true
    
    coordinator = SearchCoordinator(navigationController: navigationController)
    coordinator?.start()
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }

}

