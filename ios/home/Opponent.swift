//
//  Opponent.swift
//  ios
//
//  Created by S. Matthew English on 11/23/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Opponent: UIView {
    
    @IBOutlet weak var viewHolder00: UIView!
    @IBOutlet weak var viewHolder01: UIView!
    @IBOutlet weak var viewHolder02: UIView!
    //    @IBOutlet weak var labelRank: UILabel!
    //    @IBOutlet weak var labelRating: UILabel!
    //    @IBOutlet weak var labelUsername: UILabel!
    //
    //    @IBOutlet weak var imageDisplacementRank: UIImageView!
    //
    //    @IBOutlet weak var imageAvatar: UIImageView!
    //
    @IBOutlet weak var viewHolder00width: NSLayoutConstraint!
    @IBOutlet weak var viewHolder01width: NSLayoutConstraint!
    @IBOutlet weak var viewHolder02width: NSLayoutConstraint!

    //    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!

    
    //public func set(player: EntityPlayer) {
    public func set() {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        self.viewHolder00width.constant = screenWidth/3
        self.viewHolder01width.constant = screenWidth/3
        self.viewHolder02width.constant = screenWidth/3
        
        //self.configCollectionViewHeight0.constant = self.configCollectionView0.contentSize.height
        //self.configCollectionViewHeight1.constant = self.configCollectionView1.contentSize.height
        //self.configCollectionViewHeight2.constant = self.configCollectionView2.contentSize.height
        
        //        self.labelUsername.text = player.username
        //        self.labelRating.text = player.getLabelTextElo()
        //        self.labelRank.text = player.getLabelTextRank()
        //
        //        self.imageDisplacementRank.image = player.getImageDisp()!
        //        self.imageDisplacementRank.tintColor = player.tintColor
        //
        //        self.imageAvatar.image = player.getImageAvatar()
        //        imageAvatar.layer.cornerRadius = imageAvatar.frame.size.width/2
        //        imageAvatar.clipsToBounds = true
        
        
    }
    
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //    }
    
    
}
