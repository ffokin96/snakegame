//
//  SnakeHead.swift
//  snakegame
//
//  Created by Максим Тимохин on 11.08.2020.
//  Copyright © 2020 Максим Тимохин. All rights reserved.
//

import SpriteKit

class SnakeHead: SnakeBodyParth {
    override init(possition: CGPoint) {
        super.init(possition: possition)
        
        physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple | CollisionCategories.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
