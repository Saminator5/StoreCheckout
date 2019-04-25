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
        print("self.cards in loadcart items: ", self.cards)
        self.cards.removeAll()
        print("self.items loadcartitems: ", self.items)
        for item in self.items {
            let card = ThemedCardController(title: item.productName, quantity: item.quantity)
            card.delegate = self
            self.cards.append(card)
        }
        loadCards(cards: self.cards)
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
                print("cart items: ", self.items)
                self.loadCartItems()
            }
        }
        print("finished fetching items")
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
    
    func fetchCartItemsFromFirebaseandAddToHistory() {
        print("fetchcartitemsandputinhistory")
        let basketRef = Database.database().reference(withPath: "basket").child(User.currentUser.id!)
        basketRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.value != nil {
                var cartItems = [CartItem]()
                for child in snapshot.children {
                    print("in child")
                    if let dataSnapshot = child as? DataSnapshot, let item = CartItem(snapshot: dataSnapshot) {
                        print("data snapshot recovered")
                        cartItems.append(item)
                    }
                    
                }
                
                self.items = cartItems
                print("cart items: ", self.items)
                //self.loadCartItems()
                //self.addAllItemsInHistory()

            }
        }
       
    }
    
    func updateItemQty(dictionary: [String: Any]) {
        let barcodeNumber = dictionary["barcode_number"] as! String
        let basketRef = Database.database().reference(withPath: "basket").child(User.currentUser.id!).child(barcodeNumber)
        basketRef.updateChildValues(dictionary) { (error, ref) in
            if error != nil {
                print("Error while updating data on firebase!")
            } else {
                print("Item added ot History!")
            }
        }
    }
}

//MARK:- Button Action
extension ThemeViewController {
    @IBAction func checkoutTapped() {
        self.performSegue(withIdentifier: "goToBuy", sender: self)
    }
}

//MARK:- ThemedCardControllerDelegate Methods
extension ThemeViewController: ThemedCardControllerDelegate {
    func itemQtyChanged(itemName: String, qty: Int) {
        for item in items {
            if item.productName == itemName {
                var itemDic = item.dictionary()
                itemDic["quantity"] = String(qty)
                self.updateItemQty(dictionary: itemDic)
                break
            }
        }
        self.fetchCartItemsFromFirebase()
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

//MARK:- Segue
extension ThemeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBuy" {
            let vc = segue.destination as! CheckoutViewController
            vc.items = self.items
        }
    }
}



