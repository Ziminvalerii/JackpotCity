//
//  Router.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 17.10.2022.
//

import UIKit
import GameKit



protocol RouterProtocol {
    //MARK: - Properties
    var builder: BuilderProtocol {get set}
    
    func presentGameVC() -> UIViewController
    func presentStartVC(at vc: UIViewController)
    func presentShopVC(at vc: UIViewController)
    func presentSettingsVC(at vc: UIViewController)
    func presentTutorialVC(at vc: UIViewController)
    func presentDailyVC(at vc:UIViewController, updateDailyButtonDelegate: DailyUpdateProtocol?)
    func presentGameCenterVC(at vc: UIViewController)
    func presentPrivacyVC(at vc: UIViewController)
    func dissmisVC(_ vc:UIViewController, completion: (() -> Void)?)
}

class Router: RouterProtocol {
    
    var builder: BuilderProtocol
    
    init(builder: BuilderProtocol) {
        self.builder = builder
    }
    
    func presentGameVC() -> UIViewController {
        return builder.createStartViewController(router: self)
    }
    
    func presentShopVC(at vc: UIViewController) {
        let goToVC = builder.createShopViewController(router: self)
        goToVC.modalTransitionStyle = .crossDissolve
        goToVC.modalPresentationStyle = .fullScreen
        vc.present(goToVC, animated: true)
    }
    
    func presentStartVC(at vc: UIViewController) {
        let goToVC = builder.createGameViewController(router: self)
        goToVC.modalTransitionStyle = .crossDissolve
        goToVC.modalPresentationStyle = .fullScreen
        vc.present(goToVC, animated: true   )
    }
    
    func presentSettingsVC(at vc: UIViewController) {
        let goToVC = builder.createSettingsViewController(router: self)
        goToVC.modalTransitionStyle = .crossDissolve
        goToVC.modalPresentationStyle = .fullScreen
        vc.present(goToVC, animated: true   )
    }
    
    func presentTutorialVC(at vc: UIViewController) {
        let goToVC = builder.createTutorialViewController(router: self)
        goToVC.modalTransitionStyle = .crossDissolve
        goToVC.modalPresentationStyle = .fullScreen
        vc.present(goToVC, animated: true)
    }
    
    func presentDailyVC(at vc: UIViewController, updateDailyButtonDelegate: DailyUpdateProtocol?) {
        let goToVC = builder.createDailyViewController(router: self, updateDailyButtonDelegate: updateDailyButtonDelegate)
        goToVC.modalTransitionStyle = .crossDissolve
        goToVC.modalPresentationStyle = .overFullScreen
        vc.present(goToVC, animated: true)
    }
    
    func presentGameCenterVC(at vc: UIViewController) {
        let gcVC = GKGameCenterViewController(leaderboardID: "com.flywings.cityQuest.Leaderboard", playerScope: .global, timeScope: .allTime)
        if let vc = vc as? StartViewController {
            gcVC.gameCenterDelegate = vc  /*as GKGameCenterControllerDelegate*/
        }
        vc.present(gcVC, animated: true)
    }
    
    func presentPrivacyVC(at vc: UIViewController) {
        guard let url = URL(string: "https://docs.google.com/document/d/1YiiZaVYcvDDGWRV0eCDaim3jlZRdeAIZOcjx4XJymM0/edit?usp=sharing") else {return}
        let goToVC = builder.createPrivacyPolicViewController(url: url)
        goToVC.modalPresentationStyle = .formSheet
        vc.present(goToVC, animated: true)
    }
    
    func dissmisVC(_ vc:UIViewController, completion: (() -> Void)?) {
        vc.dismiss(animated: true,completion: completion)
    }
    
    
}
