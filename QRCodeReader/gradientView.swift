//
//  gradientView.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 1/31/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [Colors.specialBlue.cgColor, Colors.specialPurple.cgColor]
        
        let x: Double! = 45 / 360.0
        let a = pow(sinf(Float(2.0 * Double.pi * ((x + 0.75) / 2.0))),2.0);
        let b = pow(sinf(Float(2*Double.pi*((x+0.0)/2))),2);
        let c = pow(sinf(Float(2*Double.pi*((x+0.25)/2))),2);
        let d = pow(sinf(Float(2*Double.pi*((x+0.5)/2))),2);
        
        gradientLayer.endPoint = CGPoint(x: CGFloat(c),y: CGFloat(d))
        gradientLayer.startPoint = CGPoint(x: CGFloat(a),y:CGFloat(b))
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
//        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func setCrazyBackground(colorOne: UIColor, colorTwo: UIColor, colorThree: UIColor, colorFour: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor,
        colorThree.cgColor, colorFour.cgColor]
        gradientLayer.locations = [0.0, 0.2, 0.4, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
