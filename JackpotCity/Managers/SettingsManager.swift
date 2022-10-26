//
//  SettingsManager.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 17.10.2022.
//

import Foundation
import GameKit

class SettingsManager {
    
    enum Key {
        static let boughtPlayer = "bought_players"
        static let coinCount = "current_coin_count"
        static let bestScore = "best_score"
        static let currentIndex = "current_character_index"
        static let dailyBonusDate = "dailyBonusDate"
    }
    
    static let playersArr:[CharacterModel] = [CharacterModel(index: 0, price: 0),
                                              CharacterModel(index: 1, price: 100),
                                              CharacterModel(index: 2, price: 250),
                                              CharacterModel(index: 3, price: 500),
                                              CharacterModel(index: 4, price: 1000),
                                              CharacterModel(index: 5, price: 2000)]
    
    static var currentPlayer: CharacterModel {
        return playersArr[selectedIndex]
    }
    
    static var selectedIndex: Int {
        get {
            UserDefaults.standard.integer(forKey: Key.currentIndex)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.currentIndex)
        }
    }
    
    static var boughtPlayers:[CharacterModel] {
        get {
            var availableAmplifiers = [CharacterModel]()
            let arr = UserDefaults.standard.object(forKey: Key.boughtPlayer) as? Data ?? Data()
            let data = try? JSONDecoder().decode([CharacterModel].self, from: arr)
            if data == nil || data?.isEmpty ?? true || data?.count == 0 {
                let arr = [playersArr[0]]
                availableAmplifiers = arr
            }
            if let data = data {
                for character in data {
                    availableAmplifiers.append(character)
                }
            }
            return availableAmplifiers
        }
        set {
            var players = [CharacterModel]()
            for item in newValue {
                players.append(item)
            }
            //            if players.count == 0 {
            //                players.append(playersArr[0])
            //            }
            let data = try? JSONEncoder().encode(players)
            UserDefaults.standard.set(data, forKey: Key.boughtPlayer)
            //            if avAmplifiers.count == 0 {
            //                avAmplifiers.append(Amplifier.curCharacter.rawValue)
            //            }
            //            UserDefaults.standard.set(, forKey: "characters")
        }
    }
    
    static var currentCoin: Int {
        get {
            UserDefaults.standard.integer(forKey: Key.coinCount)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.coinCount)
        }
    }
    
    static var dailyBonusDate: Date? {
        get {
            UserDefaults.standard.value(forKey: Key.dailyBonusDate) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.dailyBonusDate)
        }
    }
    
    static var bestScore: Int {
        get {
            UserDefaults.standard.integer(forKey: Key.bestScore)
        }
        set {
            if newValue > bestScore {
                UserDefaults.standard.set(newValue, forKey: Key.bestScore)
                if GKLocalPlayer.local.isAuthenticated {
                    let scoreReporter = GKScore(leaderboardIdentifier: "com.flywings.cityQuest.Leaderboard")
                    scoreReporter.value = Int64(newValue)
                    GKScore.report([scoreReporter])
                }
                
            }
        }
    }
}
