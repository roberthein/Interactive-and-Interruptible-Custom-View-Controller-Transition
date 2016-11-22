//
//  StackElement.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 06/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

enum StackElement {
    case title(String), description(String)
    case email(String), name(String), address(String), password(String)
    case primaryAction(String, Closure), secondaryAction(String, Closure)
}

extension StackElement: Equatable {

    static func == (lhs: StackElement, rhs: StackElement) -> Bool {
        switch (lhs, rhs) {
        case (.title(let lhsText), .title(let rhsText)), (.description(let lhsText), .description(let rhsText)):
            return lhsText == rhsText
        case (.email, .email), (.name, .name), (.address, .address), (.password, .password):
            return true
        case (.primaryAction(let lhsText, _), .primaryAction(let rhsText, _)), (.secondaryAction(let lhsText, _), .secondaryAction(let rhsText, _)):
            return lhsText == rhsText
        default:
            return false
        }
    }
}

protocol StackElementView {
    var element: StackElement! { get set }
}

extension StackElement {
    
    var view: UIView {
        switch self {
        case .title(let text), .description(let text):
            return LabelElement(self, text: text)
        case .email(let placeholder), .name(let placeholder), .address(let placeholder), .password(let placeholder):
            return TextFieldElement(self, placeholder)
        case .primaryAction(let title, let closure):
            return ButtonElement(self, title: title, closure: closure)
        case .secondaryAction(let title, let closure):
            return FooterElement(self, title: title, closure: closure)
        }
    }
}
