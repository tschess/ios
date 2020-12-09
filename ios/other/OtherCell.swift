//
//  OtherMenuCell.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class OtherCell: SwipeTableViewCell {
    
    func set(game: EntityGame, username: String) {
        let winner: Bool = game.getWinner(username: username)
    
        self.imageSlide.isHidden = false
        if(game.condition == "DRAW"){
            self.imageSlide.image = UIImage(named: "more_vert_yel")
            return
        }
        if(winner){
            self.imageSlide.image = UIImage(named: "more_vert_grn")
            return
        }
        self.imageSlide.image = UIImage(named: "more_vert_red")
    }
    
    @IBOutlet weak var imageSlide: UIImageView!
    //@IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    //@IBOutlet weak var dispLabelAdjacent: UILabel!
    //@IBOutlet weak var dispLabelAdjacent: UILabel!
    //@IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    //@IBOutlet weak var oddsLabel: UILabel!
    //@IBOutlet weak var terminalDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
