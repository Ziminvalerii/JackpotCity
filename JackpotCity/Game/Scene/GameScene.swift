//
//  GameScene.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 12.10.2022.
//

import SpriteKit
import GameplayKit

protocol GameOverDelegate: AnyObject {
    func gameOver()
    func updateCoin(with cointCount: Int)
    func updateCurrentScore(with timeInterval: TimeInterval)
}


class GameScene: SKScene {
    
    
    weak var gameDelegate: GameOverDelegate?
    weak var parentVC: UIViewController?
    let startDate = Date()
    var currTimeInterval: TimeInterval = 0.0
    
    private lazy var player:PlayerNode = {
        let player = PlayerNode()
        player.position = CGPoint(x: -size.width/2+10, y: -100)
        return player
    }()
    
    private lazy var backgroundNode: BackgroundNode = {
        let background = BackgroundNode(with: size)
        return background
    }()

    override func didMove(to view: SKView) {
        scene?.addChild(backgroundNode)
        setUpPhysicWorld()
        self.addChild(self.player)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.playerRunning()
        }
        let wait = SKAction.wait(forDuration: 0.1)
        let block = SKAction.run { [weak self] in
            guard let self = self else { return }
            self.updateTimer()
        }
        let sequance = SKAction.sequence([wait, block])
        run(SKAction.repeatForever(sequance), withKey: "timer")
    }
    
    func pauseTimer() {
        let action = action(forKey: "timer")
        action?.speed = 0
    }
    
    func resumeTimer() {
        let action = action(forKey: "timer")
        action?.speed = 1
    }
    
    func revivePlayer() {
        pauseTimer()
        player.revivePlayer {
            self.resumeTimer()
            self.backgroundNode.resumeAnimation()
        }
    }

        
    
    private func updateTimer() {
        currTimeInterval += 0.1
        gameDelegate?.updateCurrentScore(with: currTimeInterval * 10)
    }
    
    func playerRunning() {
        let moveAction = SKAction.moveTo(x: 0, duration: 3)
        player.run(moveAction) {
            self.backgroundNode.startAnimating(player: self.player)
        }
    }
    
    
    private func setUpPhysicWorld () {
        scene?.physicsWorld.gravity = CGVector(dx: 0.0, dy: -8.0)
        let phycycsRect = CGRect(origin: CGPoint(x: self.frame.origin.x, y: self.frame.origin.y+100), size: CGSize(width: self.frame.width, height: self.frame.height - 150))
        scene?.physicsBody = SKPhysicsBody(edgeLoopFrom: phycycsRect)
        physicsBody?.categoryBitMask = PhysicCategory.boundary.rawValue
        physicsBody?.contactTestBitMask = PhysicCategory.player.rawValue
        scene?.physicsWorld.contactDelegate = self
    }
    
    
    
  //MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
        player.isFlying = true
//        player.fly()
      
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopFlying()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopFlying()
    }
    
    //MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
//        print("Current time: \(currentTime)")
//        gameDelegate?.updateCurrentScore(with: Date().timeIntervalSince(startDate))
        backgroundNode.update(currentTime, player: player)
        player.fly()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let collision:UInt32 = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
        let player = PhysicCategory.player.rawValue
        if collision == (player | PhysicCategory.boundary.rawValue) {
            if self.player.position.y < 0 {
                if self.player.isDied {
//                    self.player.hitfloor()
                    self.backgroundNode.stopAnimation()
                    gameDelegate?.gameOver()
                } else {
                    self.player.startRunning()
                }
            }
        }
        if collision == (player | PhysicCategory.obstacle.rawValue) {
            AudioManager.shared.playSound(.laserRocket)
            AudioManager.shared.vibrate()
            self.player.playerExplosion {
            }
            self.player.playerDied()
            if self.player.position.y <= -224 {
                self.player.hitfloor()
                self.backgroundNode.stopAnimation()
                gameDelegate?.gameOver()
            }
        }
        if collision == (player | PhysicCategory.coin.rawValue) {
            (contact.bodyA.node as? CoinNode)?.removeFromParent()
            (contact.bodyB.node as? CoinNode)?.removeFromParent()
            let coinCollectedSound = SKAction.playSoundFileNamed("collectCoin.mp3", waitForCompletion: false)
            run(coinCollectedSound)
            SettingsManager.currentCoin += 1
            gameDelegate?.updateCoin(with: SettingsManager.currentCoin)
//            AudioManager.shared.vibrate()
            
        }
        if collision == (player | PhysicCategory.rocket.rawValue) {
            (contact.bodyA.node as? RocketNode)?.removeFromParent()
            (contact.bodyB.node as? RocketNode)?.removeFromParent()
            AudioManager.shared.playSound(.laserRocket)
            AudioManager.shared.vibrate()
            self.player.playerExplosion {
            }
                self.player.playerDied()
            if self.player.position.y <= -224 {
                self.player.hitfloor()
                self.backgroundNode.stopAnimation()
                gameDelegate?.gameOver()
            }
//            gameOverDelegate?.gameOver()
            
        }
    }
}




    
    
    

