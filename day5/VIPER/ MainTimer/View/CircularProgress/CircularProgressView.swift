//
//  CircularProgressView.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import SwiftUI

struct CircularProgressView: View {
    
    let size: CGFloat
    @ObservedObject var viewModel: CircularProgressViewModel
    
    var body: some View {
        return ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .frame(width: size)
                .foregroundStyle(viewModel.color.opacity(Opacity.low))
            Circle()
                .trim(from: 0.0, to: min(viewModel.progressValue, 1.0))
                .stroke(style: StrokeStyle(lineWidth: 22, lineCap: .round))
                .frame(width: size)
                .foregroundStyle(viewModel.color.opacity(Opacity.high))
                .rotationEffect(Angle(degrees: 270))
                .shadow(color: viewModel.color.opacity(Opacity.med), radius: 10, x: 0, y: 0)
        }
    }
}
