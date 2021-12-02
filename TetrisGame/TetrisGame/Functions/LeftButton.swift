//
//  LeftButton.swift
//  TetrisGame
//
//  Created by jc.kim on 12/2/21.
//

import Foundation
import SpriteKit

class LeftButton {
  
  init() {
    let btn = SKSpriteNode()
    btn.texture = SKTexture(imageNamed: "left_btn1")
    btn.size = CGSize(width: 50, height: 50)
    btn.name = "left"
    btn.position = CGPoint(x: 50, y: -Int(Variables.scene.frame.height) + 50)
    Variables.scene.addChild(btn)
  }
  
  func brickMoveLeft() {
    if isMovale() {
      print(#function)
    }
  }
  
  //브릭의 제일 좌측 네모를 찾고 그것의 왼쪽이 1이면 이동불가, 0이면 이동가능
  func isMovale() -> Bool {
    //제일 좌측 포인트 찾기
    //걍 -1하면 안될까 싶었지만, 좌측으로 한칸 이동하면 -2,-3,-4가 되잖.
    var left = Variables.brickArrays[0]
    for i in Variables.brickArrays {
      if left.x > i.x {
        left = i
      }
    }
    
    //이동 가능 여부 판단
    //결국 시작점에서 -left.x 한 값이 0인지 1인지를 판별하는 것
    let startXValue = Variables.dx - 1 //시작x점, 배열이라 -1
    let xValue = Int(left.x) + startXValue //left.x값은 변동
    if Variables.backarrays[Variables.dy][xValue] != 0 {
      return false
    } else {
      return true
    }
  }
}
