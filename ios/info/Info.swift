//
//  Info.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Info: UIViewController, UITabBarDelegate, UIPopoverPresentationControllerDelegate, UITextViewDelegate {
    
    let dateTime: DateTime = DateTime()
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var fairyImageView: UIImageView!
    @IBOutlet weak var fairyNameLabel: UILabel!
    @IBOutlet weak var fairyPointsLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //    @IBOutlet weak var pointsLabel: UILabel!
    //    @IBOutlet weak var valueLabel: UILabel!
    //    @IBOutlet weak var tschessElementImageView: UIImageView!
    //    @IBOutlet weak var tschessElementLabel: UILabel!
    //
    //    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    @IBOutlet weak var attributeTextView: UITextView!
    
    var fairyElement: Fairy?
    
    func setFairyElement(fairyElement: Fairy) {
        self.fairyElement = fairyElement
    }
    
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fairyImageView.image = fairyElement!.getImageDefault()
        self.fairyNameLabel.text = fairyElement!.getName().lowercased()
        self.fairyPointsLabel.text = fairyElement!.getStrength()
        //self.tschessElementLabel.text = fairyElement!.name.lowercased()
        //
        //        self.pointsLabel.text = fairyElement!.strength
        //        self.valueLabel.text = "₮\(fairyElement!.tschxValue)"
        //        self.attributeTextView.text = fairyElement!.description
        //        self.attributeTextView.isEditable = false
        //        self.attributeTextView.backgroundColor = UIColor.white
        //        self.attributeTextView.textColor = UIColor.black
        //
        //        if(self.player!.getFairyElementList().contains(self.fairyElement!)){
        //            completeButton.setTitle( "acquired" , for: .normal)
        //            completeButton.alpha = 1
        //            completeButton.isUserInteractionEnabled = false
        //            completeButton.setTitleColor(UIColor.black, for: .normal)
        //        } else {
        //            if(Int(self.player!.getTschx())! < Int(fairyElement!.tschxValue)!){
        //                completeButton.setTitle( "tschx (₮) balance insufficient" , for: .normal)
        //                completeButton.alpha = 0.5
        //                insufficientBalance = true
        //                completeButton.isUserInteractionEnabled = false
        //            }
        //        }
        //        let device = StoryboardSelector().device()
        //        if(device == "XANDROID" || device == "MAGNUS"){
        //            return
        //        }
        //        let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
        //        let decodedimage = UIImage(data: dataDecoded)
        //        self.avatarImageView!.image = decodedimage
        //        self.usernameLabel!.text = self.player!.getName()
        //        self.rankLabel!.text = self.player!.getRank()
        //        self.tschxLabel!.text = "₮\(self.player!.getTschx())"
        self.activityIndicator.isHidden = true
    }
    
    var insufficientBalance: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarMenu.delegate = self
        
        let description = "" +
            "• freshly minted individual edition of the iapetus game skin, one of fifty\r\r" +
            "• visible to oneself and opponent during gameplay\r\r" +
            "• globally visible in leaderboard and on challenge/review endgame snapshot\r\r" +
        "• design inspired by science fantasy novel \"the chessmen of mars\" by edgar rice burroughs\r\r"
        
        //self.descriptionTextVieew
        self.attributeTextView.isEditable = false
        self.attributeTextView.backgroundColor = UIColor.white
        self.attributeTextView.textColor = UIColor.black
        self.attributeTextView.text = description
    }
    
    //    @IBAction func completeButtonClick(_ sender: Any) {
    //        if(insufficientBalance){
    //            return
    //        }
    //        let name = self.player!.getName()
    //        let target = self.fairyElement!.name
    //        let tschx = self.fairyElement!.getTschxValue()
    //        let requestPayload = ["name": name, "target": target, "tschx": tschx, "updated": dateTime.currentDateString()]
    //        SquadUpTask().execute(requestPayload: requestPayload, player: self.player!) { (result, error) in
    //            StoryboardSelector().fairy(player: self.player!)
    //        }
    //    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Fairies", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Fairies") as! Fairies
            viewController.setPlayer(player: self.player!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Fairies", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Fairies") as! Fairies
                viewController.setPlayer(player: self.player!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            return
        default:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                viewController.setPlayer(player: self.player!)
                UIApplication.shared.keyWindow?.rootViewController = viewController}
        }
    }
    
}
