//
//  BackgroundNode.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 12.10.2022.
//

import SpriteKit

struct CoinModel {
    let iCont: Int
    let jCount: Int?
    let randomRandgeX : ClosedRange<CGFloat>
    let randomRandgeY: ClosedRange<CGFloat>
}


struct ObsctacleModel {
    let position: CGPoint
    let isRotating: Bool?
    let zRotation:CGFloat?
    let isCoin:CoinModel?
}

class BackgroundNode: SKSpriteNode {
    
    var moveActionSpeen:CGFloat = 1
    var duration: TimeInterval = 5
    var spawnRocket = Date()
    var spawnLaser = Date()
    var speedDate = Date()
    var backgroundSpeed: CGFloat = 0
    var isLaserShown:Bool = false
    

    let obsctacleModelArray: [[ObsctacleModel]] = [
        [ObsctacleModel(position: CGPoint(x: -525, y: 100), isRotating: false, zRotation: 0, isCoin: nil), ObsctacleModel(position: CGPoint(x: -22, y: -155), isRotating: false, zRotation: 0,isCoin: nil), ObsctacleModel(position: CGPoint(x: 502, y: 145), isRotating: false, zRotation: 0,isCoin: nil),
         ObsctacleModel(position: .zero, isRotating: nil, zRotation: nil, isCoin: CoinModel(iCont: 5, jCount: nil, randomRandgeX: CGFloat(-446)...CGFloat(55), randomRandgeY: CGFloat(158)...CGFloat(309))),
         ObsctacleModel(position: .zero, isRotating: nil, zRotation: nil, isCoin: CoinModel(iCont: 5, jCount: nil, randomRandgeX: CGFloat(-617)...CGFloat(-422), randomRandgeY: CGFloat(-310)...CGFloat(-131))),
         ObsctacleModel(position: .zero, isRotating: nil, zRotation: nil, isCoin: CoinModel(iCont: 5, jCount: nil, randomRandgeX: CGFloat(99)...CGFloat(300), randomRandgeY: CGFloat(-310)...CGFloat(-131))),
         ObsctacleModel(position: .zero, isRotating: nil, zRotation: nil, isCoin: CoinModel(iCont: 4, jCount: nil, randomRandgeX: CGFloat(-432)...CGFloat(-289), randomRandgeY: CGFloat(8)...CGFloat(180))),
         ObsctacleModel(position: .zero, isRotating: nil, zRotation: nil, isCoin: CoinModel(iCont: 4, jCount: nil, randomRandgeX: CGFloat(46)...CGFloat(242), randomRandgeY: CGFloat(8)...CGFloat(180)))],
        [ObsctacleModel(position: CGPoint(x: -278, y: 23), isRotating: true, zRotation: 0,isCoin: nil),
         ObsctacleModel(position: CGPoint(x: 378, y: 0), isRotating: false, zRotation: CGFloat(135).degreesToRadians(),isCoin: nil),
         ObsctacleModel(position: .zero, isRotating: nil, zRotation: nil, isCoin: CoinModel(iCont: 4, jCount: 2, randomRandgeX: CGFloat(-618)...CGFloat(-212), randomRandgeY: CGFloat(-249)...CGFloat(-111))),
         ObsctacleModel(position: .zero, isRotating: nil, zRotation: nil, isCoin: CoinModel(iCont: 5, jCount: 3, randomRandgeX: CGFloat(-68)...CGFloat(113), randomRandgeY: CGFloat(275)...CGFloat(324))),
         ObsctacleModel(position: .zero, isRotating: nil, zRotation: nil, isCoin: CoinModel(iCont: 5, jCount: 0, randomRandgeX: CGFloat(46)...CGFloat(233), randomRandgeY: CGFloat(-297)...CGFloat(-207)))
        ],
        [ObsctacleModel(position: CGPoint(x: -101, y: -182), isRotating: false, zRotation: CGFloat(90).degreesToRadians(),isCoin: nil), ObsctacleModel(position: CGPoint(x: 480, y: 232), isRotating: false, zRotation: CGFloat(90).degreesToRadians(),isCoin: nil),
         ObsctacleModel(position: .zero, isRotating: nil, zRotation: nil, isCoin: CoinModel(iCont: 6, jCount: 4, randomRandgeX: CGFloat(-617)...CGFloat(-123), randomRandgeY: CGFloat(76)...CGFloat(320))),
         ObsctacleModel(position: .zero, isRotating: nil, zRotation: nil, isCoin: CoinModel(iCont: 4, jCount: 0, randomRandgeX: CGFloat(235)...CGFloat(438), randomRandgeY: CGFloat(-263)...CGFloat(106)))
        ],
        [ObsctacleModel(position: CGPoint(x: -278, y: 23), isRotating: nil, zRotation: CGFloat(228).degreesToRadians(),isCoin: nil), ObsctacleModel(position: CGPoint(x: 315, y: 297), isRotating: nil, zRotation: 0,isCoin: nil),
         ObsctacleModel(position: .zero, isRotating: nil, zRotation: nil, isCoin: CoinModel(iCont: 4, jCount: nil, randomRandgeX: CGFloat(107)...CGFloat(420), randomRandgeY: CGFloat(-287)...CGFloat(-74)))
        ],
        [ObsctacleModel(position: CGPoint(x: 0, y: 0), isRotating: nil, zRotation: nil,isCoin: nil)],
        [ObsctacleModel(position: CGPoint(x: -514, y: 0), isRotating: nil, zRotation: nil,isCoin: nil), ObsctacleModel(position: CGPoint(x: 511, y: 0), isRotating: nil, zRotation: nil,isCoin: nil)]
    ]
    
