//
//  IAPProducts.swift
//  IAPDemoProjectCourse
//
//  Created by Mac on 25.08.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation

enum IAPProduct: String, CaseIterable {
    case consumable = "com.lammax.ios.products.demoproject.consumable"
    case nonConsumable = "com.lammax.ios.products.demoproject.nonconsumable"
    case nonRenewable = "com.lammax.ios.products.demoproject.nonrenewable"
    case renewable = "com.lammax.ios.products.demoproject.renewable"

    static var allProducts: Set<String> {
        Set(IAPProduct.allCases.map { $0.rawValue })
    }
    
    static func getProduct(by identifier: String) -> IAPProduct? {
        switch true {
        case identifier == IAPProduct.consumable.rawValue: return IAPProduct.consumable
        case identifier == IAPProduct.nonConsumable.rawValue: return IAPProduct.nonConsumable
        case identifier == IAPProduct.renewable.rawValue: return IAPProduct.renewable
        case identifier == IAPProduct.nonRenewable.rawValue: return IAPProduct.nonRenewable
        default: return nil
        }
    }
}
