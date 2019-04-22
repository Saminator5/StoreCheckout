//
//  Cart.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 4/6/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CartItem {
    var barcodeNumber: String
    var manufacturer: String
    var productName: String
    var price: String
    var url: String
    var quantity: String
    
    init() {
        self.barcodeNumber = ""
        self.manufacturer = ""
        self.productName = ""
        self.price = ""
        self.url = ""
        self.quantity = ""
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let barcodeNumber = value["barcode_number"] as? String,
            let manufacturer = value["manufacturer"] as? String,
            let productName = value["product_name"] as? String,
            let price = value["price"] as? String,
            let url = value["url"] as? String,
            let qty = value["quantity"] as? String else {
                return nil
        }
        
        self.barcodeNumber = barcodeNumber
        self.manufacturer = manufacturer
        self.productName = productName
        self.price = price
        self.url = url
        self.quantity = qty
    }
    
    func dictionary() -> [String: Any] {
        var dic = [String: Any]()
        dic["barcode_number"] = self.barcodeNumber
        dic["manufacturer"] = self.manufacturer
        dic["product_name"] = self.productName
        dic["price"] = self.price
        dic["url"] = self.url
        dic["quantity"] = self.quantity
        return dic
    }
    
}


