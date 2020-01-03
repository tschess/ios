//
//  xProfile.swift
//  ios
//
//  Created by Matthew on 11/15/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit
import PushNotifications

class Profile: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var tschxLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var player: Player?
    
    func setPlayer(player: Player){
        self.player = player
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarMenu.delegate = self
        
        let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        
        self.rankLabel.text = self.player!.getRank()
        self.tschxLabel.text = "₮\(self.player!.getTschx())"
        self.usernameLabel.text = self.player!.getName()
        
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.onDidReceiveData(_:)),
        name: NSNotification.Name(rawValue: "OptionMenuSelection"),
        object: nil)
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let menuSelectionIndex = notification.userInfo!["option_menu_selection"] as! Int
        
        switch menuSelectionIndex {
        case 1:
            IapetusSkins().execute(id: self.player!.getId()) { (result) in
                if(result!.steward!){
                    StoryboardSelector().manage(player: self.player!, defaultSkin: result!.defaultSkin!)
                    return
                }
                StoryboardSelector().purchase(player: self.player!, remaining: result!.count!)
            }
        case 2:
            StoryboardSelector().eth(player: self.player!)
        case 3:
            self.signOut()
        default:
            StoryboardSelector().fairy(player: self.player!)
        }
    }
    
    func signOut() {
        //remove device from user profile on server...
        let device = UIDevice.current.identifierForVendor!.uuidString
        ClearDevice().execute(device: device) { (result) in
            //print("result: \(String(describing: result))")
            try? PushNotifications.shared.clearDeviceInterests()
            //exit(0)
            StoryboardSelector().start()
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().home(player: self.player!)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            StoryboardSelector().home(player: self.player!)
        }
    }
    
}
