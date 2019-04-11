//
//  FirebaseService.swift
//  QRCodeReader
//
//  Created by Haya Alhumaid on 4/8/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FirebaseService {
    static let shared = FirebaseService()
    
    
    
    func saveBasketItem(productResponse: [String : Any]) {
        
        //let item = BasketItem(qrCode: "alskdfjalskjflaskjdf", title: "My Item", imageURL: "https://www.google.com", price: 20.0)
        
        /*
         The Firebase structure
         
         /basket/<user ID>/<item id>/<product JSON>
         */
        
        // Make sure the user is logged in
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("basket").child(userId).childByAutoId().setValue(productResponse)
            
    }
}
