//
//  Card.swift
//  ios
//
//  Created by Matthew on 2/28/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class GameCard: SwipeTableViewCell {
   
    
//    @IBOutlet weak var avatarImageView: UIImageView!
//    @IBOutlet weak var actionImageView: UIImageView!
//    @IBOutlet weak var usernameLabel: UILabel!
//    @IBOutlet weak var timeIndicatorLabel: UILabel!
    
    
//    @IBOutlet weak var avatarImageView: UIImageView!
//    @IBOutlet weak var terminalDateLabel: UILabel!
//    @IBOutlet weak var oddsLabel: UILabel!
//    @IBOutlet weak var usernameLabel: UILabel!
//    @IBOutlet weak var displacementImage: UIImageView!
//    @IBOutlet weak var displacementLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func instanceFromNib() -> GameCard {
        return UINib(nibName: "GameCard", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! GameCard
    }
    
}
