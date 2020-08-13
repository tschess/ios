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
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var imageViewAction: UIImageView!
    
    @IBOutlet weak var labelAction: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelSideSlide: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
