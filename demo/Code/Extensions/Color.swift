//
//  Color.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 18/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    func components() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return (r, g, b, a)
    }
    
    func combine(with color: UIColor, amount: CGFloat) -> UIColor {
        
        let fromComponents = components()
        let toComponents = color.components()
        
        let r = lerp(from: fromComponents.red, to: toComponents.red, alpha: amount)
        let g = lerp(from: fromComponents.green, to: toComponents.green, alpha: amount)
        let b = lerp(from: fromComponents.blue, to: toComponents.blue, alpha: amount)
        
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
