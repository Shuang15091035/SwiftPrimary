//
//  RandomColorGradientViewController.swift
//  SwiftJpym
//
//  Created by admin on 2017/9/20.
//  Copyright © 2017年 liushuang.library. All rights reserved.
//

import UIKit

class RandomColorGradientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame;
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.orange.cgColor]
        gradientLayer.locations = [0.1, 0.2, 0.7, 0.9]
        gradientLayer.startPoint = CGPoint(x: 0.2, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.addSublayer(gradientLayer)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
