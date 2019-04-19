
import Foundation
import CardParts

class ItemCard: CardPartsFullScreenViewController {
    var productInfo: String!
    var url: String! = ""
    var data: Data? = nil
    let productName = CardPartTextView(type: .header)
    var barcodeNum = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)
        
        let priceButton = CardPartButtonView()
        
        priceButton.setTitle("$12.99", for: .normal)
        priceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        priceButton.titleLabel?.textAlignment = NSTextAlignment.center
        priceButton.backgroundColor = Colors.white
        priceButton.layer.cornerRadius = 5
        priceButton.layer.borderWidth = 1
        priceButton.layer.borderColor = Colors.green.cgColor
        priceButton.setTitleColor(Colors.green, for: .normal)
        
        // get info
        if(self.data == nil) {
            productName.text = "Loading..."
        }  else {
            productName.text = "Got it!"
            self.productInfo = String(data: self.data!, encoding: .utf8)!
            let dictionary = JSONParseDictionary(string: self.productInfo)
            
            
            for item in dictionary["products"] as! [AnyObject] {
                print(item)
                productName.text = item["product_name"] as? String
                self.barcodeNum = item["barcode_number"] as! String
                let stores: Array<Dictionary<String, String>> = item["stores"] as! Array<Dictionary<String, String>>
                if(stores.count > 0) {
                    let store = stores[0]
                    let price = store["store_price"]!
                    let name = store["store_name"]!
                    priceButton.setTitle("$\(price)", for: .normal)
                }
                
                
                
                let images:Array<String> = item["images"] as! Array<String>
                if(images.count > 0) {
                    self.url = images[0]
                }  else {
                    self.url = "https://cdn.browshot.com/static/images/not-found.png"
                }
            }
            
            let cardPartImage = CardPartImageView()
            cardPartImage.contentMode = .scaleAspectFit
            cardPartImage.addConstraint(NSLayoutConstraint(item: cardPartImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 300))
            let url = URL(string: self.url)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            cardPartImage.image = UIImage(data: data!)?.withAlignmentRectInsets(UIEdgeInsets(top: -50, left: 0, bottom: -50, right: 0))
        
        // Seperating Content
        let cardPartSeparatorView = CardPartSeparatorView()
        
        let cardPartSeparatorView1 = CardPartSeparatorView()
        cardPartSeparatorView1.backgroundColor = .clear
        cardPartSeparatorView1.layoutMargins = UIEdgeInsets(top: 00.0, left: 15.0, bottom: 50.0, right: 15.0)
        
        let cardPartSeparatorView2 = CardPartSeparatorView()
        cardPartSeparatorView2.backgroundColor = .clear
        cardPartSeparatorView2.layoutMargins = UIEdgeInsets(top: 00.0, left: 15.0, bottom: 50.0, right: 15.0)
        
        // Rendering product name
//        let productName = CardPartTextView(type: .header)
        //productName.text = "L'il Critters Vitamins"
        productName.textColor = Colors.black
        
        // So that user can ensure same product
        let barcode = CardPartButtonView()
        barcode.titleEdgeInsets = UIEdgeInsetsMake(15,5,5,15)
        barcode.setTitle(self.barcodeNum, for: .normal)
        let scannerImage = UIImage(named: "barcode-reader")
        barcode.setImage(scannerImage, for: .normal)
        barcode.titleEdgeInsets = UIEdgeInsetsMake(30,0,0,0)

        // Display ordering
        setupCardParts([cardPartImage, cardPartSeparatorView, productName, barcode, priceButton])
    }
    
  }
}
