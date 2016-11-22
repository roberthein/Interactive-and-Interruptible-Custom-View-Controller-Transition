//
//  AppDelegate.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 06/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

let app = UIApplication.shared.delegate as? AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var colors: Colors!
    var router: Router!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        colors = Colors()
        
        router = Router(start: .createAccount)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = router.navigationController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
}
