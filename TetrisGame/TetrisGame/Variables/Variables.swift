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
  static let gab = 1 //브릭 사이의 선
  static var startPoint = CGPoint()
  static var brickArrays = Array<CGPoint>() //브릭을 이동하기전에 그 브릭의 cgpoint값을 저장하기 위해서 만든 어레이
  static var brickNode = Array<SKSpriteNode>() //브릭을 화면에서 이동하기 위해 만든 어레이
}
