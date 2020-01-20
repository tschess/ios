//
//  Other.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Other: UIViewController, UITabBarDelegate {
   
    @IBOutlet weak var challengeButtonView: UIView! //should deffer rendering until appointed moment...
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let dateTime: DateTime = DateTime()
    
    //MARK: Properties
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var player: Player?
    var gameModel: Game?
    
    var otherMenuTable: OtherMenuTable?
    
    @IBOutlet weak var newChallengeButton: UIButton!
    
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    func setGameModel(gameModel: Game){
        self.gameModel = gameModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.otherMenuTable = children.first as? OtherMenuTable
        self.otherMenuTable!.setGameModel(gameModel: self.gameModel!)
        self.otherMenuTable!.fetchMenuTableList()
        
        tabBarMenu.delegate = self
        
        self.activityIndicator.isHidden = true
        
        let dataDecoded: Data = Data(base64Encoded: gameModel!.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.rankLabel.text = gameModel!.getOpponentRank()
        self.usernameLabel.text = gameModel!.getOpponentName()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "ChallengeMenuTableView"),
            object: nil)
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let gameMenuSelectionIndex = notification.userInfo!["challenge_menu_game_selection"] as! Int
        let gameModel = self.otherMenuTable!.getGameMenuTableList()[gameMenuSelectionIndex]
        
        let skin = self.otherMenuTable!.getGameMenuTableList()[gameMenuSelectionIndex].getSkin()
        //print("XXXXX: \(skin)")
        
        gameModel.setSkin(skin: skin)
        DispatchQueue.main.async {
            switch StoryboardSelector().device() {
            case "XANDROID":
                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotXandroid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotXandroid") as! Snapshot
                viewController.setGameModel(gameModel: gameModel)
                self.present(viewController, animated: false, completion: nil)
                return
            case "MAGNUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotMagnus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotMagnus") as! Snapshot
                viewController.setGameModel(gameModel: gameModel)
                self.present(viewController, animated: false, completion: nil)
                return
            case "XENOPHON":
                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotXenophon", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotXenophon") as! Snapshot
                viewController.setGameModel(gameModel: gameModel)
                self.present(viewController, animated: false, completion: nil)
                return
            case "PHAEDRUS":
                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotPhaedrus", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotPhaedrus") as! Snapshot
                viewController.setGameModel(gameModel: gameModel)
                self.present(viewController, animated: false, completion: nil)
                return
            case "CALHOUN":
                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotCalhoun", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotCalhoun") as! Snapshot
                viewController.setGameModel(gameModel: gameModel)
                self.present(viewController, animated: false, completion: nil)
                return
            default:
                return
            }
        }
    }

    @IBAction func backButtonClick(_ sender: Any) {
        let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
        homeViewController.setPlayer(player: self.player!)
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }
    
    @IBAction func newChallengeButtonClick(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
        viewController.setPlayer(player: self.player!)
        viewController.setGameModel(gameModel: self.gameModel!)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            print("1")
            let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
            viewController.setPlayer(player: self.player!)
            viewController.setGameModel(gameModel: self.gameModel!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        default:
            let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
            homeViewController.setPlayer(player: self.player!)
            UIApplication.shared.keyWindow?.rootViewController = homeViewController
        }
    }
}
