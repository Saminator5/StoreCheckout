//
//  UIViewController+Alerts.swift
//  QRCodeReader
//
//  Created by Haya Alhumaid on 3/24/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}


