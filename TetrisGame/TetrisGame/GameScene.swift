//
//  GameScene.swift
//  TetrisGame
//
//  Created by jc.kim on 11/29/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
      Variables.scene = self
      _ = BackGround()
      _ = BrickGenerator()
//      checkBrick()
      _ = LeftButton()
      
    }
  
  func checkBrick(){
    let arrays = Variables.backarrays
    for item in arrays {
      print(item)
    }
  }
    
}
