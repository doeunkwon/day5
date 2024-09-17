//
//  CircularProgressViewModel.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import Combine
import SwiftUI

class CircularProgressViewModel: ObservableObject {
    @Published var progressValue: CGFloat = 0
    @Published var color: Color = intToColor(value: 0)
}
