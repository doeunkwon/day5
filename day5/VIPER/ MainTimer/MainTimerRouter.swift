//
//  MainTimerRouter.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import UIKit

protocol MainTimerRouterProtocol: AnyObject {
    
}

class MainTimerRouter: MainTimerRouterProtocol {
    
    static func createModule(workDuration: CGFloat, restDuration: CGFloat) -> UIViewController {
        
        let view = MainTimerView(workDuration: workDuration, restDuration: restDuration)
        let presenter = MainTimerPresenter()
        let interactor = MainTimerInteractor()
        let router = MainTimerRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
        
    }

}
