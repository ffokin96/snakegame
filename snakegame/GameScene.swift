//
//  GameScene.swift
//  snakegame
//
//  Created by Максим Тимохин on 09.08.2020.
//  Copyright © 2020 Максим Тимохин. All rights reserved.
//

import SpriteKit
import GameplayKit

struct CollisionCategories {
    static let Snake: UInt32 = 1
    static let SnakeHead: UInt32 = 1 << 1
    static let Apple: UInt32 = 1 << 2
    static let EdgeBody: UInt32 = 1 << 3
}

class GameScene: SKScene {
    private let couterClockwiseButtomName = "couterClockwiseButtom"
    private let clockwiseButtomName = "clockwiseButtom"
    private var snake: Snake?
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.allowsRotation = false
        
        let couterClockwisePossition = CGPoint(x: frame.minX + 30, y: frame.minY + 30)
        let clockwisePossition = CGPoint(x: frame.maxX - 80, y: frame.minY + 30)
        
        addRotationButton(name: couterClockwiseButtomName, possirion: couterClockwisePossition)
        addRotationButton(name: clockwiseButtomName, possirion: clockwisePossition)
        
        snake = Snake(position: CGPoint(x: frame.midX, y: frame.midY))
        addChild(snake!)
        createApple()
        
        physicsWorld.contactDelegate = self
        physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
    }
    private func createApple() {
        let randX = CGFloat.random(in: 0..<frame.maxX - 5)
        let randY = CGFloat.random(in: 0..<frame.maxY - 5)
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        
        addChild(apple)
    }
    
    private func addRotationButton(name: String, possirion: CGPoint) {
        let button = SKShapeNode()
        button.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        
        button.position = position
        button.fillColor = .gray
        button.strokeColor = .gray
        button.lineWidth = 10
        button.name = name
        addChild(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchedNode = atPoint(touchLocation) as? SKShapeNode else {
                continue
            }
            if touchedNode.name == clockwiseButtomName {
                touchedNode.fillColor = .black
                snake?.moveClockWise()
            }
            else if touchedNode.name == couterClockwiseButtomName {
                touchedNode.fillColor = .red
                snake?.moveCounterClockWise()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchedNode = atPoint(touchLocation) as? SKShapeNode else {
                continue
            }
            if touchedNode.name == clockwiseButtomName {
                touchedNode.fillColor = .gray
            }
            else if touchedNode.name == couterClockwiseButtomName {
                touchedNode.fillColor = .gray
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        snake?.move()
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bytes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let collisionObject = bytes ^ CollisionCategories.SnakeHead
        
        switch collisionObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
            

        default:
            break
        }
    }
}
