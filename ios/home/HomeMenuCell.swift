//
//  HomeMenuCell.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class MenuCellHome: SwipeTableViewCell {
    
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var labelIndicator: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    
    @IBOutlet weak var viewAction: UIView!
    @IBOutlet weak var labelAction: UILabel!
    @IBOutlet weak var imageAction: UIImageView!
    
    @IBOutlet weak var imageSlide: UIImageView!
    
    public func set(player: EntityPlayer) {
        
        self.labelUsername.text = player.username
        
        self.imageAvatar.image = player.getImageAvatar()
        imageAvatar.layer.cornerRadius = imageAvatar.frame.size.width/2
        imageAvatar.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
