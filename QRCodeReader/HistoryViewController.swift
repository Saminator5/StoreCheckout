//
//  HistoryViewController.swift
//  QRCodeReader
//
//  Created by Sagar Unagar on 22/04/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import CardParts
import Firebase

class HistoryViewController: CardsViewController {

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
            let card = ThemedCardController(title: item.productName, quantity: item.quantity)
            card.delegate = self
            self.cards.append(card)
        }
        loadCards(cards: cards)
    }
    
    func fetchCartItemsFromFirebase() {
        self.items.removeAll()
        let historyRef = Database.database().reference(withPath: "history").child(User.currentUser.id!)
        historyRef.observeSingleEvent(of: .value) { (snapshot) in
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
        let historyRef = Database.database().reference(withPath: "history").child(User.currentUser.id!).child(barcodeNumber)
        
        historyRef.removeValue { (error, ref) in
            if error != nil {
                print("Error while deleting data from firebase!")
            } else {
                print("Product deleted!")
            }
        }
    }
}

//MARK:- ThemedCardControllerDelegate Methods
extension HistoryViewController: ThemedCardControllerDelegate {
    func itemQtyChanged(itemName: String, qty: Int) {
        
    }
    
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