    let startData = Data()
    private var coinArray = [CoinNode]()
    
    init(with size: CGSize) {
        super.init(texture: nil, color: .clear, size: size)
        
        for i in 0 ... 2 {
            let background = SKSpriteNode(imageNamed: "background1")
            if i == 1 {
                let obstacle = ObstacleSprite()
                obstacle.position = CGPoint.zero
                background.addChild(obstacle)
            }
            if i == 2 {
                spawnRectangleCoin(at: background, startPoint: CGPoint(x: background.size.width/2, y: 0), iCount: 4, jCount: 2)
            }
            background.size = CGSize(width:size.width , height:size.height)
            background.position = CGPoint(x: 0 + CGFloat(i*Int(background.size.width)), y:0)
            //            background.yScale = 0.5
            background.zPosition = 3
            
            background.name = "scroll_background"
            addChild(background)
        }
    }
    
    
    
    func spawnLineCoin(at background: SKSpriteNode, startPoint: CGPoint, iCount: Int) {
        let texure = SKTexture(imageNamed: "coinIcon")
        for i in 0 ... iCount {
            let coin = CoinNode()
            coin.position = CGPoint(x: startPoint.x + ((coin.size.width + 1) * CGFloat(i)), y: startPoint.y)
            coinArray.append(coin)
            background.addChild(coin)
        }
    }
    
    func spawnRectangleCoin(at background: SKSpriteNode, startPoint: CGPoint, iCount: Int, jCount: Int) {
        let texure = SKTexture(imageNamed: "coinIcon")
        for i in 0 ... iCount {
            for j in 0 ... jCount {
                let coin = CoinNode()
                coin.position = CGPoint(x: startPoint.x + ((coin.size.width + 1) * CGFloat(i)), y: startPoint.y + ((coin.size.height + 1) * CGFloat(j)))
                coinArray.append(coin)
                background.addChild(coin)
            }
        }
        
        //        let rectangle = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 300, height: 200))
        //        rectangle.ancp
    }
    
    func createObstacle() -> SKSpriteNode {
        let spriteNode = SKSpriteNode(imageNamed: "obstacle")
        spriteNode.position = .zero
        spriteNode.zPosition = 999
        spriteNode.physicsBody = SKPhysicsBody(rectangleOf: spriteNode.size)
        spriteNode.physicsBody?.isDynamic = false
        spriteNode.physicsBody?.affectedByGravity = false
        spriteNode.physicsBody?.allowsRotation = false
        spriteNode.physicsBody?.pinned = true
        spriteNode.physicsBody?.collisionBitMask = 0
        spriteNode.physicsBody?.categoryBitMask = PhysicCategory.obstacle.rawValue
        spriteNode.physicsBody?.contactTestBitMask = PhysicCategory.player.rawValue
        return spriteNode
        //       background.addChild(spriteNode)
    }
    
  
    
