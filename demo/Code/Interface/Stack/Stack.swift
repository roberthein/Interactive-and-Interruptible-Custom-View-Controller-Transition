//
//  Stack.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 06/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

class Stack: UIStackView {
    var elements: [StackElement]!
    var views: [UIView]!
}

extension Stack {
    
    convenience init(with elements: [StackElement]) {
        self.init()
        self.elements = elements
        self.views = elements.map { element in element.view }
        
        axis = .vertical
        spacing = 0
        
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    func view(for element: StackElement) -> UIView? {
        
        for view in views.filter({ view -> Bool in view is StackElementView }) {
            if (view as? StackElementView)?.element == element {
                return view
            }
        }
        
        return nil
    }
}
