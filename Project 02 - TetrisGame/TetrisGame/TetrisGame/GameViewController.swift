//
//  GameViewController.swift
//  TetrisGame
//
//  Created by jc.kim on 11/29/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let view = self.view as! SKView? {
      // Load the SKScene from 'GameScene.sks'
      let scene = GameScene(size: view.frame.size)
      // Set the scale mode to scale to fit the window
      scene.scaleMode = .aspectFill
      scene.anchorPoint = CGPoint(x: 0, y: 1) //앵커 포인트 왼쪽상단 지정
      // Present the scene
      view.presentScene(scene)
      
      
      view.ignoresSiblingOrder = true
      
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
