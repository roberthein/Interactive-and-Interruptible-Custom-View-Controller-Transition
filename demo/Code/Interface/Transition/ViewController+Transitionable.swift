//
//  ViewController+Transitionable.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 08/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: Transitionable {
    
    func mainView() -> View? {
        guard let view = customView else { return nil }
        return view
    }
    
    func gradient() -> Gradient? {
        guard let view = customView else { return nil }
        return view.gradient
    }
    
    func stack() -> Stack? {
        guard let view = customView else { return nil }
        return view.stack
    }
}
