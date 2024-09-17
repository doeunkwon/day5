//
//  MainTimer.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import UIKit

class MainTimer {
    
    private let workDuration: CGFloat
    
    init(workDuration: CGFloat) {
        self.workDuration = workDuration
    }
    
    var isActive: Bool = false
    lazy var timeRemaining: CGFloat = workDuration * 60 /// 25 minutes * (60 seconds / 1 minute) to change unit to seconds
    var isRest: Bool = false
    
}
