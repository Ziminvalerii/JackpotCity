//
//  Builder.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 17.10.2022.
//

import UIKit


protocol BuilderProtocol {
    func createGameViewController(router: RouterProtocol) -> UIViewController
    func createStartViewController(router: RouterProtocol) -> UIViewController
    func createShopViewController(router: RouterProtocol) -> UIViewController
    func createSettingsViewController(router: RouterProtocol) -> UIViewController
    func createTutorialViewController(router: RouterProtocol) -> UIViewController
    func createDailyViewController(router: RouterProtocol, updateDailyButtonDelegate: DailyUpdateProtocol?) -> UIViewController
    func createPrivacyPolicViewController(url : URL) -> PrivacyPolicyViewController
}

class Builder: BuilderProtocol {
    
    func createGameViewController(router: RouterProtocol) -> UIViewController {
        let vc = GameViewController.instantiateMyViewController()
        vc.presenter = GamePresenter(view: vc, router: router)
        return vc
    }
    
    func createStartViewController(router: RouterProtocol) -> UIViewController {
        let vc = StartViewController.instantiateMyViewController()
        let presenter = StartPresenter(view: vc, router: router)
        vc.presenter = presenter
        return vc
    }
    
    func createShopViewController(router: RouterProtocol) -> UIViewController {
        let vc = ShopViewController.instantiateMyViewController()
        vc.presenter = ShopPresenter(view: vc, router: router)
        return vc
    }
    
    func createSettingsViewController(router: RouterProtocol) -> UIViewController {
        let vc = SettingsViewController.instantiateMyViewController()
        vc.presenter = SettingsPresenter(view: vc, router: router)
        return vc
    }
    
    func createTutorialViewController(router: RouterProtocol) -> UIViewController {
        let vc = TutorialViewController.instantiateMyViewController()
        vc.presenter = TutorialPresenter(view: vc, router: router)
        return vc
    }
    
    func createDailyViewController(router: RouterProtocol, updateDailyButtonDelegate: DailyUpdateProtocol?) -> UIViewController {
        let vc = DailyViewController.instantiateMyViewController()
        vc.presenter = DailyPresenter(view: vc, router: router, updateDailyButtonDelegate: updateDailyButtonDelegate)
        return vc
    }
    
    func createPrivacyPolicViewController(url : URL) -> PrivacyPolicyViewController {
        let vc = PrivacyPolicyViewController(url: url)
        return vc
    }
}
