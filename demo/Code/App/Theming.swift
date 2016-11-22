//
//  Colors.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 07/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

struct ColorPair {
    let normal: UIColor
    let highlight: UIColor
    
    init(_ normal: UIColor, _ highlight: UIColor) {
        self.normal = normal
        self.highlight = highlight
    }
}

struct Colors {
    
    let textField: UIColor = .clear
    let title: UIColor = darkGray
    let buttonTitle: UIColor = .white
    
    private static let pink = rgb(255, 0, 93)
    private static let green = rgb(0, 166, 72)
    private static let blue = rgb(100, 18, 230)
    private static let darkGray = rgb(76, 76, 76)
    private static let background1 = rgb(230, 230, 230)
    private static let background2 = rgb(255, 255, 255)
    
    var tint: UIColor {
        guard let location = app?.router.current else { return .red }
         
        switch location {
        case .createAccount: return Colors.pink
        case .signIn: return Colors.green
        case .passwordRecovery: return Colors.blue
        }
    }
    
    var gradient: [UIColor] {
        guard let location = app?.router.current else { return [] }
         
        switch location {
        case .createAccount: return [Colors.background1, Colors.background2]
        case .signIn: return [Colors.background1, Colors.background2]
        case .passwordRecovery: return [Colors.background1, Colors.background2]
        }
    }
}

struct RoundedView {
    static let borderWidth: CGFloat = 1 / UIScreen.main.scale
    static let cornerRadius: CGFloat = 4
}

struct Font {
    static let light: String = "HelveticaNeue-Light"
    static let bold: String = "HelveticaNeue-Bold"
}

struct Tag {
    static let bold: String = "[B]"
}
