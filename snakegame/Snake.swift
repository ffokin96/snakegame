//
//  Snake.swift
//  snakegame
//
//  Created by Максим Тимохин on 11.08.2020.
//  Copyright © 2020 Максим Тимохин. All rights reserved.
//

import SpriteKit

class Snake: SKShapeNode {
    private var body = [SnakeBodyParth]()
    private let moveSpeed: CGFloat = 125.0
    private var angle: CGFloat  = 0.0
    convenience init(position: CGPoint) {
        self.init()
        
        let head = SnakeHead(possition: position)
        body.append(head)
        
        addChild(head)
    }
    func addBodyPart () {
        let newBodyPart = SnakeBodyParth(possition: body[0].position)
        body.append(newBodyPart)
        
        addChild(newBodyPart)
    }
    
    func moveClockWise() {
        angle += CGFloat.pi / 2
    }
    
    func moveCounterClockWise() {
         angle -= CGFloat.pi / 2
    }
    
    func move() {
        moveHead(body[0])
        
        for i in 1..<body.count {
            let previus = body[i - 1]
            let current = body[i]
            
            moveBodyPart(current, previous: previus)
        }
    }
    
    private func moveHead(_ head: SnakeBodyParth) {
        let dx = moveSpeed * sin(angle)
        let dy = moveSpeed * cos(angle)
        
        let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        head.run(moveAction)
    }
    
    func moveBodyPart  (_ part: SnakeBodyParth, previous: SnakeBodyParth) {
        let moveAction = SKAction.move(to: previous.position, duration: 0.1)
        
        part.run(moveAction)
    }
}
