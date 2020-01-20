//
//  ShowMeSkins.swift
//  ios
//
//  Created by Matthew on 1/16/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class ShowMeSkins: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    //@IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    //@IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    //@IBOutlet weak var tschxLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    //@IBOutlet weak var usernameLabel: UILabel!
    
    var skinTableMenu: SkinTableMenu?
    
    var player: Player?
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.rankLabel.text = self.player!.getRank()
        //self.tschxLabel.text = "₮\(self.player!.getTschx())"
        self.usernameLabel.text = self.player!.getName()
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let skinSelection = notification.userInfo!["skin_selection"] as! Skin
        
        DispatchQueue.main.async {
            switch skinSelection.getName() {
            case "hyperion":
                let storyboard: UIStoryboard = UIStoryboard(name: "PurchaseDetail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PurchaseDetail") as! PurchaseDetail
                viewController.setPlayer(player: self.player!)
                viewController.setSkin(skin: skinSelection)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "calypso":
                let storyboard: UIStoryboard = UIStoryboard(name: "PurchaseDetail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PurchaseDetail") as! PurchaseDetail
                viewController.setPlayer(player: self.player!)
                viewController.setSkin(skin: skinSelection)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "neptune":
                let storyboard: UIStoryboard = UIStoryboard(name: "PurchaseDetail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PurchaseDetail") as! PurchaseDetail
                viewController.setPlayer(player: self.player!)
                viewController.setSkin(skin: skinSelection)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "iapetus":
                let storyboard: UIStoryboard = UIStoryboard(name: "PurchaseDetail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PurchaseDetail") as! PurchaseDetail
                viewController.setPlayer(player: self.player!)
                viewController.setSkin(skin: skinSelection)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            default:
                return
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarMenu.delegate = self
        self.skinTableMenu = children.first as? SkinTableMenu
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "SkinSelection"),
            object: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().home(player: self.player!)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            StoryboardSelector().profile(player: self.player!)
        }
    }
}
