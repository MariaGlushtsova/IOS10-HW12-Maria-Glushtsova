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
    private var runCount = 0.0
    private var duration = 25.0
    private var fromValue: CGFloat = 1
    private var toValue: CGFloat = 0
    private var workingTime = 25.0
    private var restTime = 10.0
    private var timeToWork = true
    private var isStarted = false
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = String(Int(duration))
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
    
    private lazy var progressBarView: ProgressBarView = {
        let view = ProgressBarView()
        return view
    }()
    
    private lazy var mainImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "MainImage"))
        return image
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "viewColor")
    }
    
    private func setupHierarchy() {
        view.addSubview(progressBarView)
        view.addSubview(timerLabel)
        view.addSubview(startButton)
        view.addSubview(mainImage)
    }
    
    private func setupLayout() {
        
        progressBarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(timerLabel).offset(180)
        }
        
        mainImage.snp.makeConstraints { make in
            make.width.equalTo(164)
            make.height.equalTo(205)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(timerLabel).offset(-210)
        }
    }
    
    // MARK: - Actions

    @objc func startButtonTapped() {
        
        isStarted.toggle()

        switch isStarted {
        case true:
            progressBarView.resumeAnimation()
            startButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        default:
            progressBarView.pauseAnimation()
            startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            timer.invalidate()
        }
    }
    
    @objc private func timerAction() {
        let formatter = DateFormatter()
        let rounded = runCount.rounded(.up)
        let date = Date(timeIntervalSince1970: TimeInterval(rounded))

        formatter.dateFormat = "00:ss"
        timerLabel.text = formatter.string(from: date)

        guard rounded == 0 else {
            runCount -= 0.01
            return
        }

        if timeToWork {
            fromValue = 0
            toValue = 1
            duration = workingTime
            runCount = workingTime
            progressBarView.workProgressAnimation(duration: duration, from: fromValue, to: toValue)
        } else {
            fromValue = 0
            toValue = 1
            duration = restTime
            runCount = restTime
            progressBarView.restProgressAnimation(duration: duration, from: fromValue, to: toValue)
        }
        timeToWork.toggle()
    }
}
