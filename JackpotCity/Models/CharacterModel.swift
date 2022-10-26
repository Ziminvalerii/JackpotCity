//
//  CharacterModel.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 17.10.2022.
//

import SpriteKit


struct CharacterModel: Codable {
    public let index: Int
    public var image: UIImage? {
        return UIImage(named: "player\(index)")
    }
    public let price: Int
    
    public var runTexture: [SKTexture] {
        var texureArray = [SKTexture]()
        for i in 0 ... 7 {
            let texture = SKTexture(imageNamed: "playerRun\(index)\(i)")
            texureArray.append(texture)
        }
        return texureArray
    }
    
    public var dieTexture: SKTexture {
        return SKTexture(imageNamed: "diePlayer\(index)")
    }
    
    public var flyTexture: SKTexture {
        return SKTexture(imageNamed: "flyplayer\(index)")
    }
}
