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
    
    //var promptConfirm: Bool = false // 2 identical -- consolidate this...
    
    //MARK: Properties
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAction: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var imageViewAction: UIImageView!
    @IBOutlet weak var imageViewSideSlide: UIImageView!
    
    //MARK: Properties
    var isSideSlide: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        guard let cell = sender.view?.superview?.superview as? MenuCell else {
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
        self.imageViewSideSlide.addGestureRecognizer(pictureTap)
        self.imageViewSideSlide.isUserInteractionEnabled = true
            
        self.labelName.text = usernameOther
        self.imageViewAvatar.image = avatarImageOther
        if(game.status == "RESOLVED"){
            self.setHisto(game: game, username: usernameSelf)
            return
        }
        self.setActive()
        let inbound: Bool = game.getTurnFlag(username: usernameSelf)
        if(game.status == "ONGOING"){
            self.imageViewSideSlide.isHidden = true
    
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
            self.imageViewSideSlide.isHidden = false
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
        self.labelAction.isHidden = false
        self.viewContent.backgroundColor = UIColor.white
        self.labelName.textColor = UIColor.black
        self.imageViewAction.isHidden = false
        self.imageViewSideSlide.image = UIImage(named: "more_vert_vfs")
    }
    
    func setHisto(game: EntityGame, username: String) {
        let winner: Bool = game.getWinner(username: username)
        let confirm: String? = game.confirm
        if(confirm == nil) {
            self.setConfirm(winner: winner, condition: game.condition)
            return
        } //not yet confirmed...
        
        let white: Bool = game.getWhite(username: username)
        if(white){ // you are white...
            if(confirm!.contains("WHITE")) {
                self.getConfirm(game: game)
                return
            }
            self.setConfirm(winner: winner, condition: game.condition)
            return
        }  // you aren't white...
        if(confirm!.contains("BLACK")) {
            self.getConfirm(game: game)
            return
        }
        self.setConfirm(winner: winner, condition: game.condition)
    }
    
    func getConfirm(game: EntityGame) {
        game.promptConfirm = true
        self.viewContent.backgroundColor = UIColor.white
        self.labelName.textColor = UIColor.black
        self.imageViewAction.isHidden = true
        self.imageViewSideSlide.isHidden = true
        self.labelAction.isHidden = true
    }
    
    func setConfirm(winner: Bool, condition: String) {
        self.labelAction.isHidden = false
        self.viewContent.backgroundColor = UIColor.black
        self.labelName.textColor = UIColor.lightGray
        self.imageViewAction.isHidden = true
        self.imageViewSideSlide.isHidden = false
        if(condition == "DRAW"){
        //if(game.condition == "DRAW"){
            self.imageViewSideSlide.image = UIImage(named: "more_vert_yel")
            return
        }
        //let winner: Bool = game.getWinner(username: username)
        if(winner){
            self.imageViewSideSlide.image = UIImage(named: "more_vert_grn")
            return
        }
        self.imageViewSideSlide.image = UIImage(named: "more_vert_red")
    }
}
