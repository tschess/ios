//
//  Quick.swift
//  ios
//
//  Created by Matthew on 12/10/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Quick: UIViewController, UITabBarDelegate, UICollectionViewDelegate {
    
    let dateTime: DateTime = DateTime()
    
    @IBOutlet weak var playActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var tschxLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var opponentEloLabel: UILabel!
    @IBOutlet weak var opponentRankLabel: UILabel!
    @IBOutlet weak var opponentImageView: UIImageView!
    @IBOutlet weak var opponentNameLabel: UILabel!
    
    @IBOutlet weak var configCollectionView: DynamicCollectionView!
    @IBOutlet weak var configCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    @IBOutlet weak var letsPlayButton: UIButton!
    
    var gameAcceptTask: GameAcceptTask?
    
    var tschessElementMatrix: [[TschessElement?]]?
    
    var player: Player?
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    var opponent: Player?
    
    public func setOpponent(opponent: Player){
        self.opponent = opponent
    }
    
    var config: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarMenu.delegate = self
        
        configCollectionView.dataSource = self
        configCollectionView.delegate = self
        
        self.playActivityIndicator.isHidden = true
        
        switch Int.random(in: 0 ... 2) {
        case 0:
            self.config = "config0"
            self.tschessElementMatrix = self.player!.getConfig0()
        case 1:
            self.config = "config1"
            self.tschessElementMatrix = self.player!.getConfig1()
        default:
            self.config = "config2"
            self.tschessElementMatrix = self.player!.getConfig2()
        }
        
        self.opponentEloLabel.text = self.opponent!.getElo()
        self.opponentRankLabel.text = self.opponent!.getRank()
        let dataDecoded: Data = Data(base64Encoded: self.opponent!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.opponentImageView.image = decodedimage
        self.opponentNameLabel.text = self.opponent!.getName()
        self.letsPlayButton.isUserInteractionEnabled = true
        self.letsPlayButton.alpha = 1.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        self.rankLabel.text = self.player!.getRank()
        self.tschxLabel.text = "₮\(self.player!.getTschx())"
        self.usernameLabel.text = self.player!.getName()
        
        self.configCollectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.configCollectionViewHeight.constant = configCollectionView.contentSize.height
    }
    
    private func generateWhite(inputRow: [TschessElement?]) -> [TschessElement?] {
        var outputRow = [TschessElement?](repeating: nil, count: 8)
        for i in (0 ..< 8) {
            if(inputRow[i] != nil) {
                outputRow[i] = self.gameAcceptTask!.generateTschessElementWhite(name: inputRow[i]!.name)
            }
        }
        return outputRow
    }
    
    private func generateBlack(inputRow: [TschessElement?]) -> [TschessElement?] {
        var outputRow = [TschessElement?](repeating: nil, count: 8)
        for i in (0 ..< 8) {
            if(inputRow[i] != nil) {
                outputRow[i] = self.gameAcceptTask!.generateTschessElementBlack(name: inputRow[i]!.name)
            }
        }
        return outputRow
    }
    
    @IBAction func letsPlayButtonClick(_ sender: Any) {
        DispatchQueue.main.async() {
            self.letsPlayButton.isHidden = true
            self.playActivityIndicator.isHidden = false
            self.playActivityIndicator.startAnimating()
            self.playActivityIndicator.color = Colour().getRed()
        }
        let gameModel = Game(opponent: self.opponent!)
        gameModel.setUsernameWhite(usernameWhite: self.player!.getName())
        gameModel.setUsernameBlack(usernameBlack: self.opponent!.getName())
        gameModel.setUsernameTurn(usernameTurn: self.player!.getName())
        gameModel.setClock(clock: String(24))
        gameModel.setLastMoveBlack(lastMoveBlack: self.dateTime.currentDateString())
        gameModel.setLastMoveWhite(lastMoveWhite: "TBD")
        
        gameModel.setMessageWhite(messageWhite: "NONE")
        gameModel.setSeenMessageWhite(seenMessageWhite: false)
        gameModel.setMessageWhitePosted(messageWhitePosted: "TBD")
        gameModel.setMessageBlack(messageBlack: "NONE")
        gameModel.setSeenMessageBlack(seenMessageBlack: false)
        gameModel.setMessageBlackPosted(messageBlackPosted: "TBD")
        
        var skin: String = "NONE"
        if(self.player!.getSkin() != "NONE" || self.opponent!.getSkin() != "NONE"){
            skin = "IAPETUS"
        }
        gameModel.setSkin(skin: skin)
        
        self.gameAcceptTask = GameAcceptTask()
        self.gameAcceptTask!.setPlayer(player: self.player!)
        self.gameAcceptTask!.setGameModel(gameModel: gameModel)
        
        var opponentElementMatrix: [[TschessElement?]]?
        switch Int.random(in: 0 ... 2) {
        case 0:
            opponentElementMatrix = self.opponent!.getConfig0()
        case 1:
            opponentElementMatrix = self.opponent!.getConfig1()
        default:
            opponentElementMatrix = self.opponent!.getConfig2()
        }
        let gameMatrix: [[TschessElement?]] = [
            self.generateBlack(inputRow: opponentElementMatrix![1]),
            self.generateBlack(inputRow: opponentElementMatrix![0]),
            [TschessElement?](repeating: nil, count: 8),
            [TschessElement?](repeating: nil, count: 8),
            [TschessElement?](repeating: nil, count: 8),
            [TschessElement?](repeating: nil, count: 8),
            self.generateWhite(inputRow: self.tschessElementMatrix![0]),
            self.generateWhite(inputRow: self.tschessElementMatrix![1])]
        
        let gamestate = Gamestate(gameModel: gameModel, tschessElementMatrix: gameMatrix)
        gamestate.setPlayer(player: self.player!)
        
        let updated = dateTime.currentDateString()
        let requestPayload: [String: Any] = [
            "white_uuid": self.player!.getId(),
            "black_uuid": self.opponent!.getId(),
            "state": MatrixSerializer().serialize(elementRepresentation: gameMatrix, orientationBlack: false),
            "skin": skin,
            "clock": 24,
            "black_update": gameModel.getLastMoveBlack(),
            "updated": updated,
            "created": updated]
        
        QuickTaskGame().execute(requestPayload: requestPayload) { (result) in
            if(result == nil){
                //print("FUCK")
                return
            }
            gameModel.setIdentifier(identifier: result!)
            gamestate.setGameModel(gameModel: gameModel)
            gamestate.setPlayer(player: self.player!)
            StoryboardSelector().chess(gameModel: gamestate.getGameModel(), player: gamestate.getPlayer(), gamestate: gamestate)
            //            DispatchQueue.main.async() {
            //                let storyboard: UIStoryboard = UIStoryboard(name: "ChessCalhoun", bundle: nil)
            //                let viewController = storyboard.instantiateViewController(withIdentifier: "ChessCalhoun") as! Chess
            //                viewController.setGamestate(gamestate: gamestate)
            //                viewController.setGameModel(gameModel: gamestate.getGameModel())
            //                viewController.setPlayer(player: gamestate.getPlayer())
            //                UIApplication.shared.keyWindow?.rootViewController = viewController
            //            }
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().home(player: self.player!)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            StoryboardSelector().home(player: self.player!)
        }
    }
    
}

//MARK: - UICollectionViewDataSource
extension Quick: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        
        if (indexPath.row % 2 == 0) {
            if (indexPath.row / 8 == 0) {
                cell.backgroundColor = UIColor(red: 220/255.0, green: 0/255.0, blue: 70/255.0, alpha: 0.65)
            } else {
                cell.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 0.88)
            }
        } else {
            if (indexPath.row / 8 == 0) {
                cell.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 0.88)
            } else {
                cell.backgroundColor = UIColor(red: 220/255.0, green: 0/255.0, blue: 70/255.0, alpha: 0.65)
            }
        }
        
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        
        if(self.tschessElementMatrix![x][y] != nil){
            cell.imageView.image = self.tschessElementMatrix![x][y]!.getImageDefault()
        } else {
            cell.imageView.image = nil
        }
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return cell
    }
    
}


//MARK: - UICollectionViewDelegateFlowLayout
extension Quick: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 8
        let dim = collectionView.frame.width / cellsAcross
        return CGSize(width: dim, height: dim)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
