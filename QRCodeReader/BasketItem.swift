//
//  BasketItem.swift
//  QRCodeReader
//
//  Created by Haya Alhumaid on 4/8/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation

struct BasketItem : Codable {
    var qrCode   : String
    var title    : String
    var imageURL : String
    var price    : Float
}

