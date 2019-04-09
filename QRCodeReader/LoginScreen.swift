//
//  LoginScreen.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 1/31/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
class LoginScreen: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var textView: UILabel!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!

    
    @IBAction func exitTextField(_ sender: Any) {
        (sender as! UITextField).resignFirstResponder()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    
        if let myImage = UIImage(named: "email"){
            email.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black)
            setHeight(textField: email, height: 45)
        }
        
        if let myImage = UIImage(named: "lock"){
            password.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black)
            setHeight(textField: password, height: 45)
        }
        
        
        
        logInButton.layer.cornerRadius = logInButton.frame.size.height/2
        logInButton.layer.masksToBounds = true
        
//        self.view.setGradientBackground(colorOne: Colors.veryDarkGrey, colorTwo: Colors.darkGrey)
//
//        self.gradientView.setGradientBackground(colorOne: Colors.white, colorTwo: Colors.blue)
//
//        self.logInButton.setGradientBackground(colorOne: Colors.orange, colorTwo: Colors.brightOrange)
        
        
//        view.setCrazyBackground(colorOne: Colors.blue, colorTwo: Colors.red, colorThree: Colors.white, colorFour: Colors.green)
        
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)
        
        
    }
}
