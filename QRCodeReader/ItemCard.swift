
import Foundation
import CardParts

class ItemCard: CardPartsFullScreenViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)
    
        // Rendering Image
        let cardPartImage = CardPartImageView()
        cardPartImage.contentMode = .scaleAspectFit
        cardPartImage.addConstraint(NSLayoutConstraint(item: cardPartImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 300))
        let url = URL(string: "https://target.scene7.com/is/image/Target/GUEST_450f229a-c03b-41ab-a74c-c0a42b3a61d1?wid=488&hei=488&fmt=pjpeg")
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
        let productName = CardPartTextView(type: .header)
        productName.text = "L'il Critters Vitamins"
        productName.textColor = Colors.black
        
        // So that user can ensure same product
        let barcode = CardPartButtonView()
        barcode.titleEdgeInsets = UIEdgeInsetsMake(15,5,5,15)
        barcode.setTitle("02791701945", for: .normal)
        let scannerImage = UIImage(named: "barcode-reader")
        barcode.setImage(scannerImage, for: .normal)
        
        // Rendering price button
        let priceButton = CardPartButtonView()
        barcode.titleEdgeInsets = UIEdgeInsetsMake(30,0,0,0)

        priceButton.setTitle("$12.99", for: .normal)
        priceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        priceButton.titleLabel?.textAlignment = NSTextAlignment.center
        priceButton.backgroundColor = Colors.white
        priceButton.layer.cornerRadius = 5
        priceButton.layer.borderWidth = 1
        priceButton.layer.borderColor = Colors.green.cgColor
        priceButton.setTitleColor(Colors.green, for: .normal)
        
        
        // Display ordering
        setupCardParts([cardPartImage, cardPartSeparatorView, productName, barcode, priceButton])
    }
    
}
