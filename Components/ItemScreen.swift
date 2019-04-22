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
import Firebase

class ItemViewController: UIViewController {
    
    //MARK:- Interface Builder
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productManufacturer: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var qtyTextField: UITextField!
    
    
    //MARK:- Properties
    var productInfo: String!
    var url: String! = ""
    var data: Data? = nil
    var productDictionary = [String: AnyObject]()
    
    //MARK:- ViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        if(self.data == nil) {
            self.productName.text = "Loading..."
        }  else {
            self.productName.text = "Got it!"
            self.productInfo = String(data: self.data!, encoding: .utf8)!
            productDictionary = JSONParseDictionary(string: self.productInfo)
            for item in productDictionary["products"] as! [AnyObject] {
                print(item)
                self.productName.text = item["product_name"] as? String
                //self.productCategory.text = item["category"] as! String
                self.productManufacturer.text = item["manufacturer"] as? String
                
                
                let stores: Array<Dictionary<String, String>> = item["stores"] as! Array<Dictionary<String, String>>
                if(stores.count > 0) {
                    let store = stores[0]
                    let price = store["store_price"]!
                    let name = store["store_name"]!
                    self.productPrice.text = "Available for $\(price) at \(name)"
                }
                
                
                
                let images:Array<String> = item["images"] as! Array<String>
                if(images.count > 0) {
                    self.url = images[0]
                }  else {
                    self.url = "https://cdn.browshot.com/static/images/not-found.png"
                }
            }
            
            let url = URL(string: self.url)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            imageView.image = UIImage(data: data!)
        }
    }
    
    func saveProductIntoCart(product: [String: Any]) {
        if let cartItems = UserDefaults.standard.value(forKey: "Cart") as? [[String: Any]] {
            var cartProducts = cartItems
            var addItem = true
            for item in cartProducts {
                if product["barcode_number"] as! String == item["barcode_number"] as! String {
                    addItem = false
                    break
                }
            }
            if addItem == true {
                cartProducts.append(product)
            }
            UserDefaults.standard.set(cartProducts, forKey: "Cart")
        } else {
            var cartProducts = [[String: Any]]()
            cartProducts.append(product)
            UserDefaults.standard.set(cartProducts, forKey: "Cart")
        }
        
    }
    
    //MARK:- Methods
    func saveProductOnFirebase(product: [String: AnyObject]) {
        
        var finalProductDictionary = [String: Any]()
        var barcodeNumber = ""
        
        for item in productDictionary["products"] as! [AnyObject] {
            print(item)
            finalProductDictionary["product_name"] = item["product_name"] as! String
            finalProductDictionary["manufacturer"] = item["manufacturer"] as! String
            barcodeNumber = item["barcode_number"] as! String
            finalProductDictionary["barcode_number"] = barcodeNumber
            
            let stores: Array<Dictionary<String, String>> = item["stores"] as! Array<Dictionary<String, String>>
            if(stores.count > 0) {
                let store = stores[0]
                let price = store["store_price"]!
                let name = store["store_name"]!
                finalProductDictionary["price"] = "Available for $\(price) at \(name)"
            }
            finalProductDictionary["url"] = self.url
        }
        
        finalProductDictionary["quantity"] = self.qtyTextField.text!
        
        let basketRef = Database.database().reference(withPath: "basket").child(User.currentUser.id!).child(barcodeNumber)
        basketRef.updateChildValues(finalProductDictionary) { (error, ref) in
            if error != nil {
                print("Error while adding data on firebase!")
            } else {
                //TODO: Save finalProductDictionary to UserDefaults
                print("Product added!")
                self.saveProductIntoCart(product: finalProductDictionary)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }

}

//MARK:- Button Actions
extension ItemViewController {
    @IBAction func addItem(_ sender: Any) {
        if self.qtyTextField.text != "" {
            self.saveProductOnFirebase(product: self.productDictionary)
        } else {
            self.presentOKAlert(title: "Error!", message: "Please enter quantity.")
        }
    }
}

