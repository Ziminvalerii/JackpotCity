//
//  SKSpriteNode.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 18.10.2022.
//

import SpriteKit


extension SKSpriteNode {
    func addGlow(radius: Float = 30, color: SKColor) {
            let effectNode = SKEffectNode()
            effectNode.shouldRasterize = true
            effectNode.position = .zero
            addChild(effectNode)
            let effect = SKSpriteNode(texture: texture)
            effect.color = color
//            effect.size = size
            effect.position = .zero
            effect.colorBlendFactor = 1
            effectNode.addChild(effect)
            effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius":radius])
        }
}
