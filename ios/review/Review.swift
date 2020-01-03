//
//  ReviewActivity.swift
//  ios
//
//  Created by Matthew on 7/29/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Review: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITabBarDelegate {
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var timeLimitLabel: UILabel!
    
    @IBOutlet weak var opponentUsernameLabel: UILabel!
    @IBOutlet weak var opponentAvatarImageView: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var configPickerView: UIPickerView!
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    var gameModel: Game?
    var player: Player?
    var gameList: [Game]?
    
    var gameMenuTable: ChallengeMenuTable?
    
    var configPickerSelection: String = "confiig0"
    //var configPickerData: [String] = ["config. 0̸", "config. 1", "config. 2", "standard"]
    var configPickerData: [String] = ["config. 0̸", "config. 1", "config. 2"]
    
    func setGameModel(gameModel: Game) {
        self.gameModel = gameModel
    }
    
    func setPlayer(player: Player) {
        self.player = player
    }
    
    func setGameList(gameList: [Game]) {
        self.gameList = gameList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameMenuTable = children.first as! ChallengeMenuTable
        gameMenuTable!.setGameModel(gameModel: self.gameModel!)
        gameMenuTable!.fetchMenuTableList()
        
        tabBarMenu.delegate = self
        
        let dataDecoded: Data = Data(base64Encoded: self.gameModel!.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.opponentAvatarImageView.image = decodedimage
        self.rankLabel.text = self.gameModel!.getOpponentRank()
        self.opponentUsernameLabel.text = self.gameModel!.getOpponentName()
        
        if(gameModel!.clock == "1") {
            self.timeLimitLabel.text = "01:00 h"
        }
        if(gameModel!.clock == "5") {
            self.timeLimitLabel.text = "00:05 m"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "ChallengeMenuTableView"),
            object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configPickerView.delegate = self
        configPickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return configPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel {
            label = v
        }
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.light)
        label.text =  configPickerData[row]
        label.textColor =  UIColor(red: 220/255.0, green: 4/255.0, blue: 4/255.0, alpha: 1)
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return configPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        configPickerSelection = configPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().actual(player: self.player!)
    }
    
    @IBAction func rejectButtonClick(_ sender: Any) {
        GameDeleteTask().execute(id: gameModel!.getIdentifier())
        StoryboardSelector().actual(player: self.player!)
    }
    
    @IBAction func acceptButtonClick(_ sender: Any) {
        var tschessElementMatrix: [[TschessElement?]] = self.player!.getConfig0()
        if(configPickerSelection == "config. 1"){
            tschessElementMatrix = self.player!.getConfig1()
        }
        if(configPickerSelection == "config. 2"){
            tschessElementMatrix = self.player!.getConfig2()
        }
//        if(configPickerSelection == "standard"){
//            //TODO
//            print("FUCK FUCK FUCK FUCK")
//            print("~~~~")
//            print("!!")
//        }
        GameAcceptTask().execute(config: tschessElementMatrix, gameModel: gameModel!, player: self.player!) { (result) in
            StoryboardSelector().chess(gamestate: result)
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            StoryboardSelector().actual(player: self.player!)
        default:
            StoryboardSelector().home(player: self.player!)
        }
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let gameMenuSelectionIndex = notification.userInfo!["challenge_menu_game_selection"] as! Int
        let gameModel = self.gameMenuTable!.getGameMenuTableList()[gameMenuSelectionIndex]
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
}
