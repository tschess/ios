//
//  oSkins.swift
//  ios
//
//  Created by Matthew on 11/15/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Manage: UIViewController, UITabBarDelegate, UITextViewDelegate {
    
    let dateTime: DateTime = DateTime()
    
    @IBOutlet weak var previewButton: UIButton!
    
    @IBOutlet weak var defaultSwitch: UISwitch!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var tschxLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var player: Player?
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    var defaultSkin: Bool?
    
    public func setDefaultSkin(defaultSkin: Bool){
        self.defaultSkin = defaultSkin
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarMenu.delegate = self
        
        self.defaultSwitch.addTarget(self, action: #selector(valueChange), for:UIControl.Event.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.rankLabel.text = self.player!.getRank()
        self.tschxLabel.text = "₮\(self.player!.getTschx())"
        self.usernameLabel.text = self.player!.getName()
        
        if(!self.defaultSkin!){
            self.defaultSwitch.setOn(false, animated: false)
        }
    }
    
    @objc func valueChange(defaultSwitch: UISwitch) {
        let value = self.defaultSwitch.isOn
        //print("switch value changed \(value)")
        var skin = "NONE"
        if(value){
            skin = "IAPETUS"
        }
        let updated = dateTime.currentDateString()
        let requestPayload = ["id": self.player!.getId(), "skin": skin, "updated": updated]
        UpdateSkin().execute(requestPayload: requestPayload)  { (result) in
        }
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



