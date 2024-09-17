//
//  MainTimerPresenter.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import SwiftUI
import UIKit

protocol MainTimerPresenterProtocol: AnyObject {
    
    var workDuration: CGFloat { get set }
    var restDuration: CGFloat { get set }
    
    func updateTimeRemaining(secondsRemaining: CGFloat, flag: TimerType)
    func toggleTimerAction()
    func endPhase()
}

class MainTimerPresenter {
    
    private var _workDuration: CGFloat = 1500 /// 25 minutes
    private var _restDuration: CGFloat = 300 /// 5 minutes
    
    weak var view: MainTimerViewProtocol?
    var interactor: MainTimerInteractorProtocol?
    var router: MainTimerRouterProtocol?
    
}

extension MainTimerPresenter: MainTimerPresenterProtocol {
    
    var workDuration: CGFloat {
        get {
            return _workDuration
        }
        set {
            _workDuration = newValue
        }
    }
    
    var restDuration: CGFloat {
        get {
            return _restDuration
        }
        set {
            _restDuration = newValue
        }
    }
    
    func updateTimeRemaining(secondsRemaining: CGFloat, flag: TimerType) {
        let normalizedSecondsRemaining = secondsRemaining / ((flag == .work ? workDuration : restDuration) * 60) /// divide seconds by total seconds to get a value between 0.0 and 1.0
        let progressValue = 1.0 - normalizedSecondsRemaining  // Invert the value to show time remaining
        let valueUIColor = flag == .work ? intToUIColor(value: progressValue) : .purple
        let newTimeLabelText = secondsToTimeLabelText(seconds: secondsRemaining)
        
        view?.updateTimeLabel(text: newTimeLabelText, color: valueUIColor)
        view?.updateCircularProgressView(value: progressValue, color: Color(uiColor: valueUIColor))
        view?.updateGradientColor(color: valueUIColor)
    }
    
    func toggleTimerAction() {
        interactor?.toggleTimer()
    }
    
    func endPhase() {
        view?.playSound()
    }
    
}
