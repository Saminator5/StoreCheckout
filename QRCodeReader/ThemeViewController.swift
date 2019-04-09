//
//  ThemeViewController.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 4/9/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import CardParts

class ThemeViewController: CardsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Comment out one of the loadCard functions to change cards and/or their order
        let cards: [CardPartsViewController] = [
            ThemedCardController(title: "These"),
            ThemedCardController(title: "Are"),
            ThemedCardController(title: "Themed"),
            ThemedCardController(title: "Cards!")
        ]
        
        loadCards(cards: cards)
    }
}
