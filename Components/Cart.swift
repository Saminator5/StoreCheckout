//
//  Cart.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 4/6/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import UIKit

var cart:[(name: String, value: Int)] = []

func addItemToCart(name: String, value: Int) {
    cart += [(name: name, value: value)]
}
