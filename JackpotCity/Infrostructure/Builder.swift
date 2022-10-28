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
        guard let vc = GameViewController.instantiateMyViewController() else { return UIViewController()}
        vc.presenter = GamePresenter(view: vc, router: router)
        return vc
    }
    
    func createStartViewController(router: RouterProtocol) -> UIViewController {
        guard let vc = StartViewController.instantiateMyViewController() else { return UIViewController()}
        let presenter = StartPresenter(view: vc, router: router)
        vc.presenter = presenter
        return vc
    }
    
    func createShopViewController(router: RouterProtocol) -> UIViewController {
        guard let vc = ShopViewController.instantiateMyViewController() else { return UIViewController()}
        vc.presenter = ShopPresenter(view: vc, router: router)
        return vc
    }
    
    func createSettingsViewController(router: RouterProtocol) -> UIViewController {
        guard let vc = SettingsViewController.instantiateMyViewController() else {return UIViewController()}
        vc.presenter = SettingsPresenter(view: vc, router: router)
        return vc
    }
    
    func createTutorialViewController(router: RouterProtocol) -> UIViewController {
        guard let vc = TutorialViewController.instantiateMyViewController() else { return UIViewController()}
        vc.presenter = TutorialPresenter(view: vc, router: router)
        return vc
    }
    
    func createDailyViewController(router: RouterProtocol, updateDailyButtonDelegate: DailyUpdateProtocol?) -> UIViewController {
        guard let vc = DailyViewController.instantiateMyViewController() else { return UIViewController()}
        vc.presenter = DailyPresenter(view: vc, router: router, updateDailyButtonDelegate: updateDailyButtonDelegate)
        return vc
    }
    
    func createPrivacyPolicViewController(url : URL) -> PrivacyPolicyViewController {
        let vc = PrivacyPolicyViewController(url: url)
        return vc
    }
}
