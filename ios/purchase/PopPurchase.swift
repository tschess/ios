//
//  PopChallenge.swift
//  ios
//
//  Created by S. Matthew English on 12/9/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import StoreKit

class PopPurchase: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, SKProductsRequestDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelTitle.text = "🤜 vs. \(self.opponent!.username) 🤛"
        
        self.pickerView!.delegate = self
        self.pickerView!.dataSource = self
        self.pickerView!.selectRow(1, inComponent: 0, animated: true)
        
        self.labelOk!.isHidden = true
        self.buttonOk.isHidden = true
        self.buttonOk.isEnabled = false
        
        self.indicatorActivity.isHidden = true
        
        if(self.REMATCH){
            self.buttonInvite.setTitle("⚡ Rematch ⚡", for: .normal)
            self.url = URL(string: "http://\(ServerAddress().IP):8080/game/rematch")!
            return
        }
        if(self.ACCEPT){
            self.buttonInvite.setTitle("🎉 Let's play! 🎉", for: .normal)
            self.url = URL(string: "http://\(ServerAddress().IP):8080/game/ack")!
            return
        }
    }
    
    
    var navigator: UINavigationController?
    
    var url: URL = URL(string: "http://\(ServerAddress().IP):8080/game/challenge")!
    let transDelegate: TransDelegate = TransDelegate(width: 271, height: 363)
    var transitioner: Transitioner?
    var opponent: EntityPlayer?
    var player: EntityPlayer?
    var game: EntityGame?
    
    /**
     * The default value is 'CHALLENGE'.
     */
    var REMATCH: Bool = false
    var ACCEPT: Bool = false
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDirection: UILabel!
    
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var labelInvite: UILabel!
    @IBOutlet weak var buttonInvite: UIButton!
    
    @IBOutlet weak var labelCancel: UILabel!
    @IBOutlet weak var buttonCancel: UIButton!
    
    @IBOutlet weak var labelOk: UILabel!
    @IBOutlet weak var buttonOk: UIButton!
    
    @IBOutlet weak var labelSubscribe: UILabel!
    @IBOutlet weak var buttonSubscribe: UIButton!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = transDelegate
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerSet.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerSet[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    let pickerSet = ["\tChess", "\tI'm Feelin' Lucky", "\tConfig. 0̸ 🔒", "\tConfig. 1 🔒", "\tConfig. 2 🔒"]
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        label.text = pickerSet[row]
        return label
    }
    
    @IBAction func selectSubscribe(_ sender: Any) {
        //let month: String = "$0.99 × Month 📅"
        let text: String = buttonSubscribe.titleLabel!.text!
        //if(text == month){
        if(text.contains("Month")){
            self.subscribe(product: "io.bahlsenwitz.tschess.100")
            return
        }
        self.labelTitle.text = "🔑 Subscription plan 🔑"
        self.labelDirection.text = "Select an option below to proceed."
        
        self.pickerView.alpha = 0.5
        self.pickerView.isUserInteractionEnabled = false
        
        self.buttonInvite.setTitle("$5.99 × Year 🍂❄️🌷🌞", for: .normal)
        self.buttonInvite.setTitleColor(UIColor.white, for: .normal)
        
        self.buttonSubscribe.setTitle("$0.99 × Month 📅", for: .normal)
        self.buttonSubscribe.setTitleColor(UIColor.white, for: .normal)
    }
    
    // Keep a strong reference to the product request.
    var request: SKProductsRequest!
    var products: [SKProduct] = [SKProduct]()
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("121212")
        
        if !response.products.isEmpty {
           products = response.products
           // Custom method.
           //displayStore(products)
            
            print("products: \(products)")
        
            for p in products {
                  print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
                
                let payment = SKMutablePayment(product: p)
                SKPaymentQueue.default().add(payment)
                
                DispatchQueue.main.async() {
                    self.dismiss(animated: true, completion: nil)
                    //self.indicatorActivity.isHidden = true
                    //self.indicatorActivity.stopAnimating()
                }
                
                
                }
        }
        for invalidIdentifier in response.invalidProductIdentifiers {
           // Handle any invalid product identifiers as appropriate.
            print("invalidIdentifier: \(invalidIdentifier)")//
        }
    }
   
    func subscribe(product: String) {
        //...
        let productIdentifiers = Set([product])
        request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
    }
    
    
    @IBAction func selectChallenge(_ sender: Any) {
        let year: String = "$5.99 × Year 🍂❄️🌷🌞"
        let text: String = buttonInvite.titleLabel!.text!
        if(text == year){
            //self.subscribe(product: "002")
            self.subscribe(product: "io.bahlsenwitz.tschess.200")
            return
        }
        self.labelTitle.isHidden = true
        self.labelDirection.isHidden = true

        self.pickerView.isHidden = true

        self.labelInvite.isHidden = true
        self.buttonInvite.isHidden = true
        self.buttonInvite.isEnabled = false

        self.labelCancel.isHidden = true
        self.buttonCancel.isHidden = true
        self.buttonCancel.isEnabled = false

        self.labelSubscribe.isHidden = true
        self.buttonSubscribe.isHidden = true
        self.buttonSubscribe.isEnabled = false

        self.indicatorActivity.isHidden = false
        self.indicatorActivity.startAnimating()
        
        let value = self.pickerView?.selectedRow(inComponent: 0)
        self.challenge(config0: value!, id_other: opponent!.id)
    }
    
    
    @IBAction func selectCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectOk(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func challenge(config0: Int, id_other: String) {
        var config: Int = 0
        switch config0 {
        case 0:
            config = 3
        case 1:
            config = 4
        case 2:
            config = 4//0
        case 3:
            config = 4//1
        default: //4
            config = 4//2
        }
        var payload: [String: Any] = [
            "id_self": self.player!.id,
            "config": config
        ]
        if(self.REMATCH){
            let white: Bool = self.game!.getWhite(username: self.player!.username)
            payload["white"] = white
            payload["id_other"] = id_other
            //val id_self: String,
            //val id_other: String,
            //val config: Int,
            //val white: Boolean
        }
        if(self.ACCEPT){
            payload[ "id_game"] = self.game!.id
        }
        if(!self.REMATCH && !self.ACCEPT) { //invite/challenge
            payload[ "id_other"] = id_other
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                self.error()
                return
            }
            guard let data = data else {
                self.error()
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    self.error()
                    return
                }
                print("AHAHAHAHAHAHAHA\n\n\n\n")
                print("AHAHAHAHAHAHAHA\n\n\n\n")
                print("::::: \(json)")
                print("AHAHAHAHAHAHAHA\n\n\n\n")
                print("AHAHAHAHAHAHAHA\n\n\n\n")
                let game: EntityGame = ParseGame().execute(json: json)
                
                if(self.ACCEPT){
                    DispatchQueue.main.async {
                        
                        let opponent: EntityPlayer = game.getPlayerOther(username: self.player!.username)
                        let storyboard: UIStoryboard = UIStoryboard(name: "Tschess", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "Tschess") as! Tschess
                        viewController.playerOther = opponent
                        viewController.player = self.player!
                        viewController.game = game
                        
                        self.dismiss(animated: true, completion: nil)
                        self.navigator!.pushViewController(viewController, animated: false)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                        let viewControllers = navigationController.viewControllers
                        for vc in viewControllers {
                            if vc.isKind(of: Home.classForCoder()) {
                                let home: Home = vc as! Home
                                home.table!.list.insert(game, at: 0)
                                home.table!.tableView.reloadData()
                            }
                        }
                    }
                }
                
                
                self.success()
            } catch _ {
                self.error()
            }
        }).resume()
    }
    
    func success() {
        DispatchQueue.main.async() {
            self.indicatorActivity.isHidden = true
            self.indicatorActivity.stopAnimating()
            
            self.labelTitle.isHidden = false
            self.labelTitle.text = "✅ Success ✅"
            
            self.labelDirection.isHidden = false
            self.labelDirection.text = "Invite has been sent. 👍"
            
            self.labelOk.isHidden = false
            self.buttonOk.isHidden = false
            self.buttonOk.isEnabled = true
        }
    }
    
    func error() {
        DispatchQueue.main.async() {
            self.indicatorActivity.isHidden = true
            self.indicatorActivity.stopAnimating()
            
            self.labelTitle.isHidden = false
            self.labelTitle.text = "❌ Error ❌"
            
            self.labelDirection.isHidden = false
            self.labelDirection.text = "Invite has not been sent. 🤖"
            
            self.labelOk.isHidden = false
            self.buttonOk.isHidden = false
            self.buttonOk.isEnabled = true
            
        }
    }
}


