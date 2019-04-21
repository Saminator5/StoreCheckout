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
import Firebase

class ThemeViewController: CardsViewController {
    
    //MARK:- Properties
    var cartItems = [[String: Any]]()
    var cards = [CardPartsViewController]()
    
    //MARK:- ViewController LifeCylce Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadCartItems()
    }
    
    //MARK:- Methods
    func loadCartItems() {
        self.cards.removeAll()
        if let cartItems = UserDefaults.standard.value(forKey: "Cart") as? [[String: Any]] {
            for item in cartItems {
                let card = ThemedCardController(title: item["product_name"] as! String)
                card.delegate = self
                self.cards.append(card)
            }
            loadCards(cards: cards)
        }
    }
    
    func deleteItemFromFirebase(barcodeNumber: String) {
        let basketRef = Database.database().reference(withPath: "basket").child(barcodeNumber)
        
        basketRef.removeValue { (error, ref) in
            if error != nil {
                print("Error while deleting data from firebase!")
            } else {
                print("Product deleted!")
            }
        }
    }
    
    
}

extension ThemeViewController: ThemedCardControllerDelegate {
    func deleteItem(itemName: String) {
        print(itemName)
        
        if let cartItems = UserDefaults.standard.value(forKey: "Cart") as? [[String: Any]] {
            var items = cartItems
            for (index, item) in items.enumerated() {
                if item["product_name"] as! String == itemName {
                    self.deleteItemFromFirebase(barcodeNumber: item["barcode_number"] as! String)
                    items.remove(at: index)
                    UserDefaults.standard.set(items, forKey: "Cart")
                    break
                }
            }
            self.loadCartItems()
        }
    }
}


