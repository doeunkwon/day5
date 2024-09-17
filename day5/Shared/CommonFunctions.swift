//
//  CommonFunctions.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import UIKit
import SwiftUI

// Convert the progress value to a UIColor (hue-based color for a dynamic look)
func intToUIColor(value: CGFloat) -> UIColor {
    return UIColor(hue: value / 3, saturation: 0.7, brightness: 0.8, alpha: 1.0)
}

func intToColor(value: CGFloat) -> Color {
    return Color(hue: value / 3, saturation: 0.7, brightness: 0.8, opacity: 1.0)
}

func secondsToTimeLabelText(seconds: CGFloat) -> String {
    var minutes = Int(seconds / 60)
    var seconds = Int(ceil(seconds.truncatingRemainder(dividingBy: 60)))
    
    if seconds == 60 {
        seconds = 0
        minutes += 1
    }
    
    if minutes == 0 {
        return String(seconds)
    } else {
        return "\(minutes):" + String(format: "%02d", seconds)
    }
}
