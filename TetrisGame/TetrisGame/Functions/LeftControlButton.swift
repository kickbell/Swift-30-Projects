//
//  LeftButton.swift
//  TetrisGame
//
//  Created by jc.kim on 12/2/21.
//

import Foundation
import SpriteKit

//하단의 컨트롤 레프트 버튼을 말하는 것임
class LeftControlButton {
  let btn = SKSpriteNode()

  init() {
    btn.texture = SKTexture(imageNamed: "left_btn1")
    btn.size = CGSize(width: 50, height: 50)
    btn.name = "left"
    btn.position = CGPoint(x: 50, y: -Int(Variables.scene.frame.height) + 50)
    Variables.scene.addChild(btn)
  }
  
  func animate() {
    var textures = Array<SKTexture>()
    for i in 1...15 {
      let name = "left_btn\(i)"
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
      Variables.dx -= 1
      var action = SKAction()
//      brickArray는 현재 브릭의 cgpoint값
//      [(1.0, 1.0), (-1.0, 0.0), (0.0, 0.0), (1.0, 0.0)]
      for (i, item) in Variables.brickArrays.enumerated() {
        let x = Int(item.x) + Variables.dx
        let y = Int(item.y) + Variables.dy
        
        //블록 데이터 변경
        //위에서 Variables.dx -= 1 을했으니 X+1로 표시
        Variables.backarrays[y][x+1] -= 1 //그냥 단순하게 생각해. 먼저 바꾸기 이전값은 -=1 해준다.
        Variables.backarrays[y][x] += 1 //그리고 새로 바뀌는 값은 +=1 해준다.
        
        //블록 화면이동
        action = SKAction.moveBy(x: -(CGFloat(Variables.brickValue.brickSize)), y: 0, duration: 0.1)
        Variables.brickNode[i].run(action)
      }
    }
    //하단부 레프트 버튼 이동 애니메이션
    animate()
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

