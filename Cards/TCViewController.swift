//
//  TCViewController.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 4/9/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//
import CardParts
import Foundation
class ThemedCardController: CardPartsViewController {
    
    let possibleGradientColors: [UIColor] = [
        UIColor(red: 181.0 / 255.0, green: 152.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0), // purple
        UIColor(red: 30.0 / 255.0, green: 211.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0), // blue
//        UIColor(red: 63.0 / 255.0, green: 236.0 / 255.0, blue: 216.0 / 255.0, alpha: 1.0),
      //  UIColor(red: 27.0 / 255.0, green: 205.0 / 255.0, blue: 156.0 / 255.0, alpha: 1.0),
     //   UIColor(red: 10.0 / 255.0, green: 199.0 / 255.0, blue: 117.0 / 255.0, alpha: 1.0),
//        UIColor(red: 17.0 / 255.0, green: 174.0 / 255.0, blue: 155.0 / 255.0, alpha: 1.0),
        //Colors.aqua, Colors.lightGrey, Colors.orange, Colors.brightOrange, Colors.green, Colors.lavender
    ]
    
    var _title: String = ""
    
    convenience init(title: String) {
        self.init(nibName: nil, bundle: nil)
        self._title = title
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleCP = CardPartTextView(type: .header)
        titleCP.text = self._title
        titleCP.textAlignment = .center
        titleCP.textColor = .white
        
        let separator = CardPartVerticalSeparatorView()
        
        let leftStack = CardPartStackView()
        leftStack.axis = .vertical
        leftStack.spacing = 10
        
        let rightStack = CardPartStackView()
        rightStack.axis = .vertical
        rightStack.spacing = 10
        
        let textView = CardPartTextView(type: .normal)
        textView.text = "$33.99"
        textView.textColor = .black
        let textView2 = CardPartTextView(type: .normal)
        textView2.textColor = .black
        
        textView2.text = "This is a second label with text"
        
        let textView3 = CardPartTextView(type: .normal)
        textView3.textColor = .black
        
        textView3.text = "This is a third label with text"
        let textView4 = CardPartTextView(type: .normal)
        textView4.textColor = .black
        
        textView4.text = "This is a fourth label with text"
        
        let buttonCP = CardPartButtonView()
        buttonCP.setTitle("", for: .normal)
        buttonCP.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let trashImage = UIImage(named: "red-trash")
        buttonCP.setImage(trashImage, for: .normal)
        
        let incQuantity = CardPartButtonView()
        incQuantity.setTitle("+", for: .normal)
        incQuantity.setTitleColor(.white, for: .normal)
        incQuantity.addTarget(self, action: #selector(incQuantityNow), for: .touchUpInside)

        leftStack.addArrangedSubview(textView)
        leftStack.addArrangedSubview(buttonCP)
        
        rightStack.addArrangedSubview(textView3)
        rightStack.addArrangedSubview(incQuantity)
        
        let centeredView = CardPartCenteredView(leftView: leftStack, centeredView: separator, rightView: rightStack)
        
        setupCardParts([centeredView])
        
      
//        let cardPartTextView = CardPartTextView(type: .normal)
//        cardPartTextView.font = UIFont.preferredFont(forTextStyle: .subheadline)
//        cardPartTextView.textColor = UIColor(red: 0.175, green: 0.458, blue: 0.831, alpha: 1)
//        cardPartTextView.text = "$3.99"
//        
//        setupCardParts([cardPartTextView, titleCP, buttonCP, incQuantity])
        
//        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 280))
    }
    
    @objc func incQuantityNow() {
        
        let alertController = UIAlertController(title: "Inc!", message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func buttonTapped() {
        
        let alertController = UIAlertController(title: "Remove!", message: "Are you sure!?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}



extension ThemedCardController: ShadowCardTrait {
    func shadowColor() -> CGColor {
        return UIColor.lightGray.cgColor
    }
    
    func shadowRadius() -> CGFloat {
        return 10.0
    }
    
    func shadowOpacity() -> Float {
        return 0.8
    }
}

extension ThemedCardController: RoundedCardTrait {
    func cornerRadius() -> CGFloat {
        return 30.0
    }
}

extension ThemedCardController: GradientCardTrait {
    func gradientColors() -> [UIColor] {
        
        let color1: UIColor = self.possibleGradientColors[Int(arc4random_uniform(UInt32(self.possibleGradientColors.count)))]
        var color2: UIColor = self.possibleGradientColors[Int(arc4random_uniform(UInt32(self.possibleGradientColors.count)))]
        
        while color1 == color2 {
            color2 = self.possibleGradientColors[Int(arc4random_uniform(UInt32(self.possibleGradientColors.count)))]
        }
        
        return [color1, color2]
    }
    
    func gradientAngle() -> Float {
        return 45.0
    }
}
