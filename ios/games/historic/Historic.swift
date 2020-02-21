//
//  Historic.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Historic: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Properties
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var displacementImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var historicTable: HistoricTable?
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarMenu.delegate = self
        self.historicTable = children.first as? HistoricTable
        self.historicTable!.setPlayerSelf(playerSelf: self.playerSelf!)
        self.historicTable!.setActivityIndicator(activityIndicator: self.activityIndicator)
        self.historicTable!.fetchMenuTableList()
    }
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerSelf!.getImageAvatar()
        self.usernameLabel.text = self.playerSelf!.username
        self.eloLabel.text = self.playerSelf!.getLabelTextElo()
        self.rankLabel.text = self.playerSelf!.getLabelTextRank()
        self.displacementLabel.text = self.playerSelf!.getLabelTextDisp()
        self.displacementImage.image = self.playerSelf!.getImageDisp()!
        self.displacementImage.tintColor = self.playerSelf!.tintColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "HistoricSelection"),
            object: nil)
        
        self.activityIndicator.isHidden = true
        self.renderHeader()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            DispatchQueue.main.async {
                let height: CGFloat = self.view.frame.size.height
                SelectHome().execute(player: self.playerSelf!, height: height)
            }
        default:
            DispatchQueue.main.async {
                let height: CGFloat = self.view.frame.size.height
                SelectActual().execute(player: self.playerSelf!, height: height)
            }
        }
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let gameMenuSelectionIndex = notification.userInfo!["historic_selection"] as! Int
        let game = self.historicTable!.getGameMenuTableList()[gameMenuSelectionIndex]
        
        let skin: String = SelectSnapshot().getSkinGame(username: self.playerSelf!.username, game: game)
        SelectSnapshot().snapshot(skin: skin, playerSelf: self.playerSelf!, game: game, presentor: self)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async {
            let height: CGFloat = self.view.frame.size.height
            SelectActual().execute(player: self.playerSelf!, height: height)
        }
    }
}
