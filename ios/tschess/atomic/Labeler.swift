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
    
    //let turn = self.game!.getTurn()
    private func setDraw(turnUser: String, turnFlag: Bool) {
        self.labelNote.isHidden = false
        self.labelNote.text = "proposal pending"
        self.labelTurn.text = "\(turnUser) to respond"
        
        //let username: String = self.player!.username
        if(turnFlag){
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Evaluate", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Evaluate") as! Evaluate
                viewController.modalTransitionStyle = .crossDissolve
                viewController.playerSelf = self.player
                viewController.playerOther = self.game!.getPlayerOther(username: self.player!.username)
                viewController.gameTschess = self.game!
            
                //self.present(viewController, animated: true, completion: nil)
                
                if var viewControllerTop = UIApplication.shared.keyWindow?.rootViewController {
                    while let presentedViewController = viewController.presentedViewController {
                        viewControllerTop = presentedViewController
                    }
                    viewControllerTop.present(viewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    //let turn = self.game!.getTurn()
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
    
    //let resolved: Bool = self.game!.status == "RESOLVED"
    //let username: String = self.playerSelf!.username
    //self.game!.getWinner(username: username)
    func setResolve(condition: String, resolved: Bool, winner: Bool) {
        if(!resolved){
            return
        }
        self.labelTitle.text = "game over"
        self.labelCount.isHidden = true
        self.labelTurn.isHidden = true
        self.menuRefresh()
        self.labelNote.isHidden = false
        if(condition == "DRAW"){
            self.labelNote.text = "draw"
            return
        }
        if(winner){
            self.labelNote.text = "winner"
            return
        }
        self.labelNote.text = "you lose"
    }
    
    //TODO: ought not be here...
    func menuRefresh() {
        DispatchQueue.main.async {
            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                let viewControllers = navigationController.viewControllers
                for vc in viewControllers {
                    if vc.isKind(of: Menu.classForCoder()) {
                        let menu: Menu = vc as! Menu
                        menu.menuTable!.refresh(refreshControl: nil)
                    }
                }
                
            }
        }
    }
    
}