    func startAnimating(player: SKSpriteNode) {
        
        
        let backgroundNodes = self.children.filter({$0.name == "scroll_background"})
        for background in backgroundNodes {
            let moveAction = SKAction.move(by: CGVector(dx: -size.width, dy: 0), duration: 5)
            let  shipftbackground = SKAction.run {
                if background.position.x <= -(self.size.width) + 100 {
                    background.position.x = ((self.size.width)*2)
                    background.children.forEach { node in
                        node.removeFromParent()
                    }
                    //                    moveAction.speed += 1
                    self.spawnObscle(at: background as! SKSpriteNode)

                }
            }
            let scrollAction = SKAction.repeatForever(SKAction.sequence([moveAction, shipftbackground]))
            background.run(scrollAction, withKey: "background_scroll")
        }
    }
    
    func clearBackground() {
        let backgroundNodes = self.children.filter({$0.name == "scroll_background"})
        for background in backgroundNodes {
            background.children.forEach { node in
                node.run(SKAction.fadeOut(withDuration: 0.5)) {
                    node.removeFromParent()
                }
                
            }
        }
    }
    
    func stopAnimation() {
        let backgroundNodes = self.children.filter({$0.name == "scroll_background"})
        for background in backgroundNodes {
//            background.removeAction(forKey: "background_scroll")
            
            let action = background.action(forKey: "background_scroll")
            backgroundSpeed = action?.speed ?? 0.0
            action?.speed = 0
        }
    }
    
    func resumeAnimation() {
        let backgroundNodes = self.children.filter({$0.name == "scroll_background"})
        for background in backgroundNodes {
//            background.removeAction(forKey: "background_scroll")
            let action = background.action(forKey: "background_scroll")
            action?.speed = backgroundSpeed
        }
    }
    
    func getAllCoins() ->  [CoinNode] {
        var coinArray = [CoinNode]()
        let backgroundNodes = self.children.filter({$0.name == "scroll_background"}) as! [SKSpriteNode]
        for bg in backgroundNodes {
            let coinNodeArray =  bg.children.filter({$0.name == "coin"}) as! [CoinNode]
            coinArray.append(contentsOf: coinNodeArray)
        }
        return  coinArray
    }
    
    func spawnCoin(at bg:SKSpriteNode) {
        var randomX = CGFloat.random(in: -(bg.size.width/2) ... (bg.size.width/2 - 100))
        var randomY = CGFloat.random(in: -(bg.size.height/2) ... (bg.size.height/2 - 100))
        while (randomY > size.height/2 - 100 && randomY < -size.height/2 + 50) {
            randomX = CGFloat.random(in: -(bg.size.width/2) ... (bg.size.width/2 - 100))
            randomY = CGFloat.random(in: -(bg.size.height/2) ... (bg.size.height/2 - 100))
        }
        self.spawnLineCoin(at: bg, startPoint: CGPoint(x: randomX, y: randomY), iCount: 10)
        let coinNode = self.getAllCoins()
        for inode in coinNode {
            for jnode in coinNode {
                if inode != jnode {
                    if inode.intersects(jnode) {
                        print("intersects")
                    }
                }
            }
        }
    }
    
