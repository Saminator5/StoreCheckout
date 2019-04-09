
import Foundation
import CardParts

class ItemCard: CardPartsFullScreenViewController {
    
    //let cardPartTitleView = CardPartTitleView(type: .titleOnly)
    let cardPartTitleWithMenu = CardPartTitleView(type: .titleWithMenu)
    
    let cardPartImage = CardPartImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)
        let url = URL(string: "https://target.scene7.com/is/image/Target/GUEST_450f229a-c03b-41ab-a74c-c0a42b3a61d1?wid=488&hei=488&fmt=pjpeg")
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cardPartImage.image = UIImage(data: data!)?.withAlignmentRectInsets(UIEdgeInsets(top: -50, left: 0, bottom: -50, right: 0))
        
        let productName = CardPartTextView(type: .header)
        productName.text = "Li'l Critters Vitamins"
        //productName.textAlignment = .center
        productName.textColor = Colors.black
    
        cardPartImage.contentMode = .scaleAspectFit
        cardPartImage.addConstraint(NSLayoutConstraint(item: cardPartImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 300))
        
        let priceButton = CardPartButtonView()
        priceButton.setTitle("$12.99", for: .normal)
        priceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        priceButton.titleLabel?.textAlignment = NSTextAlignment.center
        //priceButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        priceButton.backgroundColor = Colors.white
        priceButton.layer.cornerRadius = 5
        priceButton.layer.borderWidth = 1
        priceButton.layer.borderColor = Colors.green.cgColor
        priceButton.setTitleColor(Colors.green, for: .normal)
        
        let cardPartSeparatorView = CardPartSeparatorView()

        let barcode = CardPartButtonView()
        barcode.setTitle("02791701945", for: .normal)
        let scannerImage = UIImage(named: "barcode-reader")
        barcode.setImage(scannerImage, for: .normal)
        
        setupCardParts([cardPartImage, cardPartSeparatorView, productName, barcode, priceButton])
    }
    
}
