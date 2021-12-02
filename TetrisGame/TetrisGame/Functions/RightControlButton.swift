//
//  RightButton.swift
//  TetrisGame
//
//  Created by jc.kim on 12/2/21.
//

import Foundation
import SpriteKit

//하단의 컨트롤 라이트 버튼을 말하는 것임
//상세한 주석은 LeftControlButton에 있음.
class RightControlButton {
  let btn = SKSpriteNode()

  init() {
    btn.texture = SKTexture(imageNamed: "right_btn1")
    btn.size = CGSize(width: 50, height: 50)
    btn.name = "right"
    btn.position = CGPoint(x: Int(Variables.scene.frame.width) - 50, y: -Int(Variables.scene.frame.height) + 50)
    Variables.scene.addChild(btn)
  }
  
  func animate() {
    var textures = Array<SKTexture>()
    for i in 1...15 {
      let name = "right_btn\(i)"
      let texture = SKTexture(imageNamed: name)
      textures.append(texture)
    }
    let action = SKAction.animate(with: textures, timePerFrame: 0.03)
    btn.run(action)
  }
  
  func brickMoveLeft() {
    defer {
      checkBrick() //데이터 잘 변하고 있나 테스트
    }
    
    if isMovale() {
      Variables.dx += 1
      var action = SKAction()
      
      for (i, item) in Variables.brickArrays.enumerated() {
        let x = Int(item.x) + Variables.dx
        let y = Int(item.y) + Variables.dy
        
        //블록 데이터 변경
        Variables.backarrays[y][x-1] -= 1
        Variables.backarrays[y][x] += 1
        
        //블록 화면이동
        action = SKAction.moveBy(x: +(CGFloat(Variables.brickValue.brickSize)), y: 0, duration: 0.1)
        Variables.brickNode[i].run(action)
      }
    }
    //하단부 레프트 버튼 이동 애니메이션
    animate()
  }
  
  //브릭의 제일 좌측 네모를 찾고 그것의 왼쪽이 1이면 이동불가, 0이면 이동가능
  func isMovale() -> Bool {
    //제일 좌측 포인트 찾기
    var right = Variables.brickArrays[0]
    for i in Variables.brickArrays {
      if right.x < i.x {
        right = i
      }
    }
    
    //이동 가능 여부 판단
    let startXValue = Variables.dx + 1
    let xValue = Int(right.x) + startXValue
    if Variables.backarrays[Variables.dy][xValue] != 0 {
      return false
    } else {
      return true
    }
  }
}
