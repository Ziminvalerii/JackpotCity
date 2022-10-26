//
//  ObstacleSprite.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 19.10.2022.
//

import SpriteKit

class ObstacleSprite: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "obstacle")
        super.init(texture: texture, color: .clear, size: CGSize(width: 30, height: 250))
        zPosition = 999
        name = "laser_obstacle"
//        self.addGlow(color: .white)
        setUpPhysicBody()
        createParticle()
//        startRotating()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPhysicBody() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.pinned = true
        physicsBody?.collisionBitMask = 0
        physicsBody?.categoryBitMask = PhysicCategory.obstacle.rawValue
        physicsBody?.contactTestBitMask = PhysicCategory.player.rawValue
    }
    
    func startRotating() {
        self.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(360).degreesToRadians(), duration: 2)))
    }
    
    func createParticle() {
        let explosion = SKEmitterNode(fileNamed: "SparkParticle")!
//        if !isLaser {
//            explosion.particleBirthRate = 100
//            explosion.emissionAngle = CGFloat(0).degreesToRadians()
//            explosion.emissionAngleRange = CGFloat(360).degreesToRadians()
//        }
        explosion.particlePositionRange = CGVector(dx: size.width/4, dy: size.height - 24)
        explosion.position = CGPoint.zero
        addChild(explosion)
    }
}
