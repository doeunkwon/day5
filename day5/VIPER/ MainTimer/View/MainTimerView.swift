//
//  MainTimerView.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import UIKit
import SwiftUI
import AudioToolbox

protocol MainTimerViewProtocol: AnyObject {
    func updateTimeLabel(text: String, color: UIColor)
    func updateCircularProgressView(value: CGFloat, color: Color)
    func updateGradientColor(color: UIColor)
    func playSound()
}

class MainTimerView: UIViewController {
    
    private var workDuration: CGFloat
    private var restDuration: CGFloat
    
    var presenter: MainTimerPresenterProtocol?
    var timeLabelIsHidden: Bool = false
    
    private var circularProgressViewModel = CircularProgressViewModel()

    lazy var gradientView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var circularProgress: (vc: UIViewController, view: UIView) = {
        let circularProgress = CircularProgressView(size: view.frame.width * 0.7, viewModel: circularProgressViewModel)
        let vc = UIHostingController(rootView: circularProgress)
        guard let view = vc.view else { fatalError("CircularProgressView does not have a view.") }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return (vc, view)
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.text = secondsToTimeLabelText(seconds: workDuration * 60)
        view.font = UIFont.systemFont(ofSize: 60, weight: .black).rounded()
        view.textColor = intToUIColor(value: 0).withAlphaComponent(Opacity.low)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = timeLabelIsHidden
        return view
    }()
    
    init(workDuration: CGFloat, restDuration: CGFloat) {
        self.workDuration = workDuration
        self.restDuration = restDuration
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.workDuration = workDuration
        presenter?.restDuration = restDuration
    }

    private func setupView() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .myBackground
        
        let circularProgressVC = circularProgress.vc
        let circularProgressView = circularProgress.view
        
        addChild(circularProgressVC)
        
        view.addSubview(circularProgressView)
        view.addSubview(gradientView)
        view.addSubview(timeLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleTimeLabelAction))
        tapGesture.numberOfTapsRequired = 1
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleTimerAction))
        doubleTapGesture.numberOfTapsRequired = 2
        
        tapGesture.require(toFail: doubleTapGesture)
        
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(doubleTapGesture)
        
        view.sendSubviewToBack(gradientView)
        
        NSLayoutConstraint.activate([
        
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            circularProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circularProgressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
        ])
        
        circularProgressVC.didMove(toParent: self)
    }
    
    @objc private func toggleTimerAction() {
        
        timeLabel.layer.removeAllAnimations()
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
        feedbackGenerator.impactOccurred()
        
        presenter?.toggleTimerAction()
        showTimeLabel()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if self.timeLabelIsHidden {
                self.hideTimeLabel()
            }
        }
    }
    
    @objc private func toggleTimeLabelAction() {
        
        timeLabel.layer.removeAllAnimations()
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
        feedbackGenerator.impactOccurred()
        
        if timeLabel.isHidden {
            
            showTimeLabel()
            timeLabelIsHidden = false
            
        } else {
            
            hideTimeLabel()
            
        }
    }
    
    private func showTimeLabel() {
        
        timeLabel.alpha = 0.0
        timeLabel.isHidden = false
        
        UIView.animate(withDuration: 0.2) {
            self.timeLabel.alpha = 1.0
        }
        
    }

    private func hideTimeLabel() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.timeLabel.alpha = 0.0
        }) { _ in
            self.timeLabel.isHidden = true
            self.timeLabelIsHidden = true
        }
        
    }

}

// MARK: - MainTimerViewProtocol

extension MainTimerView: MainTimerViewProtocol {
    
    func updateTimeLabel(text: String, color: UIColor) {
        timeLabel.text = text
        timeLabel.textColor = color.withAlphaComponent(Opacity.low)
    }
    
    func updateCircularProgressView(value: CGFloat, color: Color) {
        circularProgressViewModel.progressValue = value
        circularProgressViewModel.color = color
    }
    
    func updateGradientColor(color: UIColor) {
        gradientView.updateGradientColor(to: color)
    }
    
    func playSound() {
        AudioServicesPlaySystemSound(1075)
    }
}
