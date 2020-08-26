//
//  PurchaseController.swift
//  IAPDemoProject
//
//  Created by Ivan Akulov on 26/10/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import UIKit
import StoreKit

class PurchaseController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let iap = IAPManager.sharedInstance
    let notification = NotificationCenter.default
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        setupNavigationBar()
        setupNotifications()

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc private func restorePurchases() {
        iap.restoreCompletedTransactions()
    }
    @objc private func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Restore", style: .plain, target: self, action: #selector(restorePurchases))
    }
    
    private func setupNotifications() {
        notification.addObserver(self, selector: #selector(reload), name: NSNotification.Name(IAPManager.productNotificationIdentifier), object: nil)
        notification.addObserver(self, selector: #selector(processConsumablePurchased(_:)), name: NSNotification.Name(IAPProduct.consumable.rawValue), object: nil)
        notification.addObserver(self, selector: #selector(processNonConsumablePurchased(_:)), name: NSNotification.Name(IAPProduct.nonConsumable.rawValue), object: nil)
        notification.addObserver(self, selector: #selector(processRenewablePurchased), name: NSNotification.Name(IAPProduct.renewable.rawValue), object: nil)
        notification.addObserver(self, selector: #selector(processNonRenewablePurchased(_:)), name: NSNotification.Name(IAPProduct.nonRenewable.rawValue), object: nil)
    }
    
    private func priceString(for product: SKProduct) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        
        return numberFormatter.string(from: product.price) ?? "\(product.price)"
    }
    
    @objc private func processConsumablePurchased(_ notification: NSNotification) {
        print("processConsumablePurchased")
    }
    @objc private func processNonConsumablePurchased(_ notification: NSNotification) {
        print("processNonConsumablePurchased")
    }
    @objc private func processRenewablePurchased() -> String {
        print("processRenewablePurchased")
        if UserDefaults.standard.bool(forKey: IAPProduct.renewable.rawValue) {
            return "Subscription enabled"
        }
        return "Subscription disabled"
    }
    @objc private func processNonRenewablePurchased(_ notification: NSNotification) {
        print("processNonRenewablePurchased")
    }

}

extension PurchaseController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return iap.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.purchaseCell, for: indexPath)
        
        let product = iap.products[indexPath.row]
        cell.textLabel?.text = product.localizedTitle + " - " + self.priceString(for: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        processRenewablePurchased()
    }

}


extension PurchaseController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let identifier = iap.products[indexPath.row].productIdentifier
        iap.purchase(productWith: identifier)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}








