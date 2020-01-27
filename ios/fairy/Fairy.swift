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

    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicatorLabel: UIActivityIndicatorView!
    
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
        
        self.activityIndicatorLabel.isHidden = true
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
        //self.squadUpAdapter!.setFairyElementList(fairyElementList: self.player!.getFairyElementList())
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "SquadUpDetailSelection"),
            object: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Config", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Config") as! Config
        viewController.setPlayer(player: self.player!)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let squadUpDetailSelectionIndex = notification.userInfo!["squad_up_detail_selection"] as! Int
        let fairyElement = squadUpAdapter!.getFairyElementList()![squadUpDetailSelectionIndex]
        //StoryboardSelector().acquisition(player: self.player!, fairyElement: fairyElement)
        let storyboard: UIStoryboard = UIStoryboard(name: "Intro", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Intro") as! Intro
        viewController.setPlayer(player: self.player!)
        viewController.setFairyElement(fairyElement: fairyElement)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            StoryboardSelector().home(player: self.player!)
            return
        default:
            let storyboard: UIStoryboard = UIStoryboard(name: "Config", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Config") as! Config
            viewController.setPlayer(player: self.player!)
            //viewController.setOpponent(opponent: opponent)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
}
