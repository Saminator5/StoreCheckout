//
//  RegisterScreen.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 1/31/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import FirebaseAuth

class RegisterScreen: UIViewController {
    @IBOutlet weak var cPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)
        registerButton.layer.cornerRadius = registerButton.frame.size.height/2
        registerButton.layer.masksToBounds = true
        
        if let myImage = UIImage(named: "email"){
            email.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black)
            setHeight(textField: email, height: 45)
        }
        
        if let myImage = UIImage(named: "lock"){
            password.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black)
            setHeight(textField: password, height: 45)
        }
        
        if let myImage = UIImage(named: "lock"){
            cPassword.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.orange, colorBorder: UIColor.black)
            setHeight(textField: cPassword, height: 45)
        }
        
    }
    
    /**
     Returns an error message or nil if there is no validation error
     */
    func validate() -> String? {
        
        if let email = email.text {
            if email.contains("@") == false {
                return "Invalid email format."
            }
        } else {
            return "Please enter your email."
        }
        
        // TODO: add some more validation rules
        
        return nil
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        
        if let message = validate() {
            
            let alert = UIAlertController(title: "Sign up failed.", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
            return // We won't continue
        }
        // If the input form is valid, we can proceed to the sign up
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { [weak self] (result, error) in
            
            // Move from the background thread (authentication) to the Main thread (UI)
            // We need to always handle UI-related logic on the main thread
            DispatchQueue.main.async {
                
                // Here we will unwrap self, in case the LoginScreen doesn't exist at the time this piece of code is executed, nothing should happen
                guard let `self` = self else { return }
                
                if let _ = result?.user {
                    // Successful login
                    // Manual segue
                    self.performSegue(withIdentifier: "showLoginVC", sender: nil)
                } else {
                    if let error = error {
                        let message = error.localizedDescription
                        self.presentOKAlert(title: "Sign up failed.", message: message)
                    }
                }
            }// end of dispatch queue
        }// end of auth
    }
    
}
