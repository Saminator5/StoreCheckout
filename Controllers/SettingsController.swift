////
////  SettingsController.swift
////  QRCodeReader
////
////  Created by Samuel Lefcourt on 4/9/19.
////  Copyright © 2019 AppCoda. All rights reserved.
//
//import Foundation
//import UIKit
//import MapKit
//import Stripe
//
//class SettingsViewController: UIViewController, STPPaymentContextDelegate {
//
//    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
//        // Create charge using payment result
//        let source = paymentResult.source.stripeID
//
//        MyAPIClient.shared.completeCharge(result: paymentResult, amount: price) { [weak self] (error) in
//            guard error == nil else {
//                // Error while requesting ride
//                print("error: ", error)
//                return
//            }
//
//            // Save ride info to display after payment finished
//            print("completed charge")
//        }
//    }
////
//    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
//
//    }
//
//    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
//        // Reload related components
//        reloadPaymentButtonContent()
//
//    }
//
//
//
//
//    // Controllers
//
//    private let customerContext: STPCustomerContext
//    private let paymentContext: STPPaymentContext
//
//    private var price = 20 {
//        didSet {
//            // Forward value to payment context
//            paymentContext.paymentAmount = price
//        }
//    }
//
//    // Views
//    @IBOutlet var inputContainerView: UIView!
//    @IBOutlet var destinationButton: UIButton!
//    @IBOutlet var paymentButton: UIButton!
//    @IBOutlet var priceButton: UIButton!
//
//    @IBOutlet var rideDetailsView: UIView!
//    @IBOutlet var pilotView: UIView!
//    @IBOutlet var pilotViewNameLabel: UILabel!
//    @IBOutlet var vehicleView: UIView!
//    @IBOutlet var vehicleViewModelLabel: UILabel!
//    @IBOutlet var vehicleViewLicenseLabel: UILabel!
//
//
//    // MARK: Init
//
//    required init?(coder aDecoder: NSCoder) {
//        //customerContext = STPCustomerContext(keyProvider: MyAPIClient.shared)
//        paymentContext = STPPaymentContext(customerContext: customerContext)
//
//        super.init(coder: aDecoder)
//
//        paymentContext.delegate = self
//        paymentContext.hostViewController = self
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//
//    // MARK: Button Handlers
//
//
//    @IBAction
//    private func handlePaymentButtonTapped() {
//        presentPaymentMethodsViewController()
//    }
//
//    @IBAction
//    private func handlePriceButtonTapped() {
//        presentPaymentMethodsViewController()
//    }
//
//    // MARK: Helpers
//
//    private func presentPaymentMethodsViewController() {
//
//        // Present the Stripe payment methods view controller to enter payment details
//        paymentContext.presentPaymentOptionsViewController()
//    }
//
//    private func reloadPaymentButtonContent() {
//        guard let selectedPaymentMethod = paymentContext.selectedPaymentOption else {
//            // Show default image, text, and color
//            paymentButton.setImage(#imageLiteral(resourceName: "Payment"), for: .normal)
//            paymentButton.setTitle("Payment", for: .normal)
//            paymentButton.setTitleColor(UIColor.gray, for: .normal)
//            return
//        }
//
//        // Show selected payment method image, label, and darker color
//        paymentButton.setImage(selectedPaymentMethod.image, for: .normal)
//        paymentButton.setTitle(selectedPaymentMethod.label, for: .normal)
//        paymentButton.setTitleColor(UIColor.gray, for: .normal)
//    }
//
//
//    // MARK: STPPaymentContextDelegate
//
//    }
//
