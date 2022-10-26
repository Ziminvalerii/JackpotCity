//
//  ObsctacleNode.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 19.10.2022.
//

import SpriteKit

class ObsctacleNode: SKNode {
    

    override init() {
        let texture1 = SKTexture(imageNamed:"laserLeft")
        let texture2 = SKTexture(imageNamed:"laserRight")
        let texture = SKTexture(imageNamed:"laser")
        
        super.init()
        let laser = SKSpriteNode(texture: texture, color: .clear, size: texture.size())
        laser.position = CGPoint.zero
        setUpPhysicBody(at: laser)
        createParticle(at: laser, isLaser: true)
        addChild(laser)
        let leftNode = SKSpriteNode(texture: texture1, color: .clear, size: texture1.size())
        leftNode.position = CGPoint(x: laser.position.x - laser.size.width/2 - leftNode.size.width/2, y: 0)
        setUpPhysicBody(at: leftNode)
        createParticle(at: leftNode, isLaser: false)
        addChild(leftNode)
        let rightNode = SKSpriteNode(texture: texture2, color: .clear, size: texture2.size())
        rightNode.position = CGPoint(x: laser.position.x + laser.size.width/2 + rightNode.size.width/2, y: 0)
        setUpPhysicBody(at: rightNode)
        createParticle(at: rightNode, isLaser: false)
        addChild(rightNode)
        zPosition = 999
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPhysicBody(at node: SKSpriteNode) {
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.pinned = true
        node.physicsBody?.collisionBitMask = 0
        node.physicsBody?.categoryBitMask = PhysicCategory.obstacle.rawValue
        node.physicsBody?.contactTestBitMask = PhysicCategory.player.rawValue
    }
    
    func createParticle(at node: SKSpriteNode, isLaser: Bool) {
        let explosion = SKEmitterNode(fileNamed: "SparkParticle")!
        if !isLaser {
            explosion.particleBirthRate = 100
            explosion.emissionAngle = CGFloat(0).degreesToRadians()
            explosion.emissionAngleRange = CGFloat(360).degreesToRadians()
        }
        explosion.particlePositionRange = CGVector(dx: node.size.width, dy: node.size.height)
        explosion.position = CGPoint.zero
        node.addChild(explosion)
    }
    
    func startRotating() {
        self.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(360).degreesToRadians(), duration: 2)))
    }
    
}
