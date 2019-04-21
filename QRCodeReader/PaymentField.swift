//
//  PaymentField.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 4/9/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import Stripe
import UIKit

class PaymentField: UIViewController, STPPaymentCardTextFieldDelegate {
    
    let paymentCardTextField = STPPaymentCardTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: UIColor.gray, colorTwo: UIColor.green)
        // Setup payment card text field
        paymentCardTextField.delegate = self
        
        // Add payment card text field to view
        view.addSubview(paymentCardTextField)
    }
}

// MARK: STPPaymentCardTextFieldDelegate

//func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
//    // Toggle buy button state
//    buyButton.enabled = textField.isValid
//}
