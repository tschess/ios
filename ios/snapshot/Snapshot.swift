//
//  HistoricalGame.swift
//  ios
//
//  Created by Matthew on 10/22/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Snapshot: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
    @IBOutlet weak var endgameLabel: UILabel!
    
    @IBOutlet weak var iapetusTop: UIImageView?
    @IBOutlet weak var iapetusContent: UIImageView!
    
    @IBOutlet weak var opponentAvatarImageView: UIImageView?
    @IBOutlet weak var opponentUsernameLabel: UILabel?
    @IBOutlet weak var rankLabelIndicator: UILabel?
    @IBOutlet weak var opponentRankLabel: UILabel?
    
    @IBOutlet weak var collectionView: DynamicCollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var whiteLabel: UILabel!
    @IBOutlet weak var blackLabel: UILabel!
    
    var gameModel: Game?
    
    public func setGameModel(gameModel: Game){
        self.gameModel = gameModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.isHidden = true
        
        let boldAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.light)]
        let normalAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.light)]
        
        let lightIndicator = NSMutableAttributedString(
            string: "light: ",
            attributes: boldAttributes)
        let lightUsername = NSMutableAttributedString(
            string: gameModel!.getUsernameWhite(),
            attributes: normalAttributes)

        let lightLabelText = NSMutableAttributedString()
        lightLabelText.append(lightIndicator)
        lightLabelText.append(lightUsername)
        
        self.whiteLabel.attributedText = lightLabelText
        
        let darkIndicator = NSMutableAttributedString(
            string: "dark: ",
            attributes: boldAttributes)
        let darkUsername = NSMutableAttributedString(
            string: gameModel!.getUsernameBlack(),
            attributes: normalAttributes)

        let darkLabelText = NSMutableAttributedString()
        darkLabelText.append(darkIndicator)
        darkLabelText.append(darkUsername)
        
        
        self.whiteLabel.attributedText = lightLabelText
        self.blackLabel.attributedText = darkLabelText
        
        
        let winnerIndicator = NSMutableAttributedString(
            string: "winner: ",
            attributes: boldAttributes)
        var winnerUsername = NSMutableAttributedString(
            string: "winner: n/a",
            attributes: normalAttributes)
        if(gameModel!.getWinner() != "DRAW" || gameModel!.getWinner() != "TBD"){
            winnerUsername = NSMutableAttributedString(
            string: gameModel!.getWinner(),
            attributes: normalAttributes)
        }
        let winnerLabelText = NSMutableAttributedString()
        winnerLabelText.append(winnerIndicator)
        winnerLabelText.append(winnerUsername)
        self.winnerLabel.attributedText = winnerLabelText
        
        self.device = StoryboardSelector().device()
        
        self.renderSkinLayout()

        if(self.device! == "MAGNUS" || self.device! == "XANDROID"){
            return
        }
        let dataDecoded: Data = Data(base64Encoded: self.gameModel!.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.opponentAvatarImageView!.image = decodedimage
        self.opponentRankLabel!.text = self.gameModel!.getOpponentRank()
        self.opponentUsernameLabel!.text = self.gameModel!.getOpponentName()
    }
    
    var defaultColor: UIColor?
    
    func renderSkinLayout() {
        //print("self.gameModel!.skin\(self.gameModel!.skin)")
        if(self.gameModel!.skin == "NONE"){
            self.iapetusContent.image = nil
            self.defaultColor = UIColor.black
            if(self.device! == "MAGNUS" || self.device! == "XANDROID"){
                return
            }
            self.iapetusTop!.image = nil
            return
        }
        self.defaultColor = UIColor.white
        
        self.endgameLabel.textColor = UIColor.white
        self.endgameLabel.shadowOffset = CGSize(width: -1, height: -1)
        self.endgameLabel.shadowColor = UIColor.black
        
        self.backButton.titleLabel!.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.light)
        self.backButton.setTitleColor(UIColor.white, for: .normal)
        self.backButton.setTitleShadowColor(UIColor.black, for: .normal)
        self.backButton.titleLabel!.shadowOffset = CGSize(width: -1, height: -1)
        
        self.winnerLabel!.textColor = UIColor.white
        self.winnerLabel!.shadowOffset = CGSize(width: -1, height: -1)
        self.winnerLabel!.shadowColor = UIColor.black
        
        self.whiteLabel!.textColor = UIColor.white
        self.whiteLabel!.shadowOffset = CGSize(width: -1, height: -1)
        self.whiteLabel!.shadowColor = UIColor.black
        
        self.blackLabel!.textColor = UIColor.white
        self.blackLabel!.shadowOffset = CGSize(width: -1, height: -1)
        self.blackLabel!.shadowColor = UIColor.black
        
        if(self.device! == "MAGNUS" || self.device! == "XANDROID"){
            return
        }
        
        self.opponentUsernameLabel!.textColor = UIColor.white
        self.opponentUsernameLabel!.shadowOffset = CGSize(width: -1, height: -1)
        self.opponentUsernameLabel!.shadowColor = UIColor.black
        
        self.opponentRankLabel!.shadowOffset = CGSize(width: -1, height: -1)
        self.opponentRankLabel!.shadowColor = UIColor.black
        
        self.rankLabelIndicator!.textColor = UIColor.white
        self.rankLabelIndicator!.shadowOffset = CGSize(width: -1, height: -1)
        self.rankLabelIndicator!.shadowColor = UIColor.black
    }
    
    var device: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tabBarMenu.delegate = self
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.backgroundColor = assignCellBackgroundColor(indexPath: indexPath)
        cell.imageView.image = assignCellTschessElement(indexPath: indexPath)
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return cell
    }
    
    private func assignCellTschessElement(indexPath: IndexPath) -> UIImage? {
        //DANGER!!
        if(gameModel!.getState() != nil) {
            let tschessElementMatrix = gameModel!.getState()!
            let x = indexPath.row / 8
            let y = indexPath.row % 8
            if(tschessElementMatrix[x][y] != nil){
                return tschessElementMatrix[x][y]!.getImageVisible()
            }
        }
        return nil
    }
    
    private func assignCellBackgroundColor(indexPath: IndexPath) -> UIColor {
        if (indexPath.row % 2 == 0) {
            if ((indexPath.row / 8) % 2 == 0) {
                return UIColor.purple
            } else {
                return UIColor.brown
            }
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
        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewHeight.constant = collectionView.contentSize.height
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            self.presentingViewController!.dismiss(animated: false, completion: nil)
        }
    }
    
}
