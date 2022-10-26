//
//  CGFloat.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 19.10.2022.
//

import UIKit



public extension CGFloat {
    func degreesToRadians() -> CGFloat {
     
     return CGFloat.pi * self / 180.0
   }
     
     
      func radiansToDegrees() -> CGFloat {
       return self * 180.0 / CGFloat.pi
     }
}
