//
//  Router.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 06/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

struct Router {
    
    enum TransitionStyle {
        case withoutAnimation
        case animated
    }
    
    enum Location: Equatable {
        case signIn
        case createAccount
        case passwordRecovery
        
        var controller: UIViewController {
            return ViewController(with: ViewModel(location: self))
        }
        
        static func == (lhs: Location, rhs: Location) -> Bool {
            switch (lhs, rhs) {
            case (.signIn, .signIn):
                return true
            case (.createAccount, .createAccount):
                return true
            case (.passwordRecovery, .passwordRecovery):
                return true
            default:
                return false
            }
        }
    }
    
    let navigationController: UINavigationController
    let transitionController: TransitionController
    
    var current: Location {
        if let viewController = navigationController.topViewController as? ViewController {
            return viewController.viewModel.location
        }
        
        return .createAccount
    }
    
    init(start at: Router.Location) {
        navigationController = UINavigationController()
        navigationController.viewControllers = [at.controller]
        
        transitionController = TransitionController(with: navigationController)
        navigationController.delegate = transitionController
    }
    
    mutating func go(to location: Router.Location, _ style: TransitionStyle = .animated) {
        
        let viewControllers = navigationController.viewControllers.filter { controller -> Bool in
            
            if let controller = controller as? ViewController {
                return location == controller.viewModel.location
            }
            
            return false
        }
        
        if let viewController = viewControllers.last as? ViewController {
            navigationController.popToViewController(viewController, animated: true)
        } else {
            navigationController.pushViewController(location.controller, animated: true)
        }
    }
    
    var next: Location? {
        switch current {
        case .createAccount:
            print("next: signIn")
            return .signIn
        case .signIn:
            print("next: passwordRecovery")
            return .passwordRecovery
        case .passwordRecovery:
            print("next: nil")
            return nil
        }
    }
    
    var previous: Location? {
        switch current {
        case .createAccount:
            print("previous: nil")
            return nil
        case .signIn:
            print("previous: createAccount")
            return .createAccount
        case .passwordRecovery:
            print("previous: signIn")
            return .signIn
        }
    }
}
