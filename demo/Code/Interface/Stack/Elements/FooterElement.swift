//
//  FooterElement.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 08/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

class FooterElement: UIView, StackElementView {
    
    var element: StackElement!
    var closure: Closure!
    var label: UILabel!
    
    convenience init(_ element: StackElement, title: String, closure: @escaping Closure) {
        self.init(frame: .zero)
        self.element = element
        self.closure = closure
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        addSubview(label)
        
        label.frame(to: self, insets: UIEdgeInsetsMake(40, 15, 0, -15))
        
        guard let colors = app?.colors else { return }
        
        let attributes: [String: Any]  = [
            NSForegroundColorAttributeName: colors.tint,
            NSFontAttributeName: UIFont(name: Font.light, size: 14)!
        ]
        
        let boldAttributes: [String: Any] = [
            NSForegroundColorAttributeName: colors.tint,
            NSFontAttributeName: UIFont(name: Font.bold, size: 14)!,
            NSUnderlineStyleAttributeName: 1
        ]
        
        let attributedText = NSMutableAttributedString(string: title)
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: title.characters.count))
        attributedText.addAttributes(boldAttributes, enclosingTag: Tag.bold)
        label.attributedText = attributedText
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(with:)))
        longPressGesture.minimumPressDuration = 0
        addGestureRecognizer(longPressGesture)
    }
    
    func longPressGesture(with gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            label.alpha = 0.5
        case .ended, .failed, .cancelled:
            label.alpha = 1.0
            closure()
        default:
            return
        }
    }
}
