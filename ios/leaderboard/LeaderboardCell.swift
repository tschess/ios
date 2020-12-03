//
//  LeaderboardCell.swift
//  ios
//
//  Created by S. Matthew English on 12/3/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class LeaderboardCell: SwipeTableViewCell {
    
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    //@IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dispImage: UIImageView!
    //@IBOutlet weak var dispLabel: UILabel!
    //@IBOutlet weak var dispLabelAlign: UILabel!
    
    @IBOutlet weak var buttonSideSlide: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
