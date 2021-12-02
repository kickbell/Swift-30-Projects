//
//  GameScene.swift
//  TetrisGame
//
//  Created by jc.kim on 11/29/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  var leftButton: LeftButton?
  
  override func didMove(to view: SKView) {
    Variables.scene = self
    _ = BackGround()
    _ = BrickGenerator()
    //      checkBrick()
    leftButton = LeftButton()
    
  }
  
  func checkBrick(){
    let arrays = Variables.backarrays
    for item in arrays {
      print(item)
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first
    let location = touch?.location(in: self)
    let node = nodes(at: location!)
    for item in node {
      if item.name == "left" {
        leftButton?.brickMoveLeft()
      }
    }
  }
}
