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
import Firebase
import FirebaseAuth

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
    /***
     Returns an error message or null if there no validation error
    */
    func validate() -> String? {
        if let email = email.text{
            if email.contains("@") == false {
                return "Invalid email format."
            }
        } else {
            return "Please enter your email."
        }
        
        // TODO: add more validation
       
        return nil
    }
    @IBAction func loginTapped(_ sender: Any) {
        if let message = validate(){
         presentOKAlert(title: "Login Failed.", message: message)
            
            return // We won't continue
        }
        
        //if the input form is valid, we can proceed to the login
        
        //to prevent retain cycles we are going to use a weak refence to the 'self'
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] (result, error) in
            
            //Move from the background thread (authentication) to the Main thread (UI)
            //we need to always handle UI-related logic on the main thread
            DispatchQueue.main.async {
               
                //Here we will unwrap self, in case the loginScreen doesn't exit at the time this piece of code is executed, nothing should happen
                guard let `self` = self else { return }
                
                
                if let _ = result?.user {
                    //Successful login
                    // manual segue
                    self.performSegue(withIdentifier: "ShowMainScreen", sender: nil)
                }else{
                    if let error = error{
                        let message = error.localizedDescription
                            self.presentOKAlert(title: "Login Failed.", message: message)
                    }
                }
                
            } // end of auth
        }
            
    }
}

extension UIViewController {
    func presentOKAlert(title: String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:
            nil))
        present(alert,animated: true, completion: nil)
    }
}


