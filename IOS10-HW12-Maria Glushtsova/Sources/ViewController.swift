//
//  ViewController.swift
//  IOS10-HW12-Maria Glushtsova
//
//  Created by Admin on 21.06.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    var timer = Timer()
    var timeToShow = 10
    var workTimeRemaining = 10
    var breakTimeRemaining = 5
    var workPeriodLength = 10
    var breakPeriodLength = 5
    var timeToWork = true
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = (convertSecondsToTime(timeInSecomds: timeToShow))
        label.font = .systemFont(ofSize: 40)
        label.textColor = UIColor(named: "textColor")
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
//        button.setImage(UIImage(systemName: "pause.fill"), for: .selected)
        button.tintColor = UIColor(named: "buttonColor")
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        
        view.backgroundColor = UIColor(named: "ViewColor")
        view.addSubview(timerLabel)
        view.addSubview(startButton)
        
    }
    
    private func setupLayout() {
        
        timerLabel.snp.makeConstraints { make in
            
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            
        }
        
        startButton.snp.makeConstraints { make in
            
            make.centerX.equalTo(view)
            make.centerY.equalTo(timerLabel).offset(150)
            
        }
        
    }
    
    // MARK: - Actions
    
    
    func convertSecondsToTime(timeInSecomds: Int) -> String {
        
        let minutes = timeInSecomds / 60
        let seconds = timeInSecomds % 60
        
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    @objc func startButtonTapped() {
        
        if startButton.isTouchInside {
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

        }
    }
    
    
    
    @objc func timerAction() {
        
        step()
        timerLabel.text = "\((convertSecondsToTime(timeInSecomds: timeToShow)))"
        

    }
    
    @objc func step() {
        
        if timeToWork == true {
            
            if workTimeRemaining >= 0 {
                
                timeToShow = workTimeRemaining
                workTimeRemaining -= 1
                
            } else {
                
                timeToWork = false
                workTimeRemaining = workPeriodLength
                
            }
            
        } else {
            
            if breakTimeRemaining >= 0 {
                
                timeToShow = breakTimeRemaining
                breakTimeRemaining -= 1
                
            } else {
                
                timeToWork = true
                breakTimeRemaining = breakPeriodLength
                
            }
            
        }
        
        
    }
    
}
