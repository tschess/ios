//
//  HeaderSnapshot.swift
//  ios
//
//  Created by S. Matthew English on 11/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class HeaderSnapshot: UIView {
    
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var labelMoves: UILabel!
    @IBOutlet weak var labelWinner: UILabel!
    
    @IBOutlet weak var imageAvatar: UIImageView!
   
    public func set(game: EntityGame) {
        self.labelResult.text = game.condition
        self.labelMoves.text = String(game.moves)
        self.labelWinner.text = game.getUsernameWinner()
        
        self.imageAvatar!.image = game.getImageAvatarWinner()
        imageAvatar.layer.cornerRadius = imageAvatar.frame.size.width/2
        imageAvatar.clipsToBounds = true
    }
}
