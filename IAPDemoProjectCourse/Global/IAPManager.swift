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
    
    static let productNotificationIdentifier = "IAPManagerProductIdentifier"
    
    static let sharedInstance = IAPManager()
    private override init() {}
    
    var products: [SKProduct] = []
    let paymentQueue = SKPaymentQueue.default()
    
    public func setupPurchases(callback: @escaping (Bool) -> Void) {
        if SKPaymentQueue.canMakePayments() {
            paymentQueue.add(self)
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
    
    public func purchase(productWith identifier: String) {
        //iPhone iTunes AppStore logout first!
        //iq777@mail.ru \ aaa123@b123.com
        //qqQQ11!!
        guard let product = products.filter({ $0.productIdentifier == identifier }).first else { return }
        let payment = SKPayment(product: product)
        
        //if several payments at once
        let payment1 = SKMutablePayment(product: product)
        payment1.quantity = 2
        //---------------------------
        
        paymentQueue.add(payment)
    }
    
}

extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            switch $0.transactionState {
            case .deferred: break
            case .failed: print(" Purchase failed ")
            case .purchased: print(" Purchased ")
            case .purchasing: break
            case .restored: print(" Restored ")
            }
        }
    }
}

extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        if self.products.count > 0 {
            NotificationCenter.default.post(name: NSNotification.Name(IAPManager.productNotificationIdentifier) , object: nil)
        }
    }
}
