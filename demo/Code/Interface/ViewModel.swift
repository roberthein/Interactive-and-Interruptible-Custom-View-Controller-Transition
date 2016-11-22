//
//  ViewModel.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 06/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation

class ViewModel {
    
    var location: Router.Location!
    
    convenience init(location: Router.Location) {
        self.init()
        self.location = location
    }
}

extension ViewModel {
    
    var elements: [StackElement] {
        
        switch self.location! {
        case .signIn:
            return [
                .title("Welcome back!"),
                .description("Please enter your credentials to sign in."),
                .email("e-mail"),
                .password("password"),
                .primaryAction("Sign In", {
                    print("Sign In: Primary Action")
                }),
                .secondaryAction("Did you forget your password? Tap here to \(Tag.bold)recover your password\(Tag.bold).", {
                    print("Sign In: Secondary Action")
                })
            ]
        case .createAccount:
            return [
                .title("Registration"),
                .description("Please fill in your personal information to create an account."),
                .email("e-mail"),
                .name("name"),
                .address("address"),
                .password("password"),
                .primaryAction("Create Account", {
                    print("Create Account: Primary Action")
                }),
                .secondaryAction("Do you already have an account? Tap here to \(Tag.bold)sign in\(Tag.bold).", {
                    print("Create Account: Secondary Action")
                })
            ]
        case .passwordRecovery:
            return [
                .title("Forgot Password?"),
                .description("Please enter your e-mail address to recover your password."),
                .email("e-mail"),
                .primaryAction("Recover Password", {
                    print("Recover Password: Primary Action")
                }),
                .secondaryAction("Is there no account with your e-mail address? Tap here to \(Tag.bold)create a new account\(Tag.bold).", {
                    print("Recover Password: Secondary Action")
                })
            ]
        }
    }
}
