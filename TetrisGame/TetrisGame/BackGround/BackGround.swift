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
  }
}
