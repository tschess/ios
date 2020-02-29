//
//  Card.swift
//  ios
//
//  Created by Matthew on 2/28/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class Card: SwipeTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func instanceFromNib() -> Card {
        return UINib(nibName: "Card", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Card
    }
    
}
