//
//  SettingPresenter.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import UIKit

protocol SettingPresenterProtocol: AnyObject {
    
    func navigateToMainTimer(workDuration: CGFloat, restDuration: CGFloat)
    
}

class SettingPresenter: SettingPresenterProtocol {
    
    weak var view: SettingViewProtocol?
    var interactor: SettingInteractorProtocol?
    var router: SettingRouterProtocol?
    
    func navigateToMainTimer(workDuration: CGFloat, restDuration: CGFloat) {
        if let settingsView = view {
            router?.navigateToMainTimer(from: settingsView, workDuration: workDuration, restDuration: restDuration)
        }
    }
    
}
