//
//  GamePresenter.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 17.10.2022.
//

import UIKit


protocol GameView:AnyObject {
    
}

protocol GamePresenterProtocol: AnyObject {
    init(view: GameView, router: RouterProtocol)
    func dismissVC(_ vc: UIViewController)
    
}

class GamePresenter: GamePresenterProtocol {
    weak var view: GameView?
    private var router: RouterProtocol
    
    required init(view: GameView, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func dismissVC(_ vc: UIViewController) {
        router.dissmisVC(vc, completion: nil)
    }
    
}
