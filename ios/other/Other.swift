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
    
    var player: Player?
    var gameModel: Game?
    
    var otherMenuTable: OtherMenuTable?
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    func setGameModel(gameModel: Game){
        self.gameModel = gameModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.otherMenuTable = children.first as? OtherMenuTable
        self.otherMenuTable!.setActivityIndicator(activityIndicator: self.activityIndicator!)
        self.otherMenuTable!.setGameModel(gameModel: self.gameModel!)
        self.otherMenuTable!.setPlayer(player: self.player!)
        self.otherMenuTable!.fetchMenuTableList()
        
        self.tabBarMenu.delegate = self
        
        self.activityIndicator.isHidden = true
        
        let dataDecoded: Data = Data(base64Encoded: gameModel!.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.rankLabel.text = gameModel!.getOpponentRank()
        self.eloLabel.text = gameModel!.getOpponent().getElo()
        self.usernameLabel.text = gameModel!.getUsernameOpponent()
        
        let date: String = gameModel!.getOpponent().getDate()
        if(date == "TBD"){
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YY"
            var yayayaya = formatter.string(from: DateTime().currentDate())
            yayayaya.insert("'", at: yayayaya.index(yayayaya.endIndex, offsetBy: -2))
            self.dateLabel.text = yayayaya
        } else {
            //date...
        }
        
        
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
        
        let id: String = gameModel.getIdentifier()
        let date: String = gameModel.endDate
        var avatarWinner: String = gameModel.getOpponentAvatar()
        let usernameWinner: String = gameModel.winner
        if(gameModel.winnerInt == 1){
            avatarWinner = self.player!.getAvatar()
        }
        let endgameCore: EndgameCore = EndgameCore(id: id, date: date, avatarWinner: avatarWinner, usernameWinner: usernameWinner)
        let requestPayload = ["game_id": gameModel.getIdentifier(), "self_id": self.player!.getId()]
        RequestSnapshot().execute(requestPayload: requestPayload, endgameCore: endgameCore) { (snapshot) in
            DispatchQueue.main.async {
                //print("snapshot: \(snapshot)")
                let storyboard: UIStoryboard = UIStoryboard(name: "EndgameSnapshot", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "EndgameSnapshot") as! EndgameSnapshot
                viewController.setSnapshot(snapshot: snapshot!)
                self.present(viewController, animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
        homeViewController.setPlayer(player: self.player!)
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:

            
            
            print("1")
            let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
            viewController.setPlayer(player: self.player!)
            viewController.setOpponent(opponent: self.gameModel!.getOpponent())
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
