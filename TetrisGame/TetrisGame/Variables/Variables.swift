//
//  Variables.swift
//  TetrisGame
//
//  Created by jc.kim on 11/29/21.
//

import Foundation
import SpriteKit

struct Variables {
  static var backarrays = [[Int]]()
  static var scene = SKScene()
  static var brickValue = Brick().bricks()
  static var dx = 4 //x의 시작점
  static var dy = 2 //y의 시작점
}
