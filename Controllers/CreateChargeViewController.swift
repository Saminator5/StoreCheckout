//
//  CreateChargeViewController.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 4/18/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation


import Foundation
import UIKit
import Stripe


class CreateChargeViewController: UIViewController, STPPaymentContextDelegate {
    @IBOutlet weak var paymentButton: UIButton!

    @objc func checkout(_sender: UIButton) {
        
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    private let customerContext = STPCustomerContext(keyProvider: MyAPIClient.shared)
    private var paymentContext = STPPaymentContext()
    
    @IBOutlet weak var paymentLabel: UILabel!
    
    @IBAction func checkout (_ sender: Any) {
        self.paymentContext.requestPayment()
    }
    
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {}
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        //self.activityIndicator.animating = paymentContext.loading
        self.paymentButton.isEnabled = paymentContext.selectedPaymentOption != nil
        self.paymentLabel.text = "testing"//paymentContext.selectedPaymentOption?.label
        //self.paymentIcon.image = paymentContext.selectedPaymentOption?.image
    }

    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {}
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {}

    
    
    init() {
        self.paymentContext = STPPaymentContext(customerContext: customerContext)
        super.init(nibName: nil, bundle: nil)
        self.paymentContext.delegate = self
        self.paymentContext.hostViewController = self
        self.paymentContext.paymentAmount = 5000 // This is in cents, i.e. $50 USD
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.paymentContext = STPPaymentContext(customerContext: customerContext)
        self.paymentContext.delegate = self
        self.paymentContext.hostViewController = self
        self.paymentContext.paymentAmount = 5000 // This is in cents, i.e. $50 USD

    }
}
