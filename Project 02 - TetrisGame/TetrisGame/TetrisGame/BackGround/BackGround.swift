//
//  BackGround.swift
//  TetrisGame
//
//  Created by jc.kim on 11/29/21.
//

import Foundation
import SpriteKit

class BackGround {
  
  let row = 10
  let col = 20
  let brickSize = Variables.brickValue.brickSize
  let gab = Variables.gab
  let scene = Variables.scene
  
  init() {
    //가로 10, 세로 20 크기의 2차원 배열 생성
    Variables.backarrays = Array(repeating: Array(repeating: 0, count: row), count: col)
    let xValue = ((Int(scene.frame.width) - row * brickSize) + brickSize) / 2
    let yValue = 100
    Variables.startPoint = CGPoint(x: xValue, y: yValue)
    bg()
  }
  
  //백그라운드 이중배열에서 각 테두리에 1을 넣어주는 작업
  //즉, 1이 못움직이는거니까 벽을 만들어주는 작업이다.
  func bg() {
    for i in 0..<row {
      Variables.backarrays[col-1][i] = 1
      Variables.scene.addChild(wall(x: i, y: col-1))
    }
    for i in 0..<col-1{
      Variables.backarrays[i][0] = 1
      Variables.scene.addChild(wall(x: 0, y: i))
    }
    for i in 0..<col-1 {
      Variables.backarrays[i][row-1] = 1
      Variables.scene.addChild(wall(x: row-1, y: i))
    }
    for i in 0..<row {
      Variables.backarrays[0][i] = 1
      Variables.scene.addChild(wall(x: i, y: 0))
    }
  }
  
  func wall(x: Int, y: Int) -> SKSpriteNode {
    let brick = SKSpriteNode()
    brick.size = CGSize(width: brickSize - gab, height: brickSize - gab)
    brick.color = .blue
    brick.name = "wall"
    brick.zPosition = 1
    let xValue = x * brickSize + Int(Variables.startPoint.x)
    let yValue = y * brickSize + Int(Variables.startPoint.y)
    brick.position = CGPoint(x: xValue, y: -yValue)
    return brick
  }
  
  
}
