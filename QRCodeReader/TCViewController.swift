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
        Colors.lightGrey, Colors.green
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
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleCP = CardPartTextView(type: .header)
        titleCP.text = self._title
        titleCP.textAlignment = .center
        titleCP.textColor = .white
        
        let buttonCP = CardPartButtonView()
        buttonCP.setTitle("", for: .normal)
        buttonCP.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let trashImage = UIImage(named: "trash")
        buttonCP.setImage(trashImage, for: .normal)
        
        
        setupCardParts([titleCP, buttonCP])
        
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 280))
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
