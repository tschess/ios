//
//  CancelActivity.swift
//  ios
//
//  Created by Matthew on 7/30/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit


class Cancel: UIViewController, UITabBarDelegate  {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    @IBOutlet weak var rescindButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var configLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var gameModel: Game?
    
    public func setGameModel(gameModel: Game){
        self.gameModel = gameModel
    }
    
    var player: Player?
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    var gameList: [Game]?
    
    func setGameList(gameList: [Game]){
        self.gameList = gameList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarMenu.delegate = self
        
        self.usernameLabel.text = self.gameModel!.getOpponentName()
        self.rankLabel.text = self.gameModel!.getOpponentRank()
        let dataDecoded: Data = Data(base64Encoded: self.gameModel!.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        
        if(gameModel!.clock == "24"){
            self.timeLabel.text = "24:00 h"
        }
        if(gameModel!.clock == "1"){
            self.timeLabel.text = "01:00 h"
        }
        if(gameModel!.clock == "5"){
            self.timeLabel.text = "00:05 m"
        }
        
        if(self.gameModel!.getConfigurationInviter()! == self.player!.getConfig0()){
            self.configLabel.text = "config. 0̸"
        }
        if(self.gameModel!.getConfigurationInviter()! == self.player!.getConfig1()){
            self.configLabel.text = "config. 1"
        }
        if(self.gameModel!.getConfigurationInviter()! == self.player!.getConfig2()){
            self.configLabel.text = "config. 2"
        }
        
    }
    @IBAction func rescindButtonClick(_ sender: Any) {
        GameDeleteTask().execute(id: gameModel!.getIdentifier())
        if let index = gameList!.firstIndex(of: gameModel!) {
            gameList!.remove(at: index)
        }
        StoryboardSelector().actual(player: self.player!)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().actual(player: self.player!)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            StoryboardSelector().actual(player: self.player!)
        default:
            StoryboardSelector().home(player: self.player!)
        }
    }
}

