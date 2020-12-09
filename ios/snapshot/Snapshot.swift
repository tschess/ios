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
    
    var game: EntityGame?
    
    @IBOutlet weak var titleBackView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var usernameLabelWhite: UILabel!
    @IBOutlet weak var usernameLabelBlack: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var boardViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var statsView: UIView!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var state: [[Piece?]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarMenu.delegate = self
        
        self.state = self.game!.getStateClient(username: self.player!.username)
        
        self.boardView.delegate = self
        self.boardView.dataSource = self
        self.boardView.isHidden = true
        
        self.dateLabel.text = self.game!.getLabelTextDate()
     
        //TODO: Header
        let viewHeaderDynamic = Bundle.loadView(fromNib: "HeaderSnapshot", withType: HeaderSnapshot.self)
        self.viewHeader.addSubview(viewHeaderDynamic)
        viewHeaderDynamic.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: viewHeaderDynamic, attribute: $0, relatedBy: .equal, toItem: viewHeaderDynamic.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        viewHeaderDynamic.set(game: self.game!)
        
        
        
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
        if (indexPath.row % 2 == 0) {
            if ((indexPath.row / 8) % 2 == 0) {
                cell.backgroundColor = UIColor.white
            } else {
                cell.backgroundColor = UIColor.black
            }
            
        } else {
            if ((indexPath.row / 8) % 2 == 0) {
                cell.backgroundColor = UIColor.black
            } else {
                cell.backgroundColor = UIColor.white
            }
        }
        
        let x = indexPath.row / 8
        let y = indexPath.row % 8
        if(self.state![x][y] != nil){
            cell.imageView.image = self.state![x][y]!.getImageVisible()
        } else {
            cell.imageView.image = nil
        }
        cell.imageView.bounds = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        cell.imageView.center = CGPoint(x: cell.bounds.size.width/2, y: cell.bounds.size.height/2)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.boardView.reloadData()
        self.boardView.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.boardView.bounces = false
        self.boardView.alwaysBounceVertical = false
        self.boardViewHeight.constant = boardView.contentSize.height
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
}
