//
//  Context.swift
//  ios
//
//  Created by Matthew on 3/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Context: UIViewController, UITabBarDelegate {
    
    
    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var skinTableMenu: ContextTable?
    
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
        let skin = notification.userInfo!["skin_selection"] as! EntitySkin
        DispatchQueue.main.async() {
            let height: CGFloat = UIScreen.main.bounds.height
            SelectDetail().execute(player: self.player!, skin: skin, height: height)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarMenu.delegate = self
        self.skinTableMenu = children.first as? ContextTable
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "SkinSelection"),
            object: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async() {
            let height: CGFloat = UIScreen.main.bounds.height
            SelectProfile().execute(player: self.player!, height: height)
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        DispatchQueue.main.async() {
            let height: CGFloat = UIScreen.main.bounds.height
            SelectProfile().execute(player: self.player!, height: height)
        }
    }
}
