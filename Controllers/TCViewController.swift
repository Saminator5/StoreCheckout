//
//  TCViewController.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 4/9/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//
import CardParts
import Foundation

protocol ThemedCardControllerDelegate {
    func deleteItem(itemName: String)
    func itemQtyChanged(itemName: String, qty: Int)
}

class ThemedCardController: CardPartsViewController {
    
    let possibleGradientColors: [UIColor] = [
        UIColor(red: 181.0 / 255.0, green: 152.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0), // purple
        UIColor(red: 30.0 / 255.0, green: 211.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0), // blue
        //UIColor(red: 63.0 / 255.0, green: 236.0 / 255.0, blue: 216.0 / 255.0, alpha: 1.0),
        //UIColor(red: 27.0 / 255.0, green: 205.0 / 255.0, blue: 156.0 / 255.0, alpha: 1.0),
        //UIColor(red: 10.0 / 255.0, green: 199.0 / 255.0, blue: 117.0 / 255.0, alpha: 1.0),
        //UIColor(red: 17.0 / 255.0, green: 174.0 / 255.0, blue: 155.0 / 255.0, alpha: 1.0),
        //Colors.aqua, Colors.lightGrey, Colors.orange, Colors.brightOrange, Colors.green, Colors.lavender
    ]
    
    var _title: String = ""
    var _quantity: String = ""
    var delegate: ThemedCardControllerDelegate?
    let quantity = CardPartTextView(type: .header)

    convenience init(title: String, quantity: String) {
        self.init(nibName: nil, bundle: nil)
        self._title = title
        self._quantity = quantity
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let minusCP = CardPartButtonView()
        let trashCP = CardPartButtonView()
        let plusCP = CardPartButtonView()
        
        plusCP.addTarget(self, action: #selector(incQuantity), for: .touchUpInside)
        minusCP.addTarget(self, action: #selector(decQuantity), for: .touchUpInside)

        
        trashCP.setTitle("", for: .normal)
        trashCP.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let trashImage = UIImage(named: "trash")
        trashCP.setImage(trashImage, for: .normal)
        let plusImage = UIImage(named: "icons8-plus-50")
        plusCP.setImage(plusImage, for: .normal)
        let minusImage = UIImage(named: "icons8-minus-50")
        minusCP.setImage(minusImage, for: .normal)
        
        
        let titleCP = CardPartTextView(type: .header)
        titleCP.text = self._title
        titleCP.textAlignment = .center
        titleCP.textColor = .white
        
        let leftStack = CardPartStackView()
        leftStack.axis = .horizontal
        leftStack.distribution = .equalSpacing
        leftStack.spacing = 10
        
        quantity.text = self._quantity
        titleCP.textAlignment = .center
        titleCP.textColor = .white
        
        

        let trash = CardPartStackView()
        trash.axis = .horizontal
        trash.spacing = 10
        
        
        leftStack.addArrangedSubview(minusCP)
        leftStack.addArrangedSubview(quantity)
        trash.addArrangedSubview(trashCP)
        leftStack.addArrangedSubview(plusCP)

        
        
        setupCardParts([trash,titleCP, leftStack])
        
//        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 280))
    }
    
    @objc func incQuantity() {
        print("increment!")
        if var quan = Int(self._quantity) as? Int {
            quan += 1
            self._quantity = String(quan)
            self.quantity.text = String(quan)
            self.delegate?.itemQtyChanged(itemName: self._title, qty: quan)
        }
    }
    
    @objc func decQuantity() {
        print("decrement!")
        if var quan = Int(self._quantity) as? Int {
            if(quan - 1 < 0) {
                 self.delegate?.deleteItem(itemName: self._title)
            }  else {
                quan -= 1
                self._quantity = String(quan)
                self.quantity.text = self._quantity
                self.delegate?.itemQtyChanged(itemName: self._title, qty: quan)
            }
            
        }
    }
    
    @objc func buttonTapped() {
        
        let alertController = UIAlertController(title: "Remove!", message: "Are you sure?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.delegate?.deleteItem(itemName: self._title)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}



extension ThemedCardController: ShadowCardTrait {
    func shadowOffset() -> CGSize {
        return CGSize(width: 0.0, height: 0.0)
    }
    
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
        return 10.0
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
