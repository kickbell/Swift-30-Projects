//
//  BrickGenerator.swift
//  TetrisGame
//
//  Created by jc.kim on 11/30/21.
//

import Foundation
import SpriteKit

class BrickGenerator {
  
  let brickValue = Variables.brickValue
  
  init() {
    let brick = brickValue.points
    Variables.brickArrays = brick
    for item in brick {
      let x = Int(item.x) + Variables.dx
      let y = Int(item.y) + Variables.dy
      Variables.backarrays[y][x] = 1 //전체 이중배열중에서 x,y값에 해당하는 곳을 1로 바꿔라.
      
      //화면에 그리기
      let xValue = x * brickValue.brickSize + Int(Variables.startPoint.x)
      let yValue = y * brickValue.brickSize + Int(Variables.startPoint.y)
      let brick = SKSpriteNode()
      brick.color = brickValue.color
      brick.size = CGSize(width: brickValue.brickSize - Variables.gab, height: brickValue.brickSize - Variables.gab)
      brick.name = brickValue.brickName
      brick.zPosition = brickValue.zPosition
      brick.position = CGPoint(x: xValue, y: -yValue)
      Variables.scene.addChild(brick)
    }
  }
}
