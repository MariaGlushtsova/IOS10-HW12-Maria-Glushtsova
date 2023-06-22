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
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "25:00"
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "custom.play.fill"), for: .normal)
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
    


    
}

