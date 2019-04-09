//
//  ItemScreen.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 2/27/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
class ItemViewController: UIViewController {
    
    var productInfo: String!
    
    @IBOutlet weak var productName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)
        print("Item: ", productInfo)
        self.productName.text = "Vapor Distilled Water"
    }

}

