//
//  Other.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Other: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let DATE_TIME: DateTime = DateTime()
    
    //MARK: Properties
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    
    var otherMenuTable: OtherMenuTable?
    
    var playerOther: EntityPlayer?
    
    func setPlayerOther(playerOther: EntityPlayer){
        self.playerOther = playerOther
    }
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerOther!.getImageAvatar()
        self.usernameLabel.text = self.playerOther!.username
        self.eloLabel.text = self.playerOther!.getLabelTextElo()
        self.rankLabel.text = self.playerOther!.getLabelTextRank()
        self.dateLabel.text = self.playerOther!.getLabelTextDate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.otherMenuTable = children.first as? OtherMenuTable
        self.otherMenuTable!.setActivityIndicator(activityIndicator: self.activityIndicator!)
        self.otherMenuTable!.setPlayer(player: self.playerOther!)
        self.otherMenuTable!.fetchMenuTableList()
        
        
        
        self.tabBarMenu.delegate = self
        
        self.activityIndicator.isHidden = true
        
        self.renderHeader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "OtherMenuTable"),
            object: nil)
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let gameMenuSelectionIndex = notification.userInfo!["other_menu_selection"] as! Int
        let game = self.otherMenuTable!.getGameMenuTableList()[gameMenuSelectionIndex]
        
        let skin: String = SelectSnapshot().getSkinGame(username: self.playerOther!.username, game: game)
        SelectSnapshot().snapshot(skin: skin, playerSelf: self.playerSelf!, game: game, presentor: self)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async {
            let height: CGFloat = UIScreen.main.bounds.height
            SelectHome().execute(player: self.playerSelf!, height: height)
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        DispatchQueue.main.async {
            let height: CGFloat = UIScreen.main.bounds.height
            SelectChallenge().execute(selection: Int.random(in: 0...3), playerSelf: self.playerSelf!, playerOther: self.playerOther!, BACK: "OTHER", height: height)
        }
    }
}
