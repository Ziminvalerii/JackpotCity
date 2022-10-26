//
//  LaserNode.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 19.10.2022.
//

import SpriteKit

class LaserNode: SKNode {
    
    
      init(with size:CGSize) {
         let texture1 = SKTexture(imageNamed:"laserLeft")
         let texture2 = SKTexture(imageNamed:"laserRight")
         let texture = SKTexture(imageNamed:"laser")
         
         super.init()
          let laser = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: size.width - 250, height: texture.size().height))
         laser.position = CGPoint.zero
          laser.name = "laser"
          laser.run(SKAction.fadeOut(withDuration: 0))
         addChild(laser)
         let leftNode = SKSpriteNode(texture: texture1, color: .clear, size: texture1.size())
          leftNode.position = CGPoint(x: -size.width, y: 0)
          leftNode.name = "laserLeft"
        
         addChild(leftNode)
         let rightNode = SKSpriteNode(texture: texture2, color: .clear, size: texture2.size())
          rightNode.name = "laserRight"
         rightNode.position = CGPoint(x: size.width, y: 0)
         
         addChild(rightNode)
         zPosition = 999
//          startAnimation(leftNode, rightNode, laser, complition: complition)

    }
    
    func startAnimation(complition: @escaping () -> Void) {
        let leftNode = childNode(withName: "laserLeft") as! SKSpriteNode
        let rightNode = childNode(withName: "laserRight") as! SKSpriteNode
        let laser = childNode(withName: "laser") as! SKSpriteNode
        
        leftNode.run(SKAction.moveTo(x: laser.position.x - laser.size.width/2 - leftNode.size.width/2, duration: 3))
        rightNode.run(SKAction.moveTo(x: laser.position.x + laser.size.width/2 + rightNode.size.width/2, duration: 3)) {
            AudioManager.shared.playSound(.laserMusic)
            laser.run(SKAction.fadeIn(withDuration: 1)) {
                AudioManager.shared.playSound(.laser)
                self.setUpPhysicBody(at: laser)
                self.createParticle(at: laser, isLaser: true)
                self.setUpPhysicBody(at: rightNode)
                self.createParticle(at: rightNode, isLaser: false)
                self.setUpPhysicBody(at: leftNode)
                self.createParticle(at: leftNode, isLaser: false)
                complition()
            }
            
        }
        
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
        let explosion = SKEmitterNode(fileNamed: "FireParticle")!
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
