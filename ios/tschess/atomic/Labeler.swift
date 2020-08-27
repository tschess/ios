//
//  Labeler.swift
//  ios
//
//  Created by S. Matthew English on 8/21/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Labeler {
    
    let labelNote: UILabel
    let labelTurn: UILabel
    let labelCount: UILabel
    let labelTitle: UILabel
    
    init(labelNote: UILabel, labelTurn: UILabel, labelCount: UILabel, labelTitle: UILabel) {
        self.labelNote = labelNote
        self.labelNote.isHidden = true
        self.labelTurn = labelTurn
        self.labelTurn.isHidden = true
        self.labelCount = labelCount
        self.labelTitle = labelTitle
    }
    
    
    
    /* * */
    var game: EntityGame?
    var player: EntityPlayer?
    /* * */
    func removePopper(game: EntityGame, player: EntityPlayer) {
        self.game = game
        self.player = player
    }
    /* * */
    
    
    
    private func setDraw(turnUser: String, turnFlag: Bool) {
        self.labelNote.isHidden = false
        self.labelNote.text = "🤞 proposal pending... ⏳"
        self.labelTurn.text = "\(turnUser) to respond"
        
        if(turnFlag){
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Evaluate", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Evaluate") as! Evaluate
                viewController.modalTransitionStyle = .crossDissolve
                viewController.playerSelf = self.player
                viewController.playerOther = self.game!.getPlayerOther(username: self.player!.username)
                viewController.gameTschess = self.game!
                
                if var viewControllerTop = UIApplication.shared.keyWindow?.rootViewController {
                    while let presentedViewController = viewController.presentedViewController {
                        viewControllerTop = presentedViewController
                    }
                    viewControllerTop.present(viewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func setTurn(resolved: Bool, turnUser: String) {
        if(resolved){
            return
        }
        if(self.labelTurn.isHidden){
            self.labelTurn.isHidden = false
        }
        self.labelTurn.text = "\(turnUser) to move"
    }
    
    func setNote(condition: String, resolved: Bool, turnUser: String, turnFlag: Bool) {
        if(resolved){
            return
        }
        //if(condition == "TBD"){
            //self.labelNote.isHidden = true
        //}
        if(condition == "PENDING"){
            self.setDraw(turnUser: turnUser, turnFlag: turnFlag)
            return
        }
        self.labelNote.isHidden = true
    }
    
    func setCheck(check: Bool) {
        if(!check){
            return
        }
        self.labelTurn.text = "\(self.labelTurn.text!) (✔️)"
    }
    
    func setResolve(resolved: Bool) {
        if(!resolved){
            return
        }
        self.labelTitle.text = "game over"
        self.labelCount.isHidden = true
        self.labelTurn.isHidden = true
        self.labelNote.isHidden = true
    }
    
}
