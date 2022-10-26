//
//  RocketNode.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 18.10.2022.
//

import SpriteKit

class RocketNode: SKSpriteNode {

    init() {
        let texture = SKTexture(imageNamed: "rocketNode")
        super.init(texture: texture, color: .clear, size: CGSize(width: 132, height: 56))
        zPosition = 999
        rotationAction()
        setUpPhysicBody()
        addParticle()
    }
    
    func setUpPhysicBody() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
//        physicsBody?.pinned = true
        physicsBody?.collisionBitMask = 0
        physicsBody?.categoryBitMask = PhysicCategory.rocket.rawValue
        physicsBody?.contactTestBitMask = PhysicCategory.player.rawValue
    }
    
    func rotationAction() {
        let leftRotationAction = SKAction.rotate(toAngle: CGFloat(5).degreesToRadians(), duration: 0.15)
        let rightRotationActon = SKAction.rotate(toAngle: CGFloat(-5).degreesToRadians(), duration: 0.15)
        let rotateSequance = [leftRotationAction, rightRotationActon]
        self.run(SKAction.repeatForever(SKAction.sequence(rotateSequance)))
        
    }
    
    func addParticle() {
        let explosion = SKEmitterNode(fileNamed: "SmokeParticle")!
//         explosion.particlePositionRange = CGVector(dx: size.width/2, dy: size.height/2)
        explosion.position = CGPoint(x: size.width/2, y: 0)
        addChild(explosion)
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
