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
    
    var swipeVisible: Bool = false
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        guard let cell = sender.view?.superview?.superview as? MenuCell else {
            return
        }
        if(!self.swipeVisible){
            cell.showSwipe(orientation: .right, animated: true)
            self.swipeVisible = true
            return
        }
        cell.hideSwipe(animated: true, completion: nil)
        self.swipeVisible = false
    }
    
    func setContent(usernameSelf: String, usernameOther: String, game: EntityGame, avatarImageOther: UIImage) {
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        self.labelSideSlide.addGestureRecognizer(pictureTap)
        self.labelSideSlide.isUserInteractionEnabled = true
            
        self.labelUsername.text = usernameOther
        self.imageViewAvatar.image = avatarImageOther
        if(game.status == "RESOLVED"){
            self.setHisto(game: game, username: usernameSelf)
            return
        }
        self.setActive()
        let inbound: Bool = game.getTurn(username: usernameSelf)
        if(game.status == "ONGOING"){
            self.labelSideSlide.isHidden = true
    
            if(inbound){
                let image: UIImage = UIImage(named: "turn.on")!
                self.imageViewAction.image = image
                self.labelAction.text = "action!"
                return
            }
            let image: UIImage = UIImage(named: "turn.off")!
            self.imageViewAction.image = image
            self.labelAction.text = "pending"
            return
        }
        if(game.status == "PROPOSED"){
            self.labelSideSlide.isHidden = false
            if(inbound){
                let image: UIImage = UIImage(named: "inbound")!
                self.imageViewAction.image = image
                self.labelAction.text = "challenge"
                return
            }
        }
        let image: UIImage = UIImage(named: "outbound")!
        self.imageViewAction.image = image
        self.labelAction.text = "outbound"
    }
    
    func setActive() {
        self.viewContent.backgroundColor = UIColor.white
        self.labelUsername.textColor = UIColor.black
        self.imageViewAction.isHidden = false
        self.labelSideSlide.image = UIImage(named: "more_vert_vfs")
    }
    
    func setHisto(game: EntityGame, username: String) {
        self.viewContent.backgroundColor = UIColor.black
        self.labelUsername.textColor = UIColor.lightGray
        self.imageViewAction.isHidden = true
        self.labelSideSlide.isHidden = false
        if(game.condition == "DRAW"){
            self.labelSideSlide.image = UIImage(named: "more_vert_yel")
            return
        }
        let winner: Bool = game.getWinner(username: username)
        if(winner){
            self.labelSideSlide.image = UIImage(named: "more_vert_grn")
            return
        }
        self.labelSideSlide.image = UIImage(named: "more_vert_red")
    }
}
