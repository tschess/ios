//
//  ViewControllerGameMenu.swift
//  ios
//
//  Created by Matthew on 7/27/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
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
    
    var player: Player?
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarMenu.delegate = self
        self.historicTable = children.first as? HistoricTable
        
        //let gameModel: Game = Game(opponent: self.player!)
        //setGameModel(gameModel: Game)
        self.historicTable!.setPlayer(player: self.player!)
        //self.historicTable!.setIndicator(indicator: self.activityIndicator!)
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
        
        
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "HistoricSelection"),
            object: nil)

        self.activityIndicator.isHidden = true
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            StoryboardSelector().home(player: self.player!)
        default:
            StoryboardSelector().actual(player: self.player!)
        }
    }
    
//    @objc func onDidReceiveData(_ notification: NSNotification) {
//        let gameMenuSelectionIndex = notification.userInfo!["historic_selection"] as! Int
//        let gameModel = self.historicTable!.getGameMenuTableList()[gameMenuSelectionIndex]
//
//        DispatchQueue.main.async {
//            switch StoryboardSelector().device() {
//            case "XANDROID":
//                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotXandroid", bundle: nil)
//                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotXandroid") as! Snapshot
//                viewController.setGameModel(gameModel: gameModel)
//                self.present(viewController, animated: false, completion: nil)
//                return
//            case "MAGNUS":
//                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotMagnus", bundle: nil)
//                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotMagnus") as! Snapshot
//                viewController.setGameModel(gameModel: gameModel)
//                self.present(viewController, animated: false, completion: nil)
//                return
//            case "XENOPHON":
//                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotXenophon", bundle: nil)
//                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotXenophon") as! Snapshot
//                viewController.setGameModel(gameModel: gameModel)
//                self.present(viewController, animated: false, completion: nil)
//                return
//            case "PHAEDRUS":
//                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotPhaedrus", bundle: nil)
//                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotPhaedrus") as! Snapshot
//                viewController.setGameModel(gameModel: gameModel)
//                self.present(viewController, animated: false, completion: nil)
//                return
//            case "CALHOUN":
//                let storyboard: UIStoryboard = UIStoryboard(name: "SnapshotCalhoun", bundle: nil)
//                let viewController = storyboard.instantiateViewController(withIdentifier: "SnapshotCalhoun") as! Snapshot
//                viewController.setGameModel(gameModel: gameModel)
//                self.present(viewController, animated: false, completion: nil)
//                return
//            default:
//                return
//            }
//        }
//
//    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let gameMenuSelectionIndex = notification.userInfo!["historic_selection"] as! Int
        let gameModel = self.historicTable!.getGameMenuTableList()[gameMenuSelectionIndex]
        
        //let skin = self.otherMenuTable!.getGameMenuTableList()[gameMenuSelectionIndex].getSkin()
        //print("XXXXX: \(skin)")
        
        //gameModel.setSkin(skin: skin)
        gameModel.setAvatarSelf(avatarSelf: self.player!.getAvatar()) //????
        DispatchQueue.main.async {
            
            let storyboard: UIStoryboard = UIStoryboard(name: "EndgameOpponent", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "EndgameOpponent") as! EndgameSnapshot
            //viewController.setGameModel(gameModel: gameModel)
            self.present(viewController, animated: false, completion: nil)
            
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().actual(player: self.player!)
    }
}