    func spawnObscle(at bg:SKSpriteNode) {
        let randomInt = Int.random(in: 0 ... obsctacleModelArray.count - 1)
        
        let randomObsctacleArray = obsctacleModelArray[randomInt]
        let obsctacleModel = randomObsctacleArray.filter({$0.isCoin == nil})
        
        for model in obsctacleModel {
            let obstacle = ObstacleSprite()
            obstacle.position = model.position
            if (model.isRotating ?? Bool.random()) {
                    obstacle.startRotating()
                } else {
                    obstacle.zRotation = model.zRotation ?? CGFloat.random(in: CGFloat(0).degreesToRadians() ... CGFloat(360).degreesToRadians())
                }
            bg.addChild(obstacle)
            }
        var coinArray = randomObsctacleArray.filter({$0.isCoin != nil})
        coinArray.shuffle()
        if !coinArray.isEmpty || coinArray.count != 0 {
            let randomCount = Int.random(in: 0...coinArray.count - 1)
            for i in 0 ... randomCount {
                if coinArray[i].isCoin?.jCount == nil {
                    let randomX = CGFloat.random(in: coinArray[i].isCoin!.randomRandgeX)
                    let randomY = CGFloat.random(in: coinArray[i].isCoin!.randomRandgeY)
                    spawnLineCoin(at: bg, startPoint: CGPoint(x: randomX, y: randomY), iCount: coinArray[i].isCoin!.iCont)
                } else {
                    let randomX = CGFloat.random(in: coinArray[i].isCoin!.randomRandgeX)
                    let randomY = CGFloat.random(in: coinArray[i].isCoin!.randomRandgeY)
                    //                spawnLineCoin(at: bg, startPoint: CGPoint(x: randomX, y: randomY), iCount: coinArray[i].isCoin!.iCont)
                    spawnRectangleCoin(at: bg, startPoint: CGPoint(x: randomX, y: randomY), iCount: coinArray[i].isCoin!.iCont, jCount: coinArray[i].isCoin!.jCount!)
                }
            }
            
        }
//        var randomX = CGFloat.random(in: -(bg.size.width/2) ... (bg.size.width/2 - 100))
//        var randomY = CGFloat.random(in: -(bg.size.height/2) ... (bg.size.height/2 - 100))
//        let obstacle = ObstacleSprite()
//        if Bool.random() {
//            obstacle.zRotation = CGFloat.random(in: CGFloat(0).degreesToRadians() ... CGFloat(360).degreesToRadians())
//
//        } else {
//            obstacle.startRotating()
//        }
//        obstacle.position = CGPoint(x: randomX, y: randomY)
//        bg.addChild(obstacle)
//        let coinNode = self.getAllCoins()
//
//        let array: [SKNode] = []
//        for i in coinNode {
//            while obstacle.intersects(i) {
//                randomX = CGFloat.random(in: -(bg.size.width/2) ... (bg.size.width/2 - 100))
//                randomY = CGFloat.random(in: -(bg.size.height/2) ... (bg.size.height/2 - 100))
//                obstacle.position = CGPoint(x: randomX, y: randomY)
//            }
//
//        }
        
    }
    
    
    func update(_ currentTime: TimeInterval, player: SKSpriteNode) {
        
        if Date() - speedDate > 10 {
            speedDate = Date()
            let backgroundNode = self.children.filter({$0.name == "scroll_background"})
            for background in backgroundNode {
                let action = background.action(forKey: "background_scroll")
                if action?.speed ?? 0.0 < 4 {
                    action?.speed += 0.1
//                    backgroundSpeed = action?.speed ?? 0.0
                }
            }
        }
        
        let backgroundNodes = self.children.filter({$0.name == "scroll_background"}) as! [SKSpriteNode]
        //        backgroundNodes.forEach { bg in
            if Date() - self.spawnLaser > 50 {
                self.spawnLaser = Date()
                if Bool.random() {
                    isLaserShown = true
                    self.clearBackground()
                    let laser = LaserNode(with: self.size)
                    self.addChild(laser)
                    laser.startAnimation {
                        let waitAction = SKAction.wait(forDuration: 3)
                        let deleteAction = SKAction.run {
                            laser.physicsBody?.contactTestBitMask = 0
                            laser.run(SKAction.fadeOut(withDuration: 1)) {
                                laser.removeFromParent()
                                AudioManager.shared.soundPlayer?.stop()
                                self.isLaserShown = false
                            }
                        }
                        laser.run(SKAction.sequence([waitAction,deleteAction]))
                    }
                    let posY = CGFloat.random(in: -self.size.height/2 + 100 ... self.size.height/2 - 100)
                    laser.position = CGPoint(x: 0, y: posY)

                    
                } else {
               
            }
            }
        if Date() - self.spawnRocket > 20 && !isLaserShown {
            self.spawnRocket = Date()
            if Bool.random() {
                let alert = AlertSprite()
                alert.position = CGPoint(x: self.size.width/2 - 100 , y: 0)
                self.addChild(alert)
                
                alert.followCharacter(player, duration: self.duration) {
                    let rocket = RocketNode()
                    rocket.position = CGPoint(x: self.size.width/2 + rocket.size.width/2, y: alert.position.y)
                    self.addChild(rocket)
                    //                    rocket.moveToX(-self.size.width/2 - rocket.size.width/2, duration: 5)
                    let moveAction = SKAction.moveTo(x: -self.size.width, duration: 3)
                    moveAction.speed = self.moveActionSpeen
                    rocket.run(moveAction)
                    print(alert.position.y)
                    alert.removeFromParent()
                }
            }
            if self.moveActionSpeen < 2 {
                self.moveActionSpeen += 0.1
            }
            if self.duration > 1.5 {
                self.duration -= 0.1
            }
        }
        for bg in backgroundNodes {
            if bg.position.x <= -(self.size.width) {
//                DispatchQueue.main.async {
//                    bg.position.x = ((self.size.width) * 2)
//                }
//                bg.children.forEach { node in
//                    node.removeFromParent()
//                }

//                let backgroundNode = self.children.filter({$0.name == "scroll_background"})
//                for background in backgroundNode {
//                    let action = background.action(forKey: "background_scroll")
//                    action?.speed += 0.01
//                }
//                spawnCoin(at: bg)
//                spawnObscle(at: bg)

//                if Date() - spawnRocket > 10 {
//                    spawnRocket = Date()
//                   if Bool.random() {
//                       let alert = AlertSprite()
//                       alert.position = CGPoint(x: self.size.width/2 - 100 , y: 0)
//                       self.addChild(alert)
//
//                       alert.followCharacter(player, duration: duration) {
//                           let rocket = RocketNode()
//                           rocket.position = CGPoint(x: self.size.width/2 + rocket.size.width/2, y: alert.position.y)
//                           self.addChild(rocket)
//       //                    rocket.moveToX(-self.size.width/2 - rocket.size.width/2, duration: 5)
//                        let moveAction = SKAction.moveTo(x: -self.size.width, duration: 3)
//                           moveAction.speed = self.moveActionSpeen
//                           rocket.run(moveAction)
//                           print(alert.position.y)
//                           alert.removeFromParent()
//                       }
//                    }
//                    if moveActionSpeen < 2 {
//                        moveActionSpeen += 0.1
//                    }
//                    if duration > 1.5 {
//                        duration -= 0.1
//                    }
//                }
                
                
                
                
                //                for i in 0..<coinNode.count {
                //                    for j in 0..<coinNode.count - 1 {
                //                        if coinNode[j].intersects(coinNode[j + 1]) {
                //                            print("intersects")
                //                        }
                //                    }
                //                }
                
//                                let alert = AlertSprite()
//                                alert.position = CGPoint(x: self.size.width/2 - 100 , y: 0)
//                                self.addChild(alert)
//                                alert.followCharacter(player) {
//                                    let rocket = RocketNode()
//                                    rocket.position = CGPoint(x: self.size.width/2 + rocket.size.width/2, y: alert.position.y)
//                                    self.addChild(rocket)
//                //                    rocket.moveToX(-self.size.width/2 - rocket.size.width/2, duration: 5)
//                                    rocket.run(SKAction.moveTo(x: -self.size.width, duration: 3))
//                                    print(alert.position.y)
//                                    alert.removeFromParent()
//
//                                }
//                                let laser = LaserNode(with: size)
//                                laser.startAnimation {
//                                    let waitAction = SKAction.wait(forDuration: 3)
//                                    let deleteAction = SKAction.run {
//                                        laser.run(SKAction.fadeOut(withDuration: 1)) {
//                                            laser.removeFromParent()
//                                        }
//                                    }
//                                    laser.run(SKAction.sequence([waitAction,deleteAction]))
//                                }
//                                laser.position = .zero
//
//                                self.addChild(laser)
                
                
                
                //                let obsctacle = createObstacle()
                //                obsctacle.position = CGPoint(x: -size.width/2, y: 0)
                //                bg.addChild(obsctacle)
                //
                //                let coinNodeArray = getAllCoins()
                //
                //                for i in coinNodeArray {
                //                    if obsctacle.intersects(i) {
                //                        print("obsctacle inside coin")
                //                    }
                //
                //                }
                
                
            }
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
