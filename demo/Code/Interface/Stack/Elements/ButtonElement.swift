//
//  ButtonElement.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 18/09/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

class ButtonElement: UIView, StackElementView {
    
    var element: StackElement!
    var closure: Closure!
    var button: UIButton!
    
    convenience init(_ element: StackElement, title: String, closure: @escaping Closure) {
        self.init(frame: .zero)
        self.element = element
        self.closure = closure
        
        button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(app?.colors.buttonTitle, for: .normal)
        button.setTitleColor(app?.colors.buttonTitle.withAlphaComponent(0.5), for: .selected)
        button.setTitleColor(app?.colors.buttonTitle.withAlphaComponent(0.5), for: .highlighted)
        button.backgroundColor = app?.colors.tint
        button.layer.borderColor = app?.colors.tint.cgColor
        button.layer.borderWidth = RoundedView.borderWidth
        button.layer.cornerRadius = RoundedView.cornerRadius
        addSubview(button)
        
        button.frame(to: self, insets: UIEdgeInsetsMake(25, 5, 0, -5))
        button.height(50)
        
        button.addTarget(self, action: #selector(selected(_:)), for: .touchUpInside)
    }
    
    func selected(_ button: UIButton) {
        closure()
    }
}
