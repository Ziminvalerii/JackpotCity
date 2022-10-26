//
//  CoinNode.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 18.10.2022.
//

import SpriteKit

class CoinNode: SKSpriteNode {


    var textures:[SKTexture] = [SKTexture]()
    
    init() {
        for i in 1 ... 7 {
            textures.append(SKTexture(imageNamed: "coin\(i)"))
        }
        for index in stride(from: 7, through: 1, by: -1) {
            textures.append(SKTexture(imageNamed: "coin\(index)"))
        }
        let texure = SKTexture(imageNamed: "coinIcon")
        super.init(texture: texure, color: .clear, size: CGSize(width: 58, height: 64))
        name = "coin"
        zPosition = 999
        animateTextures()
        setUpPhysicBody()
    }
    
    func setUpPhysicBody() {
        physicsBody = SKPhysicsBody(circleOfRadius: size.height/2)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.pinned = true
//        physicsBody?.collisionBitMask = 0
        physicsBody?.categoryBitMask = PhysicCategory.coin.rawValue
        physicsBody?.contactTestBitMask = PhysicCategory.player.rawValue
    }
    
    func animateTextures() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: textures,
                                     timePerFrame: 0.07,
                                     resize: false,
                                     restore: true)),
                         withKey:"spinning")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
