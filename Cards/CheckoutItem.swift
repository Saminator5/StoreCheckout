//
//  CheckoutItem.swift
//  QRCodeReader
//
//  Created by Samuel Lefcourt on 4/20/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//
import CardParts
import Foundation
class CardPartCenteredViewCardController: CardPartsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let separator = CardPartVerticalSeparatorView()
        
        let leftStack = CardPartStackView()
        leftStack.axis = .vertical
        leftStack.spacing = 10
        
        let rightStack = CardPartStackView()
        rightStack.axis = .vertical
        rightStack.spacing = 10
        
        let textView = CardPartTextView(type: .normal)
        textView.text = "This is a label with text"
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
        
        leftStack.addArrangedSubview(textView)
        leftStack.addArrangedSubview(textView2)
        
        rightStack.addArrangedSubview(textView3)
        rightStack.addArrangedSubview(textView4)
        
        let centeredView = CardPartCenteredView(leftView: leftStack, centeredView: separator, rightView: rightStack)
        setupCardParts([centeredView])
    }
}
