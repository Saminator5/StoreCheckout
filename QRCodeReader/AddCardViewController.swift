//
//  AddCardViewController.swift
//  QRCodeReader
//
//  Created by Haya Alhumaid on 4/22/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import Stripe


class AddNewCardViewController: UIViewController, STPAddCardViewControllerDelegate {
    
    
    func handleAddPaymentOptionButtonTapped() {
        // Setup add card view controller
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        
        // Present add card view controller
        let navigationController = UINavigationController(rootViewController: addCardViewController)
        present(navigationController, animated: true)
    }
    
    // MARK: STPAddCardViewControllerDelegate
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        // Dismiss add card view controller
        dismiss(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        //    submitTokenToBackend(token, completion: { (error: Error?) in
        //        if let error = error {
        //            // Show error in add card view controller
        //            completion(error)
        //        }
        //        else {
        //            // Notify add card view controller that token creation was handled successfully
        //            completion(nil)
        //
        //            // Dismiss add card view controller
        //            dismiss(animated: true)
        //        }
        //    })
    }
    
    
    
}

