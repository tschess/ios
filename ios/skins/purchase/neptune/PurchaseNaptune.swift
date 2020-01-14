//
//  PurchaseNaptune.swift
//  ios
//
//  Created by Matthew on 1/14/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import StoreKit

class PurchaseNaptune: UIViewController, UITabBarDelegate, UITextViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var tschxLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var purchaseButton: UIButton!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var player: Player?
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    var remaining: Int?
    
    public func setRemaining(remaining: Int){
        self.remaining = remaining
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarMenu.delegate = self
        
        //let description = "    each individual edition of the iapetus game skin is fully backed by a unique ERC-721 compliant token on the mainnet ethereum blockchain.\r\r    purchase a freshly minted instantiation and subsequently claim full sovereignty of it by requesting a transfer of the underlying blockchain representation to the address of your choice.\r\r    if you've acquired an iapetus token independently you can associate the game skin with your account similarly through the claim mechanism.\r\r"
        
        let description = "• freshly minted individual edition of the iapetus game skin, one of fifty\r\r• visible to oneself and opponent during gameplay\r\r• globally visible in leaderboard and on challenge/review endgame snapshot\r\r• design inspired by science fantasy novel \"the chessmen of mars\" by edgar rice burroughs\r\r"
        
        self.descriptionTextView.isEditable = false
        self.descriptionTextView.backgroundColor = UIColor.white
        self.descriptionTextView.textColor = UIColor.black
        self.descriptionTextView.text = description
        
        Product.store.requestProducts{ [weak self] success, products in
            guard let self = self else {
                return
            }
            if success {
                self.products = products!
                let product: SKProduct = self.products[0]
                DispatchQueue.main.async {
                    self.purchaseButton.setTitle( "$\(product.price.floatValue)" , for: .normal)
                }
            }
        }
        self.titleLabel.text = "iapetus \(self.remaining!)/50"
    }
    
    var products: [SKProduct] = [SKProduct]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.rankLabel.text = self.player!.getRank()
        self.tschxLabel.text = "₮\(self.player!.getTschx())"
        self.usernameLabel.text = self.player!.getName()
    }
    
    @IBAction func purchaseButtonClick(_ sender: Any) {
        if(self.products.isEmpty){
            return
        }
        let product = self.products[0]
        Product.store.buyProduct(product, player: self.player!)
    }
    
    @IBAction func previewButtonClick(_ sender: Any) {
        DispatchQueue.main.async {
            switch StoryboardSelector().device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "PreviewXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PreviewXandroid") as! Preview
                viewController.setPlayer(player: self.player!)
                self.present(viewController, animated: false, completion: nil)
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "PreviewMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PreviewMagnus") as! Preview
                viewController.setPlayer(player: self.player!)
                self.present(viewController, animated: false, completion: nil)
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "PreviewXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PreviewXenophon") as! Preview
                viewController.setPlayer(player: self.player!)
                self.present(viewController, animated: false, completion: nil)
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "PreviewPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PreviewPhaedrus") as! Preview
                viewController.setPlayer(player: self.player!)
                self.present(viewController, animated: false, completion: nil)
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "PreviewCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PreviewCalhoun") as! Preview
                viewController.setPlayer(player: self.player!)
                self.present(viewController, animated: false, completion: nil)
                return
            default:
                return
            }
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().profile(player: self.player!)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            StoryboardSelector().profile(player: self.player!)
        default:
            StoryboardSelector().home(player: self.player!)
        }
    }
}




