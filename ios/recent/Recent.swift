//
//  Recent.swift
//  ios
//
//  Created by Matthew on 2/13/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation
//this will just be his other page, and I'll modally pop up all his recent games on top of it...
import UIKit

class Recent: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
    var playerOther: EntityPlayer?
    
    func setPlayerOther(playerOther: EntityPlayer){
        self.playerOther = playerOther
    }
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    var game: EntityGame?

    func setGame(game: EntityGame){
        self.game = game
    }
    
    var recentGameList: [EntityGame]?
    
    func setRecentGameList(recentGameList: [EntityGame]){
        self.recentGameList = recentGameList
    }
    
    @IBOutlet weak var titleBackView: UIView!
    // @IBOutlet weak var titleBackImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    /* * */
    @IBOutlet weak var headerView: UIView!
    //@IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var winnerImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usernameLabelWhite: UILabel!
    @IBOutlet weak var usernameLabelBlack: UILabel!
    @IBOutlet weak var usernameWinner: UILabel!
    
    /* * */
    @IBOutlet weak var contentView: UIView!
    //@IBOutlet weak var contentImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var boardViewHeight: NSLayoutConstraint!
    
    /* * */
    @IBOutlet weak var statsView: UIView!
    
    @IBOutlet weak var moveCountLabel: UILabel!
    @IBOutlet weak var outcomeLabel: UILabel!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var state: [[Piece?]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.isHidden = true
        self.boardView.isHidden = true
        
        
        boardView.dataSource = self
        boardView.delegate = self
        tabBarMenu.delegate = self
        
    }
    
    //var INSTANTIATION: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        self.state = self.game!.getStateClient(username: self.playerOther!.username)
        self.winnerImageView!.image = self.game!.getImageAvatarWinner()
        self.usernameWinner.text = self.game!.getUsernameWinner()
        
        self.outcomeLabel.text = self.game!.outcome
        self.usernameLabelWhite.text = self.game!.white.username
        self.usernameLabelBlack.text = self.game!.black.username
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 8
        let dim = collectionView.frame.width / cellsAcross
        return CGSize(width: dim, height: dim)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "square", for: indexPath) as!  SquareCell
        cell.backgroundColor = assignCellBackgroundColor(indexPath: indexPath)
        cell.imageView.image = assignCellTschessElement(indexPath: indexPath)
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return cell
    }
    
    private func assignCellTschessElement(indexPath: IndexPath) -> UIImage? {
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        if(self.state![x][y] != nil){
            
            return self.state![x][y]!.getImageVisible()
        }
        return nil
    }
    
    private func assignCellBackgroundColor(indexPath: IndexPath) -> UIColor {
        if (indexPath.row % 2 == 0) {
            if ((indexPath.row / 8) % 2 == 0) {
                return UIColor.purple
            }
            return UIColor.brown
        }
        if ((indexPath.row / 8) % 2 == 0) {
            return UIColor.brown
        }
        return UIColor.purple
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
            viewController.setPlayer(player: self.playerSelf!)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        boardView.isHidden = false
        boardView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        boardViewHeight.constant = boardView.contentSize.height
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1: //next game
            
            //let skin: String = SelectRecent().getSkinGame(username: self.playerSelf!.username, game: self.game!)
            SelectRecent().snapshot(playerOther: self.playerOther!, playerSelf: self.playerSelf!, recentGameList: self.recentGameList!, presentor: self)
        default: //2 //home
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                viewController.setPlayer(player: self.playerSelf!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        }
    }
    
}
