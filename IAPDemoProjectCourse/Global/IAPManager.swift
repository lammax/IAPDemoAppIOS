//
//  IAPManager.swift
//  IAPDemoProjectCourse
//
//  Created by Mac on 25.08.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation
import StoreKit

class IAPManager: NSObject {
    
    static let sharedInstance = IAPManager()
    private override init() {}
    
    private var products: [SKProduct] = []
    
    public func setupPurchases(callback: @escaping (Bool) -> Void) {
        if SKPaymentQueue.canMakePayments() {
            SKPaymentQueue.default().add(self)
            callback(true)
            return
        }
        callback(false)
    }
    
    public func getProducts() {
        let identifires: Set<String> = IAPProducts.allProducts
        
        let productsRequest = SKProductsRequest(productIdentifiers: identifires)
        productsRequest.delegate = self
        productsRequest.start()
        
        let productRequest2 = SKProductsRequest()
        productRequest2.start()
    }
    
}

extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

    }
}

extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        print(self.products.count)
        self.products.forEach { print($0.localizedTitle) }
        print(response.products.count)
        print(response.invalidProductIdentifiers.count)
    }
}
