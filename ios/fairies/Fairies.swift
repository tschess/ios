//
//  Fairies.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Fairies: UIViewController, UITabBarDelegate {
    
    var fairyElementList: [Fairy] = [Amazon(), Grasshopper(), Hunter(), PoisonPawn()]
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!

    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicatorLabel: UIActivityIndicatorView!
    
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    public func renderHeader() {
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
        self.renderHeader()
        self.activityIndicatorLabel.isHidden = true
    }
    
    var squadUpAdapter: FairiesTable?
    
    func getSquadUpAdapter() -> FairiesTable? {
        return squadUpAdapter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tabBarMenu.delegate = self
        self.squadUpAdapter = children.first as? FairiesTable
        self.squadUpAdapter!.setPlayer(player: self.player!)
        self.squadUpAdapter!.setFairyElementList(fairyElementList: self.fairyElementList)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "FairiesTableSelection"),
            object: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "ConfigL", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConfigL") as! Config
        viewController.setPlayerSelf(playerSelf: self.player!)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let squadUpDetailSelectionIndex = notification.userInfo!["fairies_table_selection"] as! Int
        let fairyElement = squadUpAdapter!.getFairyElementList()![squadUpDetailSelectionIndex]
        //StoryboardSelector().acquisition(player: self.player!, fairyElement: fairyElement)
        let storyboard: UIStoryboard = UIStoryboard(name: "InfoL", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "InfoL") as! Info
        viewController.setPlayer(player: self.player!)
        viewController.setFairyElement(fairyElement: fairyElement)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "HomeL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "HomeL") as! Home
                viewController.setPlayer(player: self.player!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            }
        default:
            let storyboard: UIStoryboard = UIStoryboard(name: "ConfigL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ConfigL") as! Config
            viewController.setPlayerSelf(playerSelf: self.player!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
}
