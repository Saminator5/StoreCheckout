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
    struct Colors {
        
        static let brightOrange     = UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        static let red              = UIColor(red: 255.0/255.0, green: 115.0/255.0, blue: 115.0/255.0, alpha: 1.0)
        static let orange           = UIColor(red: 255.0/255.0, green: 175.0/255.0, blue: 72.0/255.0, alpha: 1.0)
        static let blue             = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 228.0/255.0, alpha: 1.0)
        static let green            = UIColor(red: 91.0/255.0, green: 197.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        static let darkGrey         = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
        static let veryDarkGrey     = UIColor(red: 13.0/255.0, green: 13.0/255.0, blue: 13.0/255.0, alpha: 1.0)
        static let lightGrey        = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        static let black            = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        static let white            = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    @IBAction func exitTextField(_ sender: Any) {
        (sender as! UITextField).resignFirstResponder()
    }
    
    func setHeight(textField: UITextField, height: Int) {
        var rect = textField.frame
        rect.size.height = 45; // <-- Specify the height you want here.
        
        textField.frame = rect
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

