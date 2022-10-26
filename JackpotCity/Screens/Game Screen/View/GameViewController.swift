//
//  GameViewController.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 12.10.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: BaseViewController<GamePresenter>, GameView {
    
    @IBOutlet weak var coinLabel: UILabel! {
        didSet {
            coinLabel.text = SettingsManager.currentCoin.description
        }
    }
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel! {
        didSet {
            bestScoreLabel.text = SettingsManager.bestScore.description
        }
    }
    @IBOutlet weak var pauseButton: UIButton!
    var pauseView: PauseView?
    var gameOverView: GameOverView?
    //    weak var gameSceneDelegate: GameSceneDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        startView = StartView(frame: view.bounds)
        //        startView?.delegate = self
        //        view.addSubview(startView!)
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                if let scene = scene as? GameScene {
                    scene.gameDelegate = self
                    //                    gameSceneDelegate = scene
                }
                //                scene.size = view.bounds.size
                // Present the scene
                view.presentScene(scene)
            }
            //            view.isPaused = true
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        AudioManager.shared.soundPlayer?.stop()
        AudioManager.shared.characterPlayer?.pause()
        pauseView = PauseView(frame: view.bounds)
        let gameView = self.view as! SKView
        gameView.isPaused = true
        pauseView?.delegate = self
        view.addSubview(pauseView!)
        self.animateIn(pauseView!)
    }
    
    
    private func animateIn(_ view: UIView) {
        view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        view.alpha = 0
        UIView.animate(withDuration: 0.4) {
            view.alpha = 1
            view.transform = CGAffineTransform.identity
        }
    }
    
    private func animateOut(_ view : UIView, complition: @escaping () -> Void) {
        UIView.animate(withDuration: 0.4) {
            view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            view.alpha = 0
        } completion: { (_) in
            view.removeFromSuperview()
            complition()
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension GameViewController: GameOverDelegate {
    func gameOver() {
        pauseButton.isEnabled = false
        AudioManager.shared.soundPlayer?.stop()
        AudioManager.shared.characterPlayer?.stop()
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        gameOverView = GameOverView(frame: self.view.bounds)
        gameOverView!.delegate = self
        let gameView = self.view as! SKView
        gameView.isPaused = true
        self.view.addSubview(gameOverView!)
        gameOverView!.animateView()
        self.animateIn(gameOverView!)
        //            UIView.animate(withDuration: 5, delay: 0) {
        //                gameOverView.progressView.setProgress(0, animated: true)
        //            }
        gameOverView!.progressView.setAnimatedProgress(progress: 0, duration: 400) {
            if !self.gameOverView!.isReborn {
                let intValue = Int(self.currentScoreLabel.text ?? "0")
                SettingsManager.bestScore = intValue ?? 0
                self.presenter.dismissVC(self)
            }
        }
        //        }
    }
    
    
}

extension GameViewController: PauseViewDelegate {
    func resumeButtonPressed() {
        animateOut(pauseView!) {
            let gameView = self.view as! SKView
            gameView.isPaused = false
            AudioManager.shared.characterPlayer?.play()
        }
    }
    
    func homeButtonPressed() {
        let intValue = Int(self.currentScoreLabel.text ?? "0") ?? 0
        SettingsManager.bestScore = intValue
        presenter.dismissVC(self)
    }
    
    func updateCoin(with cointCount: Int) {
        coinLabel.text = cointCount.description
    }
    
    func updateCurrentScore(with timeInterval: TimeInterval) {
        currentScoreLabel.text = Int(timeInterval).description
    }
    
}

extension GameViewController: GameOverViewDelegate {
    func heartButtonPressed() {
        if SettingsManager.currentCoin >= 1000 {
            SettingsManager.currentCoin -= 1000
            gameOverView?.isReborn = true
            let gameScene = view as! SKView
            if let scene = gameScene.scene as? GameScene {
                gameOverView?.progressView.progress = 0
                animateOut(gameOverView!) {
                    self.pauseButton.isEnabled = true
                    gameScene.isPaused = false
                    AudioManager.shared.characterPlayer?.play()
                    scene.revivePlayer()
                }
            }
        } else {
            gameOverView?.animateErrorLabel()
        }
        
    }
    
    
}
