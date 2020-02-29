//
//  Card.swift
//  ios
//
//  Created by Matthew on 2/28/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class CardActual: SwipeTableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var actionImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeIndicatorLabel: UILabel!
    
    class func instanceFromNib() -> CardActual {
        return UINib(nibName: "CardActual", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CardActual
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
