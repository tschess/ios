//
//  Skins.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Skins: UIViewController, UITabBarDelegate {
    
    
    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var skinTableMenu: SkinsTable?
    
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    public func renderHeaderSelf() {
        self.avatarImageView.image = self.player!.getImageAvatar()
        self.usernameLabel.text = self.player!.username
        self.eloLabel.text = self.player!.getLabelTextElo()
        self.rankLabel.text = self.player!.getLabelTextRank()
        self.displacementLabel.text = self.player!.getLabelTextDisp()
        self.displacementImage.image = self.player!.getImageDisp()!
        self.displacementImage.tintColor = self.player!.tintColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.renderHeaderSelf()
        
        self.activityIndicator.isHidden = true
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let skinSelection = notification.userInfo!["skin_selection"] as! EntitySkin
        
        DispatchQueue.main.async {
            switch skinSelection.getName() {
            case "HYPERION":
                let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! Detail
                viewController.setPlayer(player: self.player!)
                viewController.setSkin(skin: skinSelection)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "CALYPSO":
                let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! Detail
                viewController.setPlayer(player: self.player!)
                viewController.setSkin(skin: skinSelection)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "NEPTUNE":
                let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! Detail
                viewController.setPlayer(player: self.player!)
                viewController.setSkin(skin: skinSelection)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "IAPETUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! Detail
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
        self.skinTableMenu = children.first as? SkinsTable
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "SkinSelection"),
            object: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async() {
            let profileStoryboard: UIStoryboard = UIStoryboard(name: "ProfileL", bundle: nil)
            let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileL") as! Profile
            profileViewController.setPlayer(player: self.player!)
            UIApplication.shared.keyWindow?.rootViewController = profileViewController
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            DispatchQueue.main.async() {
                let profileStoryboard: UIStoryboard = UIStoryboard(name: "ProfileL", bundle: nil)
                let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileL") as! Profile
                profileViewController.setPlayer(player: self.player!)
                UIApplication.shared.keyWindow?.rootViewController = profileViewController
            }
        }
    }
}
