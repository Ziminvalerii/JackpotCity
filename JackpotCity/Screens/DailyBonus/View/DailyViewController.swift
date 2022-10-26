//
//  DailyViewController.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 25.10.2022.
//

import UIKit

class DailyViewController: BaseViewController<DailyPresenterProtocol>, DailyView {

    @IBOutlet weak var bonusImage: UIImageView! {
        didSet {
            bonusImage.alpha = 0
        }
    }
    @IBOutlet weak var dailyImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped))
        view.addGestureRecognizer(gestureRec)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SettingsManager.dailyBonusDate = Date()
        SettingsManager.currentCoin += 20
    }
    

    @objc func viewDidTapped() {
        AudioManager.shared.vibrate()
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseOut) {
            self.dailyImage.alpha = 0
            self.bonusImage.alpha = 1
            AudioManager.shared.playSound(.bonus)
        } completion: { success in
            if success {
                self.presenter.updateDailyButtonDelegate?.updateBonusButton()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.presenter.dismissVC(self)
                }
            }
        }
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
