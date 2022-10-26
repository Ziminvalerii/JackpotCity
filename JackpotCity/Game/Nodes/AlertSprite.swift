//
//  AlertSprite.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 18.10.2022.
//

import SpriteKit

class AlertSprite: SKSpriteNode {
    
    
    init() {
        let texture = SKTexture(imageNamed: "alert")
        super.init(texture: texture, color: .clear, size: CGSize(width: 64, height: 64))
        zPosition = 999
        name = "alert"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func followCharacter(_ followNode: SKSpriteNode, duration: TimeInterval, complition: @escaping () -> Void) {
        let customActionBlock: (SKNode, CGFloat)->Void = { (node, elapsedTime) in
            guard let scene = self.scene else {return}
            let nodeX = self.position.x - scene.size.width/2
            let nodeY =  self.position.y
            let dx = followNode.position.x - nodeX
            let dy = followNode.position.y - nodeY
            let angle = atan2(dx,dy)
            //                        node.position.x += angle*1.2
            node.position.y += cos(angle) * 4
            
        }
        let followPlayer = SKAction.customAction(withDuration:duration ,actionBlock:customActionBlock)
        self.run(followPlayer) {
            self.texture = SKTexture(imageNamed: "warning")
//            self.addGlow(radius: 10, color: .red)
            self.resizeAnimation(with: duration/2, complition: complition)
        }
        
    }
    
    func resizeAnimation(with duration: TimeInterval, complition: @escaping () -> Void) {
        AudioManager.shared.playSound(.beebWarning)
        let fadeOutAction = SKAction.fadeAlpha(to: 0.5, duration: 0.1)
        let fadeInAction = SKAction.fadeAlpha(to: 1, duration: 0.1)
        let increaseAction = SKAction.resize(byWidth: 10, height: 10, duration: 0.1)
        let decreaseAction = SKAction.resize(byWidth: -10, height: -10, duration: 0.1)
        let sequance = [increaseAction, decreaseAction]
        let alphaSequance = [fadeOutAction, fadeInAction]
//        SKAction.re
        self.run(SKAction.repeatForever(SKAction.sequence(sequance)), withKey: "pulse_size")
        self.run(SKAction.repeatForever(SKAction.sequence(alphaSequance)), withKey: "pulse_alpha")
        
        let waitAction = SKAction.wait(forDuration: duration)
        let removeAction = SKAction.run {
            self.removeAction(forKey: "pulse_size")
            self.removeAction(forKey: "pulse_alpha")
        }
        self.run(SKAction.sequence([waitAction, removeAction])) {
            AudioManager.shared.soundPlayer?.stop()
            complition()
        }
    }
    
    
}
