//
//  Snapshot.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Snapshot: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    var game: EntityGame?
    
    func setGame(game: EntityGame){
        self.game = game
    }
    
    @IBOutlet weak var titleBackView: UIView!
    @IBOutlet weak var titleBackImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    /* * */
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var winnerImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usernameLabelWhite: UILabel!
    @IBOutlet weak var usernameLabelBlack: UILabel!
    @IBOutlet weak var usernameWinner: UILabel!
    
    /* * */
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var boardViewHeight: NSLayoutConstraint!
    
    /* * */
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var statsImage: UIImageView!
    
    @IBOutlet weak var moveCountLabel: UILabel!
    @IBOutlet weak var outcomeLabel: UILabel!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var state: [[Piece?]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.isHidden = true
        self.boardView.isHidden = true
        
        self.state = self.game!.getStateClient(username: self.player!.username)
        self.winnerImageView!.image = self.game!.getImageAvatarWinner()
        
        self.outcomeLabel.text = self.game!.outcome
        self.usernameWinner.text = self.game!.winner
        self.usernameLabelWhite.text = self.game!.white.username
        self.usernameLabelBlack.text = self.game!.black.username
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        boardView.dataSource = self
        boardView.delegate = self
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
            //print("name: \(self.tschessElementMatrix![x][y]!.name)")
            return self.state![x][y]!.getImageVisible()
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
        boardView.isHidden = false
        boardView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        boardViewHeight.constant = boardView.contentSize.height
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            self.presentingViewController!.dismiss(animated: false, completion: nil)
        }
    }
    
}
