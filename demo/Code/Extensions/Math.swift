//
//  Math.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 08/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

func lerp(from a: CGFloat, to b: CGFloat, alpha: CGFloat) -> CGFloat {
    return (1 - alpha) * a + alpha * b
}

extension CGPoint {
    var vector: CGVector {
        return CGVector(dx: x, dy: y)
    }
}

extension CGVector {
    var magnitude: CGFloat {
        return sqrt(dx*dx + dy*dy)
    }
    
    var point: CGPoint {
        return CGPoint(x: dx, y: dy)
    }
    
    func apply(transform t: CGAffineTransform) -> CGVector {
        return point.applying(t).vector
    }
}
