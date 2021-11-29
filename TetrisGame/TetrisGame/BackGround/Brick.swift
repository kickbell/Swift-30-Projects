//
//  Brick.swift
//  TetrisGame
//
//  Created by jc.kim on 11/29/21.
//

import Foundation
import SpriteKit

/*
 이런식으로 배경이 있는데 1이면 이동못하고,
 0이면 이동이 가능한 개념으로 진행할 것이다.
 
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 */

class Brick {
  
  struct Brick {
    var color = UIColor()
    var points = Array<CGPoint>()
    let brickSize = 35
    let zPosition = CGFloat(1)
    var brickName = String()
  }
  
  func bricks() -> Brick {
    var bricks = [Brick]()

    //이게 뭐냐면, 브릭을 만든건데
    //지금 만든 모양이 이거다.
    //[][][]
    //  []
    var brick1 = [CGPoint]()
    brick1.append(CGPoint(x: 0, y: 0))
    brick1.append(CGPoint(x: 1, y: 0))
    brick1.append(CGPoint(x: -1, y: 0))
    brick1.append(CGPoint(x: 0, y: 1))
    bricks.append(Brick(color: .red, points: brick1, brickName: "brick1"))
    
    //[][][][]
    var brick2 = [CGPoint]()
    brick2.append(CGPoint(x: -1, y: 0))
    brick2.append(CGPoint(x: 0, y: 0))
    brick2.append(CGPoint(x: 1, y: 0))
    brick2.append(CGPoint(x: 2, y: 0))
    bricks.append(Brick(color: .cyan, points: brick2, brickName: "brick2"))
    
    //  [][]
    //[][]
    var brick3 = [CGPoint]()
    brick3.append(CGPoint(x: 0, y: 0))
    brick3.append(CGPoint(x: 1, y: 0))
    brick3.append(CGPoint(x: 0, y: 1))
    brick3.append(CGPoint(x: -1, y: 1))
    bricks.append(Brick(color: .green, points: brick3, brickName: "brick3"))
    
    //[][][]
    //[]
    var brick4 = [CGPoint]()
    brick4.append(CGPoint(x: -1, y: 1))
    brick4.append(CGPoint(x: -1, y: 0))
    brick4.append(CGPoint(x: 0, y: 0))
    brick4.append(CGPoint(x: 1, y: 0))
    bricks.append(Brick(color: .purple, points: brick4, brickName: "brick4"))
    
    //[][]
    //[][]
    var brick5 = [CGPoint]()
    brick5.append(CGPoint(x: 1, y: 0))
    brick5.append(CGPoint(x: 0, y: 0))
    brick5.append(CGPoint(x: 0, y: 1))
    brick5.append(CGPoint(x: 1, y: 1))
    bricks.append(Brick(color: .orange, points: brick5, brickName: "brick5"))
    
    //[][][]
    //    []
    var brick6 = [CGPoint]()
    brick6.append(CGPoint(x: 1, y: 1))
    brick6.append(CGPoint(x: -1, y: 0))
    brick6.append(CGPoint(x: 0, y: 0))
    brick6.append(CGPoint(x: 1, y: 0))
    bricks.append(Brick(color: .yellow, points: brick6, brickName: "brick6"))
    
    //[][]
    //  [][]
    var brick7 = [CGPoint]()
    brick7.append(CGPoint(x: 0, y: 0))
    brick7.append(CGPoint(x: -1, y: 0))
    brick7.append(CGPoint(x: 0, y: 1))
    brick7.append(CGPoint(x: 1, y: 1))
    bricks.append(Brick(color: .systemPink, points: brick7, brickName: "brick7"))
    
    let random = Int.random(in: 0..<7)
    return bricks[random]
  }
  
}
