//
//  SceneDelegate.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let navigationController = UINavigationController(rootViewController: SearchViewController())
    navigationController.navigationBar.prefersLargeTitles = true
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }

}

