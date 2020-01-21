//
//  SquadUpDetail.swift
//  ios
//
//  Created by Matthew on 8/20/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Intro: UIViewController, UITabBarDelegate, UIPopoverPresentationControllerDelegate, UITextViewDelegate {
    
    let dateTime: DateTime = DateTime()
    
    @IBOutlet weak var backButton: UIButton!
    
//    @IBOutlet weak var avatarImageView: UIImageView?
//    @IBOutlet weak var rankLabel: UILabel?
//    @IBOutlet weak var tschxLabel: UILabel?
//    @IBOutlet weak var usernameLabel: UILabel?
//
//    @IBOutlet weak var pointsLabel: UILabel!
//    @IBOutlet weak var valueLabel: UILabel!
//    @IBOutlet weak var tschessElementImageView: UIImageView!
//    @IBOutlet weak var tschessElementLabel: UILabel!
//
//    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    @IBOutlet weak var attributeTextView: UITextView!
    
    var fairyElement: FairyElement?
    
    func setFairyElement(fairyElement: FairyElement) {
        self.fairyElement = fairyElement
    }
    
    var player: Player?
    
    public func setPlayer(player: Player) {
        self.player = player
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.tschessElementImageView.image = fairyElement!.getImageDefault()
//        self.tschessElementLabel.text = fairyElement!.name.lowercased()
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
    }
    
    var insufficientBalance: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarMenu.delegate = self
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
        StoryboardSelector().fairy(player: self.player!)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            StoryboardSelector().fairy(player: self.player!)
        default:
            StoryboardSelector().home(player: self.player!)
        }
    }
    
}
