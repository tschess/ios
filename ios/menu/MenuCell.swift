//
//  ActualCell.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class MenuCell: SwipeTableViewCell {
    
    @IBOutlet weak var soLaLa: UIView!
    
    @IBOutlet weak var labelAction: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var actionImageView: UIImageView!
   
    @IBOutlet weak var usernameLabel: UILabel!
    
    //@IBOutlet weak var labelSideSlide: UIImageView!
    @IBOutlet weak var labelSideSlide: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
