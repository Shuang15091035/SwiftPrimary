//
//  AnimationController.swift
//  SwiftJpym
//
//  Created by admin on 2017/9/19.
//  Copyright © 2017年 liushuang.library. All rights reserved.
//

import UIKit
import Charts

class AnimationController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPassword: UILabel!
    
    @IBOutlet weak var signInBtn: UIButton!
    
    let myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scaleFunction(view: signInBtn)
        
    }
    
    func scaleFunction(view: UIView) {
        
        let basicAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        basicAnimation.duration = 2.0
        basicAnimation.repeatCount = MAXFLOAT
        basicAnimation.fromValue = 0
        basicAnimation.toValue = (view.frame.height/2)
        
        let shaperLayer = self.drawCircle()
        
        shaperLayer.add(basicAnimation, forKey: "scale")
        view.layer.addSublayer(shaperLayer)
    }
    func drawCircle() -> CALayer {
        let shaperLayer = CAShapeLayer.init()
        shaperLayer.frame = signInBtn.bounds;
        let bezierPath = UIBezierPath()
        bezierPath.fill(with: CGBlendMode.color, alpha: 1.0)
        bezierPath.lineJoinStyle = .round;
        bezierPath.lineCapStyle = .round;
        let radius = signInBtn.bounds.height/2
        let right = signInBtn.bounds.width - signInBtn.bounds.height/2
        let left = signInBtn.bounds.height/2
        
        bezierPath.addArc(withCenter: CGPoint.init(x: right, y: left), radius: radius, startAngle: CGFloat(-(Double.pi/2)), endAngle: CGFloat((Double.pi/2)), clockwise: true)
        bezierPath.close()
        shaperLayer.path = bezierPath.cgPath
        shaperLayer.position = view.center
        return shaperLayer
    }
    func setupView() {
        myView.backgroundColor = .blue
        myView.frame = .init(x: 20, y: 100, width: 60, height: 80)
        myView.center = self.view.center
        self.view.addSubview(myView)
    }
    
    func runKeyFrameAnimation() {
        let keyFrameAnimation = CAKeyframeAnimation.init()
        let bezierPath = UIBezierPath(roundedRect: CGRect.init(x:0, y: 0, width: 200, height: 200), byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: 10, height: 10))
        //MARK: - first
        keyFrameAnimation.keyPath = "position"
        keyFrameAnimation.path = bezierPath.cgPath
        keyFrameAnimation.duration = 5.0
        keyFrameAnimation.repeatCount = MAXFLOAT
        keyFrameAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        keyFrameAnimation.rotationMode = kCAAnimationRotateAuto
        keyFrameAnimation.calculationMode = kCAAnimationLinear
        myView.layer.add(keyFrameAnimation, forKey: "keyFrame")
    }
    
    func runBasicAnimation() {
        let propertyAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        propertyAnimation.fromValue = 0
        propertyAnimation.toValue = Double.pi
        propertyAnimation.duration = 3.0
        propertyAnimation.repeatCount = MAXFLOAT
        //range[0,1],sport way
        propertyAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        myView.layer.add(propertyAnimation, forKey: "propertyAnimationRotation")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
