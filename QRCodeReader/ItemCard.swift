
import Foundation
import CardParts

class ItemCard: CardPartsFullScreenViewController {
    
    //let cardPartTitleView = CardPartTitleView(type: .titleOnly)
    let cardPartTitleWithMenu = CardPartTitleView(type: .titleWithMenu)
    
    let cardPartImage = CardPartImageView(image: UIImage(named: "cardPartsLogo"))
    let titlePart = CardPartTitleView(type: .titleWithMenu)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)
        let url = URL(string: "https://cdn.browshot.com/static/images/not-found.png")
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cardPartImage.image = UIImage(data: data!)
        
        titlePart.menuTitle = "Hide this offer"
        titlePart.menuOptions = ["Hide"]
        titlePart.menuOptionObserver  = {[weak self] (title, index) in
            // Logic to determine which menu option was clicked
            // and how to respond
            if index == 0 {
                //self?.hideOfferClicked()
            }
        }
        
       // cardPartTitleView.title = "I am a standard .titleOnly CardPartTitleView"
       // cardPartTitleWithMenu.title = "I am a .titleWithMenu CardPartTitleView"
        
        cardPartImage.contentMode = .scaleAspectFit
        cardPartImage.addConstraint(NSLayoutConstraint(item: cardPartImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 300))
        
        setupCardParts([cardPartImage, titlePart])
    }
    
}

public class CardPartsSamTheme: CardPartsTheme {
    
    public var cardsViewContentInsetTop: CGFloat = 0.0
    public var cardsLineSpacing: CGFloat = 12
    
    public var cardShadow: Bool = true
    public var cardCellMargins: UIEdgeInsets = UIEdgeInsets(top: 9.0, left: 12.0, bottom: 12.0, right: 12.0)
    public var cardPartMargins: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 15.0, bottom: 5.0, right: 15.0)
    
    // CardPartSeparatorView
    public var separatorColor: UIColor = Colors.lightGrey
    public var horizontalSeparatorMargins: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 15.0, bottom: 5.0, right: 15.0)
    
    // CardPartTextView
    public var smallTextFont: UIFont = UIFont(name: "HelveticaNeue", size: CGFloat(10))!
    public var smallTextColor: UIColor = Colors.white
    public var normalTextFont: UIFont = UIFont(name: "HelveticaNeue", size: CGFloat(14))!
    public var normalTextColor: UIColor = Colors.white
    public var titleTextFont: UIFont = UIFont(name: "HelveticaNeue-Medium", size: CGFloat(16))!
    public var titleTextColor: UIColor = Colors.white
    public var headerTextFont: UIFont = UIFont (name: "Helvetica Neue", size: 30)!
    public var headerTextColor: UIColor = Colors.white
    public var detailTextFont: UIFont = UIFont(name: "HelveticaNeue", size: CGFloat(12))!
    public var detailTextColor: UIColor = Colors.white
    
    // CardPartTitleView
    public var titleFont: UIFont = UIFont(name: "HelveticaNeue-Medium", size: CGFloat(16))!
    public var titleColor: UIColor = Colors.white
    public var titleViewMargins: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 15.0, bottom: 10.0, right: 15.0)
    
    // CardPartButtonView
    public var buttonTitleFont: UIFont = UIFont(name: "HelveticaNeue", size: CGFloat(17))!
    public var buttonTitleColor: UIColor = UIColor(red: 69.0/255.0, green: 202.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    public var buttonCornerRadius: CGFloat = CGFloat(0.0)
    
    // CardPartBarView
    public var barBackgroundColor: UIColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0)
    public var barColor: UIColor = Colors.brightOrange
    public var todayLineColor: UIColor = Colors.brightOrange
    public var barHeight: CGFloat = 13.5
    public var roundedCorners: Bool = false
    public var showTodayLine: Bool = true
    
    // CardPartTableView
    public var tableViewMargins: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 14.0, bottom: 0.0, right: 14.0)
    
    // CardPartTableViewCell and CardPartTitleDescriptionView
    public var leftTitleFont: UIFont = UIFont(name: "HelveticaNeue", size: CGFloat(17))!
    public var leftDescriptionFont: UIFont = UIFont(name: "HelveticaNeue", size: CGFloat(12))!
    public var rightTitleFont: UIFont = UIFont(name: "HelveticaNeue", size: CGFloat(17))!
    public var rightDescriptionFont: UIFont = UIFont(name: "HelveticaNeue", size: CGFloat(12))!
    public var leftTitleColor: UIColor = Colors.aqua
    public var leftDescriptionColor: UIColor = Colors.aqua
    public var rightTitleColor: UIColor = Colors.aqua
    public var rightDescriptionColor: UIColor = Colors.aqua
    public var secondaryTitlePosition : CardPartSecondaryTitleDescPosition = .right
    
    public init() {
        
    }
}
