//
//  SettingRouter.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import UIKit

protocol SettingRouterProtocol: AnyObject {
    func navigateToMainTimer(from view: SettingViewProtocol, workDuration: CGFloat, restDuration: CGFloat)
}

class SettingRouter: SettingRouterProtocol {
    
    static func createModule() -> UIViewController {
        
        let view = SettingView()
        let presenter = SettingPresenter()
        let interactor = SettingInteractor()
        let router = SettingRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
        
    }
    
    func navigateToMainTimer(from view: SettingViewProtocol, workDuration: CGFloat, restDuration: CGFloat) {
        let mainTimerViewController = MainTimerRouter.createModule(workDuration: workDuration, restDuration: restDuration)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(mainTimerViewController, animated: false)
        }
    }
    
}
