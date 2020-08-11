//
//  SnakeBodyParth.swift
//  snakegame
//
//  Created by Максим Тимохин on 11.08.2020.
//  Copyright © 2020 Максим Тимохин. All rights reserved.
//

import SpriteKit

class SnakeBodyParth: SKShapeNode {
    
    init(possition: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        
        fillColor = .green
        strokeColor = .green
        lineWidth = 5
        self.position = position
        
        physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center: CGPoint(x: 5, y: 5))
        physicsBody?.isDynamic = true
        physicsBody?.collisionBitMask = CollisionCategories.SnakeHead
        physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
