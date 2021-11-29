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
  
  init() {
    //가로 10, 세로 20 크기의 2차원 배열 생성
    Variables.backarrays = Array(repeating: Array(repeating: 0, count: row), count: col)
    bg()
  }
  
  //백그라운드 이중배열에서 각 테두리에 1을 넣어주는 작업
  //즉, 1이 못움직이는거니까 벽을 만들어주는 작업이다.
  func bg() {
    for i in 0..<row {
      Variables.backarrays[col-1][i] = 1
    }
    for i in 0..<col-1{
      Variables.backarrays[i][0] = 1
    }
    for i in 0..<col-1 {
      Variables.backarrays[i][row-1] = 1
    }
    for i in 0..<row {
      Variables.backarrays[0][i] = 1
    }
  }
  
  
}
