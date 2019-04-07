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
    
    @IBOutlet weak var imageView: UIImageView!
    var productInfo: String!
    var url: String! = ""
    var data: Data? = nil
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addItem(_ sender: Any) {
        addItemToCart(name: self.productName.text!, value: 1)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.productInfo = String(data: self.data!, encoding: .utf8)
//    }
//
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productManufacturer: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)
        
        if(self.data == nil) {
            self.productName.text = "Loading..."
        }  else {
            self.productName.text = "Got it!"
            self.productInfo = String(data: self.data!, encoding: .utf8)!
            let dictionary = JSONParseDictionary(string: self.productInfo)
            for item in dictionary["products"] as! [AnyObject] {
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

}

