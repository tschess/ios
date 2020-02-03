//
//  ViewControllerGameMenu.swift
//  ios
//
//  Created by Matthew on 7/27/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Actual: UIViewController, UITabBarDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Properties
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    @IBOutlet weak var rankDirectionImage: UIImageView!
    
    var actualTable: ActualTable?
    
    var player: Player?
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarMenu.delegate = self
        actualTable = children.first as? ActualTable
        actualTable!.setActual(actual: self)
        actualTable!.setPlayer(player: self.player!)
        actualTable!.setIndicator(indicator: self.activityIndicator!)
    }
    
    public func renderHeader() {
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
                self.rankDirectionImage.image = image
                self.rankDirectionImage.tintColor = .green
            }
        }
        else {
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.down")!
                self.rankDirectionImage.image = image
                self.rankDirectionImage.tintColor = .red
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.renderHeader()
        
        self.activityIndicator.isHidden = true
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            StoryboardSelector().home(player: self.player!)
        default:
            StoryboardSelector().historic(player: self.player!)
        }
    }
    
//    @objc func onDidReceiveData(_ notification: NSNotification) {
//        let gameMenuSelectionIndex = notification.userInfo!["actual_selection"] as! Int
//
//        let gameModel = self.actualTable!.getGameMenuTableList()[gameMenuSelectionIndex]
//
//        let requestPayload: [String: Any] = ["id_game": gameModel.getIdentifier(), "id_player": self.player!.getId()]
//
//        let gameAck: GameAck = GameAck(idGame: gameModel.getIdentifier(), playerSelf: self.player!, playerOppo: gameModel.getOpponent())
//        let gameConnect: GameConnect = GameConnect(gameAck: gameAck)
//
//        RequestConnect().execute(requestPayload: requestPayload, gameConnect: gameConnect) { (gameTschess) in
//            print("result: \(gameTschess)")
//            /**
//             * ERROR HANDLING!!!
//             */
//            DispatchQueue.main.async {
//                let storyboard: UIStoryboard = UIStoryboard(name: "Tschess", bundle: nil)
//                let viewController = storyboard.instantiateViewController(withIdentifier: "Tschess") as! Tschess
//                viewController.setGameTschess(gameTschess: gameTschess!)
//                UIApplication.shared.keyWindow?.rootViewController = viewController
//            }
//        }
//    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().home(player: self.player!)
    }
}

