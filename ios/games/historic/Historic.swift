//
//  Historic.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Historic: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        self.historicTable!.fetchMenuTableList()
    }
    
    public func renderHeader() {
        self.avatarImageView.image = self.playerSelf!.getImageAvatar()
        self.usernameLabel.text = self.playerSelf!.username
        self.eloLabel.text = self.playerSelf!.getLabelTextElo()
        self.rankLabel.text = self.playerSelf!.getLabelTextRank()
        self.displacementLabel.text = self.playerSelf!.getLabelTextDisp()
        self.displacementImage.image = self.playerSelf!.getImageDisp()!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "HistoricSelection"),
            object: nil)
        
        //^^^is this needed???
        
        self.activityIndicator.isHidden = true
        self.renderHeader()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                viewController.setPlayer(player: self.playerSelf!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        default:
            DispatchQueue.main.async() {
                let storyboard: UIStoryboard = UIStoryboard(name: "Actual", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Actual") as! Actual
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        }
    }
    
    
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let gameMenuSelectionIndex = notification.userInfo!["historic_selection"] as! Int
        let game = self.historicTable!.getGameMenuTableList()[gameMenuSelectionIndex]
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Snapshot", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Snapshot") as! Snapshot
        viewController.setGame(game: game)
        viewController.setPlayer(player: self.playerSelf!)
        self.present(viewController, animated: false, completion: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async() {
            let storyboard: UIStoryboard = UIStoryboard(name: "Actual", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Actual") as! Actual
            viewController.setPlayerSelf(playerSelf: self.playerSelf!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
}
