//
//  LabelElement.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 18/09/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

class LabelElement: UIView, StackElementView {
    
    var element: StackElement!
    var label: UILabel!
    
    convenience init(_ element: StackElement, text: String) {
        self.init(frame: .zero)
        self.element = element
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = text
        label.textAlignment = .center
        addSubview(label)
        
        if case .title(_) = element {
            label.textColor = app?.colors.tint
            label.font = UIFont(name: Font.light, size: 26)
            label.frame(to: self, insets: UIEdgeInsetsMake(0, 10, -10, -10))
        } else {
            label.textColor = app?.colors.title.withAlphaComponent(0.8)
            label.font = UIFont(name: Font.light, size: 16)
            label.frame(to: self, insets: UIEdgeInsetsMake(0, 10, -20, -10))
        }
    }
}
