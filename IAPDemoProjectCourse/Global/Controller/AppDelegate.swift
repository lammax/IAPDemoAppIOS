//
//  AppDelegate.swift
//  IAPDemoProject
//
//  Created by Ivan Akulov on 26/10/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IAPManager.sharedInstance.setupPurchases { success in
            if success {
                print("Can make payments")
                IAPManager.sharedInstance.getProducts()
            }
        }
        
        return true
    }
}

