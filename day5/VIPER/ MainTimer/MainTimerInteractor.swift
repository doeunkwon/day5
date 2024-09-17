//
//  MainTimerInteractor.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import UIKit

protocol MainTimerInteractorProtocol: AnyObject {
    
    func toggleTimer()
    
}

class MainTimerInteractor: MainTimerInteractorProtocol {
    
    weak var presenter: MainTimerPresenterProtocol?
    lazy var mainTimer = MainTimer(workDuration: ( presenter?.workDuration ?? 25 ))
    var timer: Timer?
    
    func toggleTimer() {
        if mainTimer.isActive {
            /// STOP timer actions
            timer?.invalidate()
            mainTimer.isActive = false
        } else {
            /// START timer actions
            mainTimer.isActive = true
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(refreshTime), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func refreshTime() {
        if mainTimer.isRest {
            if mainTimer.timeRemaining > 0 {
                presenter?.updateTimeRemaining(secondsRemaining: mainTimer.timeRemaining, flag: .rest)
            } else {
                mainTimer.isRest = false
                mainTimer.timeRemaining = (presenter?.workDuration ?? 25) * 60
                presenter?.endPhase()
            }
        } else {
            if mainTimer.timeRemaining > 0 {
                presenter?.updateTimeRemaining(secondsRemaining: mainTimer.timeRemaining, flag: .work)
            } else {
                mainTimer.isRest = true
                mainTimer.timeRemaining = (presenter?.restDuration ?? 5) * 60
                presenter?.endPhase()
            }
        }
        mainTimer.timeRemaining -= 0.01
    }
    
}
