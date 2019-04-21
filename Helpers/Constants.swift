//
//  Colors.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 1/31/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import Stripe
struct Colors {
    
    static let brightOrange     = UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let red              = UIColor(red: 255.0/255.0, green: 115.0/255.0, blue: 115.0/255.0, alpha: 1.0)
    static let orange           = UIColor(red: 255.0/255.0, green: 175.0/255.0, blue: 72.0/255.0, alpha: 1.0)
    static let blue             = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    static let green            = UIColor(red: 91.0/255.0, green: 197.0/255.0, blue: 159.0/255.0, alpha: 1.0)
    static let darkGrey         = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
    static let veryDarkGrey     = UIColor(red: 13.0/255.0, green: 13.0/255.0, blue: 13.0/255.0, alpha: 1.0)
    static let lightGrey        = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
    static let black            = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let white            = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let lavender         = UIColor(red:204/255, green:102/255, blue:255/255, alpha:1.0)
    static let aqua             = UIColor(red:0/255, green:128/255, blue:255/255, alpha:1.0)
    static let specialPurple = UIColor(red: 181.0 / 255.0, green: 152.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
    static let specialBlue = UIColor(red: 30.0 / 255.0, green: 211.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0) // blue

}


func setHeight(textField: UITextField, height: Int) {
    var rect = textField.frame
    rect.size.height = 45; // <-- Specify the height you want here.
    
    textField.frame = rect
}

//let customerContext = STPCustomerContext(keyProvider: MyAPIClient.sharedClient)
//
