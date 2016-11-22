//
//  View.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 07/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

class View: UIView {
    
    var gradient: Gradient!
    var stack: Stack!
    
    convenience init(elements: [StackElement]) {
        self.init(frame: UIScreen.main.bounds)
        
        gradient = Gradient()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gradient)
        
        gradient.frame(to: self)
        
        if let layer = gradient.gradientLayer {
            layer.colors = app?.colors.gradient.map { color in color.cgColor }
            layer.locations = [0, 1]
            layer.startPoint = CGPoint(x: 0.5, y: 0)
            layer.endPoint = CGPoint(x: 0.5, y: 1)
        }
        
        stack = Stack(with: elements)
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        stack.centerY(to: self)
        stack.leading(to: self, offset: 30)
        stack.trailing(to: self, offset: -30)
    }
}

class Gradient: UIView {
    
    override class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer? {
        return self.layer as? CAGradientLayer
    }
}
