//
//  HistoricalGame.swift
//  ios
//
//  Created by Matthew on 10/22/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class EndgameSnapshot: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
    @IBOutlet weak var titleBackView: UIView!
    @IBOutlet weak var titleBackImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    /* * */
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImage: UIImageView!
    
    //@IBOutlet weak var infoViewWidth: NSLayoutConstraint!
    @IBOutlet weak var winnerImageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var usernameLabelWhite: UILabel!
    //@IBOutlet weak var usernameLabelWhite: UILabel!
    @IBOutlet weak var usernameLabelBlack: UILabel!
    //@IBOutlet weak var usernameLabelBlack: UILabel!
    @IBOutlet weak var usernameWinner: UILabel!
    //@IBOutlet weak var endgameCatalystLabel: UILabel!
    
    /* * */
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var collectionView: DynamicCollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!

    /* * */
    
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var statsImage: UIImageView!
    
    //@IBOutlet weak var moveCountLabel: UILabel!
    @IBOutlet weak var moveCountLabel: UILabel!
    //@IBOutlet weak var outcomeLabel: UILabel!
    @IBOutlet weak var outcomeLabel: UILabel!
    
    @IBOutlet weak var tabBarMenu: UITabBar!

    
    var gameModel: Game?
    
    public func setGameModel(gameModel: Game){
        self.gameModel = gameModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.isHidden = true
        self.collectionView.isHidden = true
        
        let winner = self.gameModel!.getWinner()
        self.usernameWinner.text = winner
        
        let opponent = self.gameModel!.getUsernameOpponent()
        
        if(winner == opponent){
            let dataDecoded: Data = Data(base64Encoded: self.gameModel!.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            self.winnerImageView!.image = decodedimage
        } else {
            let dataDecoded: Data = Data(base64Encoded: self.gameModel!.getAvatarSelf(), options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            self.winnerImageView!.image = decodedimage
        }
        
        let usernameWhite = self.gameModel!.getUsernameWhite()
        self.usernameLabelWhite.text = usernameWhite
        let usernameBlack = self.gameModel!.getUsernameBlack()
        self.usernameLabelBlack.text = usernameBlack
        
        self.outcomeLabel.text = self.gameModel!.getOutcome() //correct?
        
        //self.infoViewWidth.constant =
        //let totalHeaderWidth = self.headerView.frame.size.height
        //self.infoViewWidth.constant = totalHeaderWidth/2
    }
    
    //var device: String?
    
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
