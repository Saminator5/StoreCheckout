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

class CardPartButtonViewCardController: CardPartsViewController {
    
    let cardPartTextView = CardPartTextView(type: .normal)
    let cardPartButtonView = CardPartButtonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)
        cardPartTextView.text = "This is a CardPartButtonView"
        
        cardPartButtonView.setTitle("I'm a button!", for: .normal)
        cardPartButtonView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        setupCardParts([cardPartTextView, cardPartButtonView])
    }
    
    @objc func buttonTapped() {
        
        let alertController = UIAlertController(title: "Woohoo!", message: "Isn't that awesome!?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

class CardPartSliderViewCardController: CardPartsViewController {
    
    let cardPartTextView = CardPartTextView(type: .normal)
    let cardPartSliderView = CardPartSliderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardPartTextView.text = "This is a CardPartSliderView"
        
        cardPartSliderView.minimumValue = 0
        cardPartSliderView.maximumValue = 100
        cardPartSliderView.value = 50
        
        setupCardParts([cardPartTextView, cardPartSliderView])
    }
}

class CardPartStackViewCardController: CardPartsViewController {
    
    let cardPartSV = CardPartStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardPartSV.axis = .horizontal
        cardPartSV.distribution = .equalSpacing
        
        let cardPartTextView1 = CardPartTextView(type: .normal)
        cardPartTextView1.text = "This"
        cardPartTextView1.textColor = .purple
        cardPartSV.addArrangedSubview(cardPartTextView1)
        
        let cardPartTextView2 = CardPartTextView(type: .normal)
        cardPartTextView2.text = "is"
        cardPartTextView2.textColor = .blue
        cardPartSV.addArrangedSubview(cardPartTextView2)
        
        let cardPartTextView3 = CardPartTextView(type: .normal)
        cardPartTextView3.text = "a"
        cardPartTextView3.textColor = .orange
        cardPartSV.addArrangedSubview(cardPartTextView3)
        
        let cardPartTextView4 = CardPartTextView(type: .normal)
        cardPartTextView4.text = "CardPartStackView"
        cardPartTextView4.textColor = .red
        cardPartSV.addArrangedSubview(cardPartTextView4)
        
        setupCardParts([cardPartSV])
    }
}

class CheckoutItemsViewController: CardsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.green)

        // Comment out one of the loadCard functions to change cards and/or their order
        let cards: [CardPartsViewController] = [
            //SamCard()
            //,
            ThemedCardController(title: "Vapor Distilled Water"),
            ThemedCardController(title: "Li'l Critters Vitamins"),
            ThemedCardController(title: "Pancakes"),
            ThemedCardController(title: "Syrup"),
            ThemedCardController(title: "Diapers"),
            ThemedCardController(title: "Yogurt"),
            ThemedCardController(title: "Banana"),
            ThemedCardController(title: "Monkey Business"),
            ThemedCardController(title: "Shoes"),
            ThemedCardController(title: "Socks")

        ]
        
        loadCards(cards: cards)
    }
}
