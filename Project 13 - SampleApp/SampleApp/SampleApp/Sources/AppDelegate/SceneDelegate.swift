//
//  SceneDelegate.swift
//  SampleApp
//
//  Created by jc.kim on 3/27/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let listCoordinator = ListCoordinator(navigationController: UINavigationController())
    listCoordinator.start()
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = listCoordinator.navigationController
    window?.makeKeyAndVisible()
  }

}

