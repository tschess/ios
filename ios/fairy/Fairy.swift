//
//  SquadUpActivity.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Fairy: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
//    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    //    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    //    @IBOutlet weak var tschxLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    //    @IBOutlet weak var usernameLabel: UILabel!
    
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
    
    var squadUpAdapter: FairyTableMenu?
    
    func getSquadUpAdapter() -> FairyTableMenu? {
        return squadUpAdapter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tabBarMenu.delegate = self
        self.squadUpAdapter = children.first as? FairyTableMenu
        self.squadUpAdapter!.setPlayer(player: self.player!)
        self.squadUpAdapter!.setFairyElementList(fairyElementList: self.player!.getFairyElementList())
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "SquadUpDetailSelection"),
            object: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().home(player: self.player!)
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let squadUpDetailSelectionIndex = notification.userInfo!["squad_up_detail_selection"] as! Int
        let fairyElement = squadUpAdapter!.getFairyElementList()![squadUpDetailSelectionIndex]
        //StoryboardSelector().acquisition(player: self.player!, fairyElement: fairyElement)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            let storyboard: UIStoryboard = UIStoryboard(name: "Config", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Config") as! Config
            viewController.setPlayer(player: self.player!)
            //viewController.setOpponent(opponent: opponent)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
}
