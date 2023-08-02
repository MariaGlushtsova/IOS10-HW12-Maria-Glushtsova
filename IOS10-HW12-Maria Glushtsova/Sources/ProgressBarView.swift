//
//  ProgressBarView.swift
//  IOS10-HW12-Maria Glushtsova
//
//  Created by Admin on 2.08.23.
//

import UIKit

class ProgressBarView: UIView {

    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)


    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }

    private func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: center, radius: 120, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 8.0
        circleLayer.strokeEnd = 1
        circleLayer.strokeColor = UIColor.systemGray6.cgColor
        circleLayer.opacity = 0.5
        layer.addSublayer(circleLayer)

        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 8.0

        layer.addSublayer(progressLayer)
    }

    func pauseAnimation() {
        let pausedTime: CFTimeInterval = progressLayer.convertTime(CACurrentMediaTime(), from: nil)
        progressLayer.speed = 0.0
        progressLayer.timeOffset = pausedTime
    }

    func resumeAnimation() {
        let pausedTime: CFTimeInterval = progressLayer.timeOffset
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
        progressLayer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = progressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        progressLayer.beginTime = timeSincePause
    }

    func workProgressAnimation(duration: TimeInterval, from: CGFloat, to: CGFloat) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        progressLayer.strokeEnd = from
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = to
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.strokeColor = UIColor(named: "buttonColor")?.cgColor
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    
    func restProgressAnimation(duration: TimeInterval, from: CGFloat, to: CGFloat) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        progressLayer.strokeEnd = from
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = to
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.strokeColor = UIColor(named: "textColor")?.cgColor
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
