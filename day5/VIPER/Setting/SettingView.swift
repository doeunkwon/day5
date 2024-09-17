//
//  SettingView.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import UIKit

protocol SettingViewProtocol: AnyObject {
    
}

class SettingView: UIViewController {
    
    var presenter: SettingPresenterProtocol?
    private var currentWorkDuration: Int = 25
    private var currentRestDuration: Int = 5
    private var isWork: Bool = true
    
    let gradientView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "work duration"
        view.textColor = intToUIColor(value: 0).withAlphaComponent(Opacity.med)
        view.font = UIFont.systemFont(ofSize: 25, weight: .semibold).rounded()
        return view
    }()
    
    lazy var durationLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "\(currentWorkDuration) min"
        view.textColor = intToUIColor(value: 0).withAlphaComponent(Opacity.med)
        view.font = UIFont.systemFont(ofSize: 60, weight: .black).rounded()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .myBackground
        
        let stackView = UIStackView(arrangedSubviews: [textLabel, durationLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(gradientView)
        view.addSubview(stackView)
        
        view.sendSubviewToBack(gradientView)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        let panGestureForWork = UIPanGestureRecognizer(target: self, action: #selector(editDuration))
        view.addGestureRecognizer(panGestureForWork)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSetting))
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToMainTimer))
        
        tapGesture.numberOfTapsRequired = 1
        doubleTapGesture.numberOfTapsRequired = 2
        
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(doubleTapGesture)
        
        tapGesture.require(toFail: doubleTapGesture)
        
        NSLayoutConstraint.activate([
        
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        ])
    }
    
    @objc private func editDuration(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let dragChange = Int(translation.y) / 30

        var newDuration = (isWork ? currentWorkDuration : currentRestDuration) - dragChange
        
        newDuration = min(max(newDuration, (isWork ? 1 : 1)), (isWork ? 60 : 60))

        durationLabel.text = "\(newDuration) min"

        if gesture.state == .ended {
            if isWork {
                currentWorkDuration = newDuration
            } else {
                currentRestDuration = newDuration
            }
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            feedbackGenerator.impactOccurred()
        }
    }
    
    @objc private func toggleSetting() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
        feedbackGenerator.impactOccurred()
        
        if isWork {
            isWork = false
            gradientView.updateGradientColor(to: .purple)
            textLabel.text = "rest duration"
            textLabel.textColor = .purple.withAlphaComponent(Opacity.high)
            durationLabel.text = "\(currentRestDuration) min"
            durationLabel.textColor = .purple.withAlphaComponent(Opacity.high)
        } else {
            isWork = true
            gradientView.updateGradientColor(to: intToUIColor(value: 0))
            textLabel.text = "work duration"
            textLabel.textColor = intToUIColor(value: 0).withAlphaComponent(Opacity.high)
            durationLabel.text = "\(currentWorkDuration) min"
            durationLabel.textColor = intToUIColor(value: 0).withAlphaComponent(Opacity.high)
        }
    }
    
    @objc private func navigateToMainTimer() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator.impactOccurred()
        
        presenter?.navigateToMainTimer(workDuration: CGFloat(currentWorkDuration), restDuration: CGFloat(currentRestDuration))
    }

}

// MARK: - SettingViewProtocol

extension SettingView: SettingViewProtocol {
    
}
