//
//  MyAPIClient.swift
//  QRCodeReader
//
//  Created by Haya Alhumaid on 4/9/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import Alamofire
import Stripe

class MyAPIClient: NSObject, STPCustomerEphemeralKeyProvider {
    static let shared = MyAPIClient()
    
    var baseURLString: String? = "http://localhost:3000"
    var baseURL: URL {
        if let urlString = self.baseURLString, let url = URL(string: urlString) {
            return url
        }  else {
            fatalError()
        }
    }
    
    func completeCharge(result: STPPaymentResult, amount: Int,
                        completion: @escaping STPErrorBlock) {
        let url = self.baseURL.appendingPathComponent("charge")
        var params: [String: Any] = [
            "source": result.source.stripeID,
            "amount": amount,
            "currency": "USD"
        ]
        
        //params["shipping"] = STPAddress.shippingInfoForCharge(with: shippingAddress, shippingMethod: shippingMethod)
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .success(let json):
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
    
    func createAndConfirmPaymentIntent(_ result: STPPaymentResult,
                                       amount: Int,
                                       returnURL: String,
                                       shippingAddress: STPAddress?,
                                       shippingMethod: PKShippingMethod?,
                                       completion: @escaping STPPaymentIntentCompletionBlock) {
        let url = self.baseURL.appendingPathComponent("capture_payment")
        var params: [String: Any] = [
            "source": result.source.stripeID,
            "amount": amount,
            "return_url": returnURL,
            "metadata": [
                // example-ios-backend allows passing metadata through to Stripe
                "payment_request_id": "B3E611D1-5FA1-4410-9CEC-00958A5126CB",
            ],
            ]
        params["shipping"] = STPAddress.shippingInfoForCharge(with: shippingAddress, shippingMethod: shippingMethod)
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let json):
                    completion(STPPaymentIntent.decodedObject(fromAPIResponse: json as? [AnyHashable: Any]), nil)
                case .failure(let error):
                    completion(nil, error)
                }
            })
    }
    
    func confirmPaymentIntent(_ paymentIntent: STPPaymentIntent, completion: @escaping STPPaymentIntentCompletionBlock) {
        let url = self.baseURL.appendingPathComponent("confirm_payment")
        let params: [String: Any] = ["payment_intent_id": paymentIntent.stripeId]
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let json):
                    completion(STPPaymentIntent.decodedObject(fromAPIResponse: json as? [AnyHashable: Any]), nil)
                case .failure(let error):
                    completion(nil, error)
                }
            })
    }
    
    func completePayment(_ result: STPPaymentResult,
                         amount: Int,
                         shippingAddress: STPAddress?,
                         shippingMethod: PKShippingMethod?,
                         completion: @escaping STPErrorBlock) {
        let url = self.baseURL.appendingPathComponent("confirm_payment")
        var params: [String: Any] = [
            "source": result.source.stripeID,
            "amount": amount,
            "metadata": [
                // example-ios-backend allows passing metadata through to Stripe
                "charge_request_id": "B3E611D1-5FA1-4410-9CEC-00958A5126CB",
            ],
            ]
        params["shipping"] = STPAddress.shippingInfoForCharge(with: shippingAddress, shippingMethod: shippingMethod)
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }

    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let url = self.baseURL.appendingPathComponent("ephemeral_keys")
        Alamofire.request(url, method: .post, parameters: ["api_version": apiVersion])
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
    
    
}
