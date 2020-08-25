//
//  IAPProducts.swift
//  IAPDemoProjectCourse
//
//  Created by Mac on 25.08.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation

enum IAPProducts: String, CaseIterable {
    case consumable = "com.lammax.ios.products.demoproject.consumable"
    case nonConsumable = "com.lammax.ios.products.demoproject.nonconsumable"
    case nonRenewable = "com.lammax.ios.products.demoproject.nonrenewable"
    case renewable = "com.lammax.ios.products.demoproject.renewable"

    static var allProducts: Set<String> {
        Set(IAPProducts.allCases.map { $0.rawValue })
    }
}
