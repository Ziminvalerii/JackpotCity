//
//  PlayerNode.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 12.10.2022.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
    var particle: SKEmitterNode?
     var isFlying:Bool = false
    private(set) var isAnimating = false
    private(set) var isDied = false
    private var isHitFloorAnimation = false
    
//    let hitTextures:[SKTexture] = [SKTexture(imageNamed: "playerDie1"), SKTexture(imageNamed: "playerDie2"), SKTexture(imageNamed: "playerDie3"), SKTexture(imageNamed: "playerDie4")]
//    let hitFloorTextures:[SKTexture] = [SKTexture(imageNamed: "playerDie5"), SKTexture(imageNamed: "playerDie6")]
//    let runningTextures:[SKTexture] = [SKTexture(imageNamed: "playerRun1"), SKTexture(imageNamed: "playerRun2"), SKTexture(imageNamed: "playerRun3"), SKTexture(imageNamed: "playerRun4"), SKTexture(imageNamed: "playerRun5"), SKTexture(imageNamed: "playerRun6"), SKTexture(imageNamed: "playerRun7")]
//    let jetpackTextures:[SKTexture] = [SKTexture(imageNamed: "playerJetpack1"), SKTexture(imageNamed: "playerJetpack2"), SKTexture(imageNamed: "playerJetpack3")]
    
    let playerModel = SettingsManager.currentPlayer
    
    init() {
        let texture = SKTexture(imageNamed: "playerRun5")
        super.init(texture: texture, color: .clear, size: CGSize(width: 72, height: 95))
        zPosition = 10
        setUpPhysicBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpPhysicBody() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.allowsRotation = false
        
        physicsBody?.contactTestBitMask = PhysicCategory.boundary.rawValue | PhysicCategory.coin.rawValue | PhysicCategory.rocket.rawValue
        physicsBody?.categoryBitMask = PhysicCategory.player.rawValue
        physicsBody?.collisionBitMask = PhysicCategory.boundary.rawValue
//        node.physicsBody?.restitution = 0.0
    }
    
    func startRunning() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: playerModel.runTexture,
                                     timePerFrame: 0.08,
                                     resize: false,
                                     restore: false)),
                         withKey:"running")
            AudioManager.shared.playCharacterSound(.footsteps)
    }
    
    func stopRunning() {
        removeAction(forKey: "running")
//        AudioManager.shared.soundPlayer?.stop()
    }
    
     func playerExplosion(completion: @escaping () -> Void) {
        let explosion = SKEmitterNode(fileNamed: "ExplosionParticle")!
         explosion.particlePositionRange = CGVector(dx: size.width/2, dy: size.height/2)
        explosion.position = CGPoint.zero
        addChild(explosion)
         let waitAction = SKAction.wait(forDuration: 0.5)
        let removeAction = SKAction.run {
            explosion.run(.fadeOut(withDuration: 0.1)) {
                explosion.removeFromParent()
            }
        }
        self.run(SKAction.sequence([waitAction, removeAction]), completion: completion)
    }
    
    private func createParticle() -> SKEmitterNode {
        let particle = SKEmitterNode(fileNamed: "snowParticle")!
        particle.position = CGPoint(x: -size.width/2, y: -size.height/2)
        particle.zPosition = 5
        return particle
    }
    
    func playerDied() {
        stopFlying()
        isDied = true
//        isAnimating = true
//                     withKey:"flying")
//        self.run(diedAnimation, withKey: "died")
        self.run(SKAction.setTexture( playerModel.dieTexture))
    }
    
    func hitfloor() {
        if !isHitFloorAnimation {
            isHitFloorAnimation = true
            //                     withKey:"flying")
//            self.run(diedAnimation, withKey: "hit_floor")
        }
    }
                                                                                        
     func fly() {
//         print("isFlying : \(isFlying)\n isDied: \(isDied)")
        guard isFlying else { return }
         guard !isDied else {return}
        stopRunning()
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 17))
         if !isAnimating {
             animateTextures()
         }
//        self.position.y += 1.5
    }
    
    func revivePlayer(complition: @escaping () -> Void) {
        isDied = false
        let explosion = SKEmitterNode(fileNamed: "SparkParticle")!
         explosion.particlePositionRange = CGVector(dx: size.width/2, dy: size.height/2)
        explosion.position = CGPoint.zero
        addChild(explosion)
         let waitAction = SKAction.wait(forDuration: 0.5)
        let removeAction = SKAction.run {
            explosion.run(.fadeOut(withDuration: 0.1)) {
                explosion.removeFromParent()
            }
        }
        self.run(SKAction.sequence([waitAction, removeAction])) {
            complition()
            self.startRunning()
            
        }
    }
    
    func animateTextures() {
        isAnimating = true
            AudioManager.shared.playCharacterSound(.jetPackFlying)
//        self.run(SKAction.repeatForever(
//            SKAction.animate(with: jetpackTextures,
//                                     timePerFrame: 0.1,
//                                     resize: true,
//                                     restore: false)),
//                         withKey:"flying")
        self.run(SKAction.setTexture( playerModel.flyTexture))
        particle = createParticle()
        addChild(particle!)
//        if self.parent != nil {
//            particle!.move(toParent: self.parent!)
//        }
    }
    
     func stopFlying() {
         AudioManager.shared.characterPlayer?.stop()
//         removeAction(forKey: "flying")
         particle?.run(.fadeOut(withDuration: 0.35)) {
             self.particle?.removeFromParent()
         }
        isFlying = false
         isAnimating = false
         
    }
}
