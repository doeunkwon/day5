//
//  GradientView.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import UIKit

class GradientView: UIView {
    
    private var color: UIColor = intToUIColor(value: 0)
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    private func setupGradientBackground() {

        gradientLayer.colors = [
            color.withAlphaComponent(Opacity.high).cgColor,
            color.withAlphaComponent(Opacity.med).cgColor,
            color.withAlphaComponent(Opacity.low).cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        layer.addSublayer(gradientLayer)
    }
    
    func updateGradientColor(to newColor: UIColor) {
        color = newColor
        
        // Disable implicit animations
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        gradientLayer.colors = [
            color.withAlphaComponent(Opacity.high).cgColor,
            color.withAlphaComponent(Opacity.med).cgColor,
            color.withAlphaComponent(Opacity.low).cgColor
        ]
        
        gradientLayer.setNeedsDisplay()
        
        CATransaction.commit()
    }
}
