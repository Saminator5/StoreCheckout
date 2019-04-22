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
    var items = [CartItem]()
    var cards = [CardPartsViewController]()
    
    //MARK:- ViewController LifeCylce Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fetchCartItemsFromFirebase()
    }
    
    //MARK:- Methods
    func loadCartItems() {
        self.cards.removeAll()
        for item in self.items {
            let card = ThemedCardController(title: item.productName)
            card.delegate = self
            self.cards.append(card)
        }
        loadCards(cards: cards)
    }
    
    func fetchCartItemsFromFirebase() {
        self.items.removeAll()
        let basketRef = Database.database().reference(withPath: "basket").child(User.currentUser.id!)
        basketRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.value != nil {
                var cartItems = [CartItem]()
                for child in snapshot.children {
                    if let dataSnapshot = child as? DataSnapshot, let item = CartItem(snapshot: dataSnapshot) {
                        cartItems.append(item)
                    }
                }
                self.items = cartItems
                self.loadCartItems()
            }
        }
    }
    
    func deleteItemFromFirebase(barcodeNumber: String) {
        let basketRef = Database.database().reference(withPath: "basket").child(User.currentUser.id!).child(barcodeNumber)
        
        basketRef.removeValue { (error, ref) in
            if error != nil {
                print("Error while deleting data from firebase!")
            } else {
                print("Product deleted!")
            }
        }
    }
    
    func deleteAllItemFromFirebase() {
        let basketRef = Database.database().reference(withPath: "basket").child(User.currentUser.id!)
        
        basketRef.removeValue { (error, ref) in
            if error != nil {
                print("Error while deleting all data from firebase!")
            } else {
                print("Items deleted!")
            }
        }
    }
    
    func addItemInHistory(dictionary: [String: Any]) {
        let barcodeNumber = dictionary["barcode_number"] as! String
        let historyRef = Database.database().reference(withPath: "history").child(User.currentUser.id!).child(barcodeNumber)
        historyRef.updateChildValues(dictionary) { (error, ref) in
            if error != nil {
                print("Error while adding data on firebase!")
            } else {
                print("Item added ot History!")
            }
        }
    }
    
    func addAllItemsInHistory() {
        for item in self.items {
            self.addItemInHistory(dictionary: item.dictionary())
        }
        self.deleteAllItemFromFirebase()
        self.items.removeAll()
        self.loadCartItems()
    }
}

//MARK:- Button Action
extension ThemeViewController {
    //TODO: Checkout purpose. Please add stripe code inside this tap event.
    @IBAction func checkoutTapped() {
     self.addAllItemsInHistory()
    }
}

//MARK:- ThemedCardControllerDelegate Methods
extension ThemeViewController: ThemedCardControllerDelegate {
    func deleteItem(itemName: String) {
        for item in items {
            if item.productName == itemName {
                self.deleteItemFromFirebase(barcodeNumber: item.barcodeNumber)
                break
            }
        }
        self.fetchCartItemsFromFirebase()
    }
}


