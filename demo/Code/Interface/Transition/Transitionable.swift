//
//  Transitionable.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 08/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit
import Foundation

protocol Transitionable {
    func mainView() -> View?
    func gradient() -> Gradient?
    func stack() -> Stack?
}
