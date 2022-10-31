//
//  StartViewController.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 17.10.2022.
//

import UIKit
import GameKit

class StartViewController: BaseViewController<StartPresenterProtocol>, StartsView, GKGameCenterControllerDelegate {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bonusButton: UIButton!
    @IBOutlet weak var bestScoreLabel: UILabel!
    var shopLeftConstraint: NSLayoutConstraint?
    @IBOutlet weak var playButton: UIButton! {
        didSet {
//            playButton.animateShaking()
//            playButton.contentMode = .
//            playButton.doGlowAnimation(withColor: .white, withEffect: .big)
        }
    }
    
    lazy var optionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("OPTIONS", for: .normal)
        button.setBackgroundImage(UIImage(named: "rectagleButton"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Copperplate Bold", size: 20)!
        button.addTarget(self, action: #selector(optionsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @IBOutlet weak var settingsButton: UIButton! {
        didSet {
//            settingsButton.animatePulse()
        }
    }
    @IBOutlet weak var shopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shopLeftConstraint = view.constraints.first(where: {$0.identifier == "stackViewCenterX"})
        stackView.insertArrangedSubview(optionsButton, at: 2)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        shopLeftConstraint?.constant += view.bounds.size.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isBonusEnabled = SettingsManager.dailyBonusDate == nil || (Date() - (SettingsManager.dailyBonusDate ?? Date())) > 24*60*60
            bonusButton.isEnabled = isBonusEnabled
            bonusButton.alpha = isBonusEnabled ? 1 : 0.75
        bestScoreLabel.text = "BEST SCORE: \(SettingsManager.bestScore)"
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.shopLeftConstraint?.constant = 0
            self.view.layoutIfNeeded()
        } completion: { success in
            if success {
//                self.playButton.animateShaking()
//                self.playButton.doGlowAnimation(withColor: .white, withEffect: .big)
            } 
        }
    }
    
    @objc func optionsButtonPressed() {
        presenter.goToSettingsVC(at: self)
    }
    
    @IBAction func bonusButtonPressed(_ sender: Any) {
        presenter.goToDailyVC(at: self, delegate: self)
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        AudioManager.shared.vibrate()
        presenter.goToGameVC(at: self)
    }
    @IBAction func shopButtonPressed(_ sender: Any) {
        presenter.goToShopVC(at: self)
    }
    
    @IBAction func tutorialButtonPressed(_ sender: Any) {
        presenter.goToTutorialVC(at: self)
    }
    @IBAction func gameCenterButtonPressed(_ sender: Any) {
        if GKLocalPlayer.local.isAuthenticated {
                    presenter.goToGameCenterVC(at: self)
                } else {
                    authenticatePlayer()
                }
    }
    
    func authenticatePlayer() {
        let localPlayer = GKLocalPlayer.local
                
                localPlayer.authenticateHandler = { (vc, error) in
                    if let vc = vc {
                        self.present(vc, animated: true)
                    } else {
                        self.presenter.goToGameCenterVC(at: self)
                    }
                }
        
    }
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StartViewController: DailyUpdateProtocol {
    func updateBonusButton() {
        let isBonusEnabled = SettingsManager.dailyBonusDate == nil || (Date() - (SettingsManager.dailyBonusDate ?? Date())) > 24*60*60
            bonusButton.isEnabled = isBonusEnabled
            bonusButton.alpha = isBonusEnabled ? 1 : 0.75
    }
    
    
}
