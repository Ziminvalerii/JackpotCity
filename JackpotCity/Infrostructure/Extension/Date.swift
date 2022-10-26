//
//  Date.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 21.10.2022.
//

import Foundation

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
