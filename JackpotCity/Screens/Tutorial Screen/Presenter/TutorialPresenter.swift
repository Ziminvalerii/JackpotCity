//
//  TutorialPresenter.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 21.10.2022.
//

import UIKit

protocol TutorialView:AnyObject {
    
}

protocol TutorialPresenterProtocol: AnyObject {
    init(view: TutorialView, router: RouterProtocol)
    func dismissVC(_ vc: UIViewController)
    
}

class TutorialPresenter: TutorialPresenterProtocol {
    weak var view: TutorialView?
    private var router: RouterProtocol
    
    required init(view: TutorialView, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func dismissVC(_ vc: UIViewController) {
        router.dissmisVC(vc, completion: nil)
    }
    
}
