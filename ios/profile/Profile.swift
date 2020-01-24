//
//  xProfile.swift
//  ios
//
//  Created by Matthew on 11/15/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit
//import PushNotifications

class Profile: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    

    
    
    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    
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
        //self.tschxLabel.text = "₮\(self.player!.getTschx())"
        self.usernameLabel.text = self.player!.getName()
        
        self.activityIndicator.isHidden = true
        
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.onDidReceiveData(_:)),
        name: NSNotification.Name(rawValue: "OptionMenuSelection"),
        object: nil)
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let menuSelectionIndex = notification.userInfo!["option_menu_selection"] as! Int
        
        switch menuSelectionIndex {
        case 0:
            print("lolol")
        default:
            self.signOut()
        }
    }
    
    func signOut() {
        //remove device from user profile on server...
        let device = UIDevice.current.identifierForVendor!.uuidString
        ClearDevice().execute(device: device) { (result) in
            //print("result: \(String(describing: result))")
            //try? PushNotifications.shared.clearDeviceInterests()
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
