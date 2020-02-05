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
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Snapshot", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Snapshot") as! Snapshot
        viewController.setGame(game: game)
        viewController.setPlayer(player: self.playerOther!)
        self.present(viewController, animated: false, completion: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
        homeViewController.setPlayer(player: self.playerSelf!)
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
//        case 1:
//            let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
//            viewController.setPlayer(player: self.player!)
//            viewController.setOpponent(opponent: self.gameModel!.getOpponent())
//            viewController.setGameModel(gameModel: self.gameModel!)
//            UIApplication.shared.keyWindow?.rootViewController = viewController
        default:
            let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
            homeViewController.setPlayer(player: self.playerSelf!)
            UIApplication.shared.keyWindow?.rootViewController = homeViewController
        }
    }
}
