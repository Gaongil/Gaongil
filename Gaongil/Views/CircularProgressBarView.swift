//
//  CircularProgressBarView.swift
//  Gaongil
//
//  Created by Lena on 2022/11/04.
//

import UIKit

/* 출처:
 https://github.com/DragonCat4012/CircularProgress/blob/master/CircularProgress/CircularProgressView.swift
 */

class CircularProgressBarView: UIView {
    private let labelLayer = CATextLayer()
    private let centerTextLabel = UILabel()
    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    private var pathCenter: CGPoint{
        get {
            return self.convert(self.center,
                                from: self.superview)
        }
    }
    
    var lineWidth: Double = 15
    var title: String = ""
    var subTitle: String = "\n"
    var highlightedColor: UIColor = UIColor.customSelectedGreen
    var backgroundUnselectedColor: UIColor = UIColor.customUnselectedGreen
    var progress: Double = 0.5
    var radius: Int = 40
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth / 6.19, height: screenWidth / 6.19))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2,
                                                           y: frame.size.height / 2),
                                        radius: CGFloat(self.radius),
                                        startAngle: startPoint,
                                        endAngle: endPoint,
                                        clockwise: true)
        
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineCap = .round
        backgroundLayer.lineWidth = self.lineWidth
        backgroundLayer.strokeEnd = 1.0
        backgroundLayer.strokeColor = backgroundUnselectedColor.cgColor
        layer.addSublayer(backgroundLayer)
        
        foregroundLayer.path = circularPath.cgPath
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.lineCap = .round
        foregroundLayer.lineWidth = self.lineWidth
        foregroundLayer.strokeEnd = self.progress
        foregroundLayer.strokeColor = self.highlightedColor.cgColor
        layer.addSublayer(foregroundLayer)
        
    }
    
    private func createLabels(){
        centerTextLabel.sizeToFit()
        centerTextLabel.textAlignment = .center
        centerTextLabel.numberOfLines = 2
        centerTextLabel.frame = self.frame
        centerTextLabel.center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = .center
        
        let firstAttributes: [NSAttributedString.Key: Any] = [ .font: UIFont.systemFont(ofSize: 20.0), .foregroundColor: UIColor.customBlack, .paragraphStyle: titleParagraphStyle]
        
        let firstString = NSMutableAttributedString(string: self.title, attributes: firstAttributes)
        
        centerTextLabel.attributedText = firstString
        
        self.addSubview(centerTextLabel)
    }
    
    func setProgress(progress: Double = 0.5, color: UIColor = UIColor.blue, percentage: String = "", progressStatus: String = ""){
        self.progress =  progress
        self.highlightedColor = color
        self.title = percentage
        self.subTitle = progressStatus
        createLabels()
        createCircularPath()
    }
    
    func animate(_ value: Double, duration: TimeInterval = 2 ) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = value
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        foregroundLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
