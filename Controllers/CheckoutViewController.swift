////
////  CheckoutViewController.swift
////  QRCodeReader
////
////  Created by Haya Alhumaid on 4/9/19.
////  Copyright © 2019 AppCoda. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Stripe
//
//class CheckoutViewController: UIViewController, STPPaymentContextDelegate {
//
//
//    // If you prefer a modal presentation
//    func choosePaymentButtonTapped() {
//        self.paymentContext.presentPaymentOptionsViewController()
//    }
//
//    // If you prefer a navigation transition
////    func choosePaymentButtonTapped() {
////        self.paymentContext.pushPaymentOptionsViewController()
////    }
//
//    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
//        self.activityIndicator.animating = paymentContext.loading
//        self.paymentButton.enabled = paymentContext.selectedPaymentOption != nil
//        self.paymentLabel.text = paymentContext.selectedPaymentOption?.label
//        self.paymentIcon.image = paymentContext.selectedPaymentOption?.image
//    }
//
//
//    //submit payment
//    func payButtonTapped() {
//        self.paymentContext.requestPayment()
//    }
//
//    //check for errors
//    func paymentContext(_ paymentContext: STPPaymentContext,
//                        didCreatePaymentResult paymentResult: STPPaymentResult,
//                        completion: @escaping STPErrorBlock) {
//
//        MyAPIClient.createCharge(paymentResult.source.stripeID, completion: { (error: Error?) in
//            if let error = error {
//                completion(error)
//            } else {
//                completion(nil)
//            }
//        })
//    }
//
//    func paymentContext(_ paymentContext: STPPaymentContext,
//                        didFinishWithStatus status: STPPaymentStatus,
//                        error: Error?) {
//
//        switch status {
//        case .error:
//            self.showError(error)
//        case .success:
//            self.showReceipt()
//        case .userCancellation:
//            return // Do nothing
//        }
//    }
//
//    func paymentContext(_ paymentContext: STPPaymentContext,
//                        didFailToLoadWithError error: Error) {
//        self.navigationController?.popViewController(animated: true)
//        // Show the error to your user, etc.
//    }
//
//
//}
//
