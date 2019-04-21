//
//  SettingScreen.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 2/1/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Firebase
import FirebaseAuth



class SettingScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)
    }
    
    @IBOutlet weak var emailReset: UITextField!
    @IBOutlet weak var resetButton: UIButton!

    
    //reset password
    @IBAction func resetPassword(_ sender: UIButton) {
        if let email = emailReset.text {
            Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                if let err = error {
                    print("An error occured: ", err.localizedDescription)
                    return
                } else {
                    print("Password reset successfully...")
                }
            })
        }
    }
    
    //logout
    @IBAction func logOutTapped(_ sender: Any) {
        //message are you sure you want to log out
        let alert = UIAlertController(title: "Log Out?", message: "Are you sure you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] (action) in
            self?.logout()
        }))
        present(alert, animated: true, completion: nil)
        
    }
    
    private func logout() {
        try? Auth.auth().signOut()
        if let window = UIApplication.shared.keyWindow {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginScreen")
            window.rootViewController = vc
        }
    }
}

