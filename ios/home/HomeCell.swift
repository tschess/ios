//
//  HomeMenuCell.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class HomeCell: SwipeTableViewCell {
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var labelIndicator: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    
    @IBOutlet weak var viewAction: UIView!
    @IBOutlet weak var labelAction: UILabel!
    @IBOutlet weak var imageAction: UIImageView!
    
    @IBOutlet weak var imageSlide: UIImageView!
    
    //MARK: Properties
    var isSideSlide: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        guard let cell = sender.view?.superview?.superview as? HomeCell else {
            return
        }
        if(!self.isSideSlide){
            cell.showSwipe(orientation: .right, animated: true)
            self.isSideSlide = true
            return
        }
        cell.hideSwipe(animated: true, completion: nil)
        self.isSideSlide = false
    }
    
    func setContent(usernameSelf: String, usernameOther: String, game: EntityGame, avatarImageOther: UIImage) {
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        self.imageSlide.addGestureRecognizer(pictureTap)
        self.imageSlide.isUserInteractionEnabled = true
        
        self.labelUsername.text = usernameOther
        self.imageAvatar.image = avatarImageOther
        imageAvatar.layer.cornerRadius = imageAvatar.frame.size.width/2
        imageAvatar.clipsToBounds = true
        
        if(game.isResolved()){
            self.setHisto(game: game, username: usernameSelf)
            return
        }
        self.setActive()
        let inbound: Bool = game.getTurnFlag(username: usernameSelf)
        if(game.status == "ONGOING"){
            self.imageSlide.isHidden = true
            if(inbound){
                self.labelIndicator.text = "⭐"
                let image: UIImage = UIImage(named: "turn.on")!
                self.imageAction.image = image
                self.labelAction.text = "game"
                return
            }
            self.labelIndicator.text = "⌛"
            let image: UIImage = UIImage(named: "turn.off")!
            self.imageAction.image = image
            self.labelAction.text = "game"
            return
        }
        if(game.status == "PROPOSED"){
            self.imageSlide.isHidden = false
            if(inbound){
                self.labelIndicator.text = "⭐"
                let image: UIImage = UIImage(named: "inbound")!
                self.imageAction.image = image
                self.labelAction.text = "invite"
                return
            }
        }
        self.labelIndicator.text = "⌛"
        let image: UIImage = UIImage(named: "outbound")!
        self.imageAction.image = image
        self.labelAction.text = "invite"
    }
    
    func setActive() {
        self.labelIndicator.isHidden = false
        
        self.labelAction.isHidden = false
        self.viewAction.isHidden = false
       
        self.viewContent.backgroundColor = UIColor.white
        self.labelUsername.textColor = UIColor.black
        self.imageAction.isHidden = false
        self.imageSlide.image = UIImage(named: "more_vert_vfs")
    }
    
    func setHisto(game: EntityGame, username: String) {
        let winner: Bool = game.getWinner(username: username)
    
        self.viewAction.isHidden = true
        self.labelIndicator.isHidden = true
        
        self.viewContent.backgroundColor = UIColor.black
        self.labelUsername.textColor = UIColor.lightGray
        self.imageAction.isHidden = true
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
    
   
}
