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
    for item in brick {
      let x = Int(item.x) + Variables.dx
      let y = Int(item.y) + Variables.dy
      Variables.backarrays[y][x] = 1
    }
  }
}
