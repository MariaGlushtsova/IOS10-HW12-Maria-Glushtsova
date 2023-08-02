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
        button.tintColor = UIColor(named: "buttonColor")
        return button
    }()
    
    private lazy var shapeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "circle")
        return imageView
    }()
    
    let shapeLayer = CAShapeLayer()
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.circleAnimation()
        
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        
        view.backgroundColor = UIColor(named: "viewColor")
        view.addSubview(timerLabel)
        view.addSubview(startButton)
        view.addSubview(shapeView)
        
    }
    
    private func setupLayout() {
        
        timerLabel.snp.makeConstraints { make in
            
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            
        }
        
        startButton.snp.makeConstraints { make in
            
            make.centerX.equalTo(view)
            make.centerY.equalTo(timerLabel).offset(180)
            
        }
        
        shapeView.snp.makeConstraints { make in
            
            make.width.equalTo(600)
            make.height.equalTo(600)
            make.centerX.equalTo(timerLabel)
            make.centerY.equalTo(timerLabel).offset(-50)
            
        }
        
    }
    
    // MARK: - Actions
    
    
    func convertSecondsToTime(timeInSecomds: Int) -> String {
        
        let minutes = timeInSecomds / 60
        let seconds = timeInSecomds % 60
        
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    @objc func startButtonTapped(_ sender: UIButton) {
        
        sender.isSelected.toggle();
        if startButton.isSelected {
            clockwiseAnimation()
            resumeAnimation()
            startButton.setImage(UIImage(systemName: "pause.fill"), for: .selected)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

        } else {
            pauseAnimation()
            startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            timer.invalidate()
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
    
    // MARK: - Animation
    
    func circleAnimation() {
        
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
        let circulePath = UIBezierPath(arcCenter: center, radius: 138, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circulePath.cgPath
        shapeLayer.lineWidth = 40
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor(named: "buttonColor")?.cgColor
        shapeView.layer.addSublayer(shapeLayer)
        
    }
    
     func clockwiseAnimation() {
        
        let clockwiseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        clockwiseAnimation.toValue = 0
        clockwiseAnimation.duration = CFTimeInterval(timeToShow)
        clockwiseAnimation.fillMode = CAMediaTimingFillMode.forwards
        clockwiseAnimation.isRemovedOnCompletion = false
        shapeLayer.add(clockwiseAnimation, forKey: "clockwiseAnimation")
        
    }
    
    func pauseAnimation() {
       
        let pausedTime = shapeLayer.convertTime(CACurrentMediaTime(), to: nil)
        shapeLayer.speed = 0.0
        shapeLayer.timeOffset = pausedTime

   }
    
    func resumeAnimation() {

        let resumeTime = shapeLayer.convertTime(CACurrentMediaTime(), to: nil)
        shapeLayer.speed = 1
        shapeLayer.timeOffset = 0
        shapeLayer.beginTime = resumeTime
        
    }
}
