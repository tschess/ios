//
//  Search.swift
//  ios
//
//  Created by Matthew on 1/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit


class Search: UIViewController, UITabBarDelegate  {
    
    //@IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchHeaderAlignmentConstranit: NSLayoutConstraint!
    
    @IBOutlet weak var searchHolderView: UIView!
    
    @IBOutlet weak var tabBarMenu: UITabBar!

    //@IBOutlet weak var rescindButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    //@IBOutlet weak var timeLabel: UILabel!
    //@IBOutlet weak var configLabel: UILabel!
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
    
    var leaderboardTableView: HomeMenuTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.searchViewHeight.constant = 0
        //self.searchHolderHeight.constant = 0
        
        
        leaderboardTableView = children.first as? HomeMenuTable
        leaderboardTableView!.setPlayer(player: self.player!)
        
        
//        tabBarMenu.delegate = self
//
//        self.usernameLabel.text = self.gameModel!.getOpponentName()
//        self.rankLabel.text = self.gameModel!.getOpponentRank()
//        let dataDecoded: Data = Data(base64Encoded: self.gameModel!.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
//        let decodedimage = UIImage(data: dataDecoded)
//        self.avatarImageView.image = decodedimage
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //let viewWithTag = self.view.viewWithTag(8)
        //viewWithTag!.removeFromSuperview()
        
        leaderboardTableView!.setSearchHeaderAlignmentConstranit(searchHeaderAlignmentConstranit: self.searchHeaderAlignmentConstranit)
        leaderboardTableView!.setSearchHolderView(searchHolderView: self.searchHolderView)
    }
    
    
   
    
    //@IBAction func backButtonClick(_ sender: Any) {
        //StoryboardSelector().actual(player: self.player!)
    //}
    
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        switch item.tag {
//        case 0:
//            StoryboardSelector().actual(player: self.player!)
//        default:
//            StoryboardSelector().home(player: self.player!)
//        }
//    }
}
