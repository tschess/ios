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
    
    var skinTableMenu: SkinsTableMenu?
    
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
        self.usernameLabel.text = self.player!.getUsername()
        self.eloLabel.text = self.player!.getElo()
        self.displacementLabel.text = String(abs(Int(self.player!.getDisp())!))
        
        let disp: Int = Int(self.player!.getDisp())!
        
        if(disp >= 0){
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.up")!
                self.displacementImage.image = image
                self.displacementImage.tintColor = .green
            }
        }
        else {
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.down")!
                self.displacementImage.image = image
                self.displacementImage.tintColor = .red
            }
        }
        
        self.activityIndicator.isHidden = true
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let skinSelection = notification.userInfo!["skin_selection"] as! SkinCore
        
        DispatchQueue.main.async {
            switch skinSelection.getName() {
            case "hyperion":
                let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! Detail
                viewController.setPlayer(player: self.player!)
                viewController.setSkin(skin: skinSelection)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "calypso":
                let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! Detail
                viewController.setPlayer(player: self.player!)
                viewController.setSkin(skin: skinSelection)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "neptune":
                let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! Detail
                viewController.setPlayer(player: self.player!)
                viewController.setSkin(skin: skinSelection)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            case "iapetus":
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
        self.skinTableMenu = children.first as? SkinsTableMenu
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "SkinSelection"),
            object: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
        homeViewController.setPlayer(player: self.player!)
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            StoryboardSelector().home(player: self.player!)
            return
        default:
            let homeStoryboard: UIStoryboard = UIStoryboard(name: "Address", bundle: nil)
            let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Address") as! Address
            homeViewController.setPlayer(player: self.player!)
            UIApplication.shared.keyWindow?.rootViewController = homeViewController
        }
    }
}
