//
//  StoreObserver.swift
//  ios
//
//  Created by S. Matthew English on 12/30/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import StoreKit

class StoreObserver: NSObject, SKPaymentTransactionObserver {
    
    var header: Header?
    var player: EntityPlayer?
    //Initialize the store observer.
    override init() {
        super.init()
        //Other initialization here.
    }
    
    
    //https://gist.github.com/smatthewenglish/e668b7d37a2969a2dd1af3a24bc349bc
    //
    //https://developer.apple.com/documentation/storekit/in-app_purchase/setting_up_the_transaction_observer_for_the_payment_queue
    //
    //https://developer.apple.com/documentation/storekit/in-app_purchase/processing_a_transaction
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            // Call the appropriate custom method for the transaction state.
            case .purchasing:
                print("purchasing \(transaction.transactionState)")
            //showTransactionAsInProgress(transaction, deferred: false)
            case .deferred:
                print("deferred \(transaction.transactionState)")
            //showTransactionAsInProgress(transaction, deferred: true)
            case .failed:
                //failedTransaction(transaction)
                print("failedTransaction \(transaction.transactionState)")
            case .purchased:
                print("completeTransaction \(transaction.transactionState)")
                
                
                player!.subscription = true
                
                //let payload: [String: String] = ["id": self.player!.id, "date": "TRUE"]
                //self.subscription(payload: payload) { (response) in
                    //print("subscription: \(response)")
                //}
                
                
            //completeTransaction(transaction)
            case .restored:
                print("restoreTransaction \(transaction.transactionState)")
            //restoreTransaction(transaction)
            // For debugging purposes.
            @unknown default:
                print("Unexpected transaction state \(transaction.transactionState)")
            }
        }
    }
    
    func subscription(payload: [String: String], completion: @escaping (([String: String]) -> Void)) {
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/subscription")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
        } catch _ {
            completion(["fail": "0"])
        }
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(["fail": "1"])
                return
            }
            guard let data = data else {
                completion(["fail": "2"])
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String] else {
                    completion(["fail": "3"])
                    return
                }
                completion(json)
            } catch _ {
                completion(["fail": "4"])
            }
            
        }).resume()
    }
    
}
