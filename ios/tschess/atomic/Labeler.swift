//
//  Labeler.swift
//  ios
//
//  Created by S. Matthew English on 8/21/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Labeler {
    
    private func drawProposal() {
        let resolved: Bool = self.game!.status == "RESOLVED"
        if(resolved){
            return
        }
        self.labelNotification.isHidden = false
        self.labelNotification.text = "proposal pending"
        let turn = self.game!.getTurn()
        self.labelTurnary.text = "\(turn) to respond"
        
        let username: String = self.playerSelf!.username
        if(self.game!.getTurn(username: username)){
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Evaluate", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Evaluate") as! Evaluate
                viewController.modalTransitionStyle = .crossDissolve
                viewController.setPlayerSelf(playerSelf: self.playerSelf!)
                viewController.setPlayerOther(playerOther: self.game!.getPlayerOther(username: self.playerSelf!.username))
                viewController.setGameTschess(gameTschess: self.game!)
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: LABEL RENDER FUNC
    private func setLabelTurnary() {
        let resolved: Bool = self.game!.status == "RESOLVED"
        if(resolved){
            return
        }
        if(self.labelTurnary.isHidden){
            self.labelTurnary.isHidden = false
        }
        let turn = self.game!.getTurn()
        self.labelTurnary.text = "\(turn) to move"
    }
    
    private func setLabelNotification() {
        if(self.game!.condition == "TBD"){
            self.labelNotification.isHidden = true
        }
        if(self.game!.condition == "PENDING"){
            self.drawProposal()
        }
    }
    
    private func setLabelCheck() {
        let check: Bool = self.game!.on_check
        if(!check){
            return
        }
        self.labelTurnary.text = "\(self.labelTurnary.text!) (check)"
    }
    
    func setLabelEndgame() {
        let resolved: Bool = self.game!.status == "RESOLVED"
        if(!resolved){
            return
        }
        DispatchQueue.main.async {
            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                let viewControllers = navigationController.viewControllers
                for vc in viewControllers {
                    if vc.isKind(of: Menu.classForCoder()) {
                        //print("It is in stack")
                        let menu: Menu = vc as! Menu
                        menu.menuTable!.refresh(refreshControl: nil)
                    }
                }
                
            }
        }
        self.labelTitle.text = "game over"
        
        self.endTimer()
        self.countdown!.endTimer()
        
        self.labelNotification.isHidden = false
        self.labelCountdown.isHidden = true
        self.labelTurnary.isHidden = true
        if(self.game!.condition == "DRAW"){
            self.labelNotification.text = "draw"
            return
        }
        let username: String = self.playerSelf!.username
        if(self.game!.getWinner(username: username)){
            self.labelNotification.text = "winner"
            return
        }
        self.labelNotification.text = "you lose"
    }
    
}
