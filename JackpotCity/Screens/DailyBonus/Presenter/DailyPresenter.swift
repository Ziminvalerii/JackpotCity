//
//  DailyPresenter.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 25.10.2022.
//

import UIKit

protocol DailyUpdateProtocol:AnyObject {
    func updateBonusButton()
}

protocol DailyView:AnyObject {
    
}

protocol DailyPresenterProtocol: AnyObject {
    var updateDailyButtonDelegate: DailyUpdateProtocol? { get }
    init(view: DailyView, router: RouterProtocol, updateDailyButtonDelegate: DailyUpdateProtocol?)
    func dismissVC(_ vc: UIViewController)
    
}

class DailyPresenter: DailyPresenterProtocol {
    weak var view: DailyView?
    private var router: RouterProtocol
    weak var updateDailyButtonDelegate: DailyUpdateProtocol?
    
    required init(view: DailyView, router: RouterProtocol, updateDailyButtonDelegate: DailyUpdateProtocol?) {
        self.view = view
        self.router = router
        self.updateDailyButtonDelegate = updateDailyButtonDelegate
    }
    
    func dismissVC(_ vc: UIViewController) {
        router.dissmisVC(vc, completion: nil)
    }
    
}


