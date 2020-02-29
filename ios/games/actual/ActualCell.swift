//
//  ActualCell.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class ActualCell: SwipeTableViewCell {
    
    @IBOutlet weak var soLaLa: UIView!
    @IBOutlet weak var timeIndicatorLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var actionImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var oddsIndicatorLabel: UILabel!
    @IBOutlet weak var oddsValueLabel: UILabel!
    
    @IBOutlet weak var dispImageView: UIImageView!
    @IBOutlet weak var dispAdjacentLabel: UILabel!
    
    @IBOutlet weak var dispValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
