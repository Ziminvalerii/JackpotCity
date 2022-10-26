//
//  PhysicCategory.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 12.10.2022.
//

import UIKit


enum PhysicCategory {
    case boundary
    case player
    case obstacle
    case coin
    case rocket
    
    var rawValue: UInt32 {
        switch self {
        case .boundary:
            return 0x1 << 1
        case .player:
            return 0x1 << 2
        case .obstacle:
            return 0x1 << 3
        case .coin:
            return 0x1 << 4
        case .rocket:
            return 0x1 << 5
        }
    }
}

