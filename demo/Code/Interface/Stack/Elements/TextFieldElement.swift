//
//  TextFieldElement.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 18/09/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

class TextFieldElement: UIView, StackElementView {
    
    var element: StackElement!
    var container: UIView!
    var divider: UIView!
    var textField: UITextField!
    
    convenience init(_ element: StackElement, _ placeholder: String) {
        self.init(frame: .zero)
        self.element = element
        
        container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = app?.colors.textField
        container.clipsToBounds = true
        addSubview(container)
        
        container.frame(to: self, insets: UIEdgeInsetsMake(5, 5, 0, -5))
        
        let dividerHeight: CGFloat = 1 / UIScreen.main.scale
        
        divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = app?.colors.title//app?.colors.tint
        addSubview(divider)
        
        divider.left(to: self, offset: 5)
        divider.bottom(to: self)
        divider.right(to: self, offset: -5)
        divider.height(dividerHeight)
        
        guard let colors = app?.colors else { return }
        let attributes: [String : Any] = [NSForegroundColorAttributeName: colors.title.withAlphaComponent(0.6), NSFontAttributeName: UIFont(name: Font.light, size: 16)!]
        
        textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .always
        textField.isUserInteractionEnabled = false
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        textField.layer.cornerRadius = RoundedView.cornerRadius
        container.addSubview(textField)
        
        textField.frame(to: container, insets: UIEdgeInsetsMake(5, 0, -5, -5))
        textField.height(40)
    }
}
