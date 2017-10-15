//
//  Circle.swift
//  TabbingTest
//
//  Created by Taalib Minhas on 05/10/2017.
//  Copyright © 2017 Taalib Minhas. All rights reserved.
//

import UIKit

    var circleLayer: CAShapeLayer!

class Circle: UIView {

    let startAngleDegrees = -90.0
    
    let endAngleDegrees = 270.0
    
    required init?(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        let startAngleRadians = ((startAngleDegrees * Double.pi) / 180)
        let endAngleRadians = ((endAngleDegrees * Double.pi) / 180)
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: CGFloat(startAngleRadians), endAngle: CGFloat(endAngleRadians), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.fillColor = UIColor(red:1.00, green:0.40, blue:0.48, alpha:0.0).cgColor
        circleLayer.strokeColor = UIColor(red:1.00, green:0.40, blue:0.48, alpha:1.0).cgColor
        circleLayer.lineWidth = 8.0;
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeStart = 0.0
        //        circleLayer.fillRule = kCAFillRuleEvenOdd
        //        circleLayer.autoreverses = true
        //        circleLayer.repeatCount = 1
        
        
        // Don't draw the circle initially
        //        circleLayer.strokeEnd = 1.0
        //        circleLayer.strokeStart = 0.0
        //        circleLayer.display()
        
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(circleLayer)
        
        
    }
    
    
    
    func animateCircle(duration: TimeInterval) {
        
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        let background = CABasicAnimation(keyPath: "backgroundColor")
        
        // Set the animation duration appropriately
        animation.duration = 60*25
        background.duration = animation.duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 1
        animation.toValue = 0
        
        background.fromValue = UIColor.blue.cgColor
        background.toValue = UIColor.red.cgColor
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Setting the circleLayer's strokeEnd property to 0.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = 0.0
        
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
        
        circleLayer.autoreverses = true
        circleLayer.repeatCount = 1
        //            circleLayer.repeatDuration = 0.5
        
    }
    
    func loadCircle(duration: TimeInterval) {
        
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = 1
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Setting the circleLayer's strokeEnd property to 0.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = 1.0
        
        // Do the actual animation
        circleLayer.add(animation, forKey: "loadCircle")
        
        
    }
    
    func resetCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = 0.5
        
        // Animate to full circle
        animation.toValue = 1
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        circleLayer.strokeEnd = 1.0
        
        circleLayer.add(animation, forKey: "resetCircle")
        
    }

}
