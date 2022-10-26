//
//  StartPresenter.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 17.10.2022.
//

import UIKit


//protocol GameViewDelegate: AnyObject {
//    func setGameViewPaused()
//    func setGameViewResumed()
//}

protocol StartsView:AnyObject {
    
}

protocol StartPresenterProtocol: AnyObject {
    init(view: StartsView, router: RouterProtocol)
    func goToGameVC(at vc: UIViewController)
    func goToShopVC(at vc: UIViewController)
    func goToSettingsVC(at vc: UIViewController)
    func goToTutorialVC(at vc:UIViewController)
    func goToDailyVC(at vc: UIViewController, delegate: DailyUpdateProtocol?)
    func goToGameCenterVC(at vc: UIViewController)
}

class StartPresenter: StartPresenterProtocol {
    weak var view: StartsView?
    private var router: RouterProtocol
//    weak var gameViewDelegate : GameViewDelegate?
    
    required init(view: StartsView, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func goToDailyVC(at vc: UIViewController, delegate: DailyUpdateProtocol?) {
        router.presentDailyVC(at: vc, updateDailyButtonDelegate: delegate)
    }
    
    func goToGameVC(at vc: UIViewController) {
        router.presentStartVC(at: vc)
    }
    
    func goToShopVC(at vc: UIViewController) {
        router.presentShopVC(at: vc)
    }
    
    func goToSettingsVC(at vc: UIViewController) {
        router.presentSettingsVC(at: vc)
    }
    
    func goToTutorialVC(at vc:UIViewController) {
        router.presentTutorialVC(at: vc)
    }
    
    func goToGameCenterVC(at vc: UIViewController) {
        router.presentGameCenterVC(at: vc)
    }
    
}
