//
//  AudioManager.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 17.10.2022.
//

import AVFoundation
import UIKit

enum SoundEffect {
    case footsteps
    case jetPackFlying
    case beebWarning
    case laserRocket
    case laserMusic
    case laser
    case bonus
    
    var soundName: String {
        switch self {
        case .footsteps:
            return "running"
        case .jetPackFlying:
            return "jetpack"
        case .beebWarning:
            return "beepWarning"
        case .laserRocket:
            return "laserrocket"
        case .laserMusic:
            return "laserMusic"
        case .laser:
            return "laser"
        case .bonus:
            return "bonusClaim"
        }
    }
    
    var numberOfLoops: Int {
        switch self {
        case .footsteps:
            return -1
        case .jetPackFlying:
            return -1
        case .beebWarning:
            return -1
        case .laserRocket :
            return 0
        case .laserMusic :
            return 0
        case .laser :
            return -1
        case .bonus :
            return 0
        }
    }
    
    var volume: Float {
        switch self {
        case .footsteps:
            return 0.9
        case .jetPackFlying:
            return 0.3
        case .beebWarning:
            return 1
        case .laserRocket:
            return 1
        case .laserMusic:
            return 1
        case .laser:
            return 1
        case .bonus:
            return 1
        }
    }
}

class AudioManager {
    
    var isSilent: Bool = false {
        didSet {
            if isSilent {
                if let player = player,
                   player.isPlaying {
                    player.pause()
                }
            } else {
                player?.play()
            }
        }
    }
    
    var soundVolume:Float = 0.9 {
        didSet {
            characterPlayer?.volume = soundVolume
        }
    }
    
    var IsVibrationOn = true
    
    static let shared = AudioManager()
    private(set) var player: AVAudioPlayer?
    private(set) var characterPlayer: AVAudioPlayer?
    private(set) var soundPlayer: AVAudioPlayer?
    
    
    
    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "backgroundMusic",
                                        withExtension: "mp3") else { return }
        guard !isSilent else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.volume = 0.15
            player.numberOfLoops = -1
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSound(_ soundType: SoundEffect) {
        guard let url = Bundle.main.url(forResource: soundType.soundName,
                                        withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            soundPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = soundPlayer else { return }
            player.volume = soundVolume
            player.numberOfLoops = soundType.numberOfLoops
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func playCharacterSound(_ soundType: SoundEffect) {
        guard let url = Bundle.main.url(forResource: soundType.soundName,
                                        withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            characterPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = characterPlayer else { return }
            player.volume = soundVolume
            player.numberOfLoops = soundType.numberOfLoops
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func vibrate() {
        if IsVibrationOn {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
}
