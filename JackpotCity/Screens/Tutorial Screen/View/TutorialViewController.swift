//
//  TutorialViewController.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 21.10.2022.
//

import UIKit

class TutorialViewController: BaseViewController<TutorialPresenterProtocol>, TutorialView {

    
    @IBOutlet weak var okButton: UIButton! {
        didSet {
//            okButton.animatePulse()
           
        }
    }
    @IBOutlet weak var obsctacleTutorial: UIImageView! {
        didSet {
            obsctacleTutorial.alpha = 0
        }
    }
    @IBOutlet weak var coinsTutorial: UIImageView! {
        didSet {
            coinsTutorial.alpha = 0
            
        }
    }
    @IBOutlet weak var playerTutorial: UIImageView! {
        didSet {
            playerTutorial.alpha = 0
//            playerTutorial.doGlowAnimation(withColor: .white, withEffect: .big)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        coinsTutorial.doGlowAnimation(withColor: .white)
//        playerTutorial.doGlowAnimation(withColor: .white)
//        playerTutorial.animatePulse()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.playerTutorial.alpha = 1
        }completion: { success in
            if success {
                self.playerTutorial.animateShaking()
                self.playerTutorial.doGlowAnimation(withColor: .white,withEffect: .normal)
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                    self.coinsTutorial.alpha = 1
                }completion: { success in
                    self.coinsTutorial.animateShaking()
                    self.coinsTutorial.doGlowAnimation(withColor: .white,withEffect: .normal)
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                        self.obsctacleTutorial.alpha = 1
                    }completion: { success in
                        self.obsctacleTutorial.animateShaking()
                        self.obsctacleTutorial.doGlowAnimation(withColor: .white,withEffect: .normal)
                    }
                }
            }
        }
    }
   
    
    @IBAction func okButtonPressed(_ sender: Any) {
        presenter.dismissVC(self)
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
