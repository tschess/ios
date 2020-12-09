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
    let labelTitle: UILabel?
    let labelCheck: UILabel
    
    init(labelCheck: UILabel, labelNote: UILabel, labelTurn: UILabel, labelCount: UILabel, labelTitle: UILabel? = nil) {
        self.labelCheck = labelCheck
        self.labelCheck.isHidden = true
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
                
                let alert = UIAlertController(title: "🧳 Draw proposal 👀 ", message: "\nOpponent has proposed a draw.", preferredStyle: .alert)
                
                
                let action0 = UIAlertAction(title: "Accept 👌", style: .default, handler: {_ in
                    //self.activityIndicatorAccept.isHidden = false
                    //self.activityIndicatorAccept.startAnimating()
                    let payload: [String: Any] = [
                        "id_game": self.game!.id,
                        "id_self": self.player!.id,
                        "accept": true
                    ]
                    UpdateEval().execute(requestPayload: payload) { (result) in
                        //DispatchQueue.main.async {
                            //self.activityIndicatorAccept!.stopAnimating()
                            //self.activityIndicatorAccept!.isHidden = true
                            //self.presentingViewController!.dismiss(animated: false, completion: nil)
                        //}
                    }
                })
                action0.setValue(UIColor.lightGray, forKey: "titleTextColor")
                alert.addAction(action0)
                
                let action1 = UIAlertAction(title: "Reject 🙅‍♀️", style: .default, handler: {_ in
                    //self.activityIndicatorAccept.isHidden = false
                    //self.activityIndicatorAccept.startAnimating()
                    let payload: [String: Any] = [
                        "id_game": self.game!.id,
                        "id_self": self.player!.id,
                        "accept": false
                    ]
                    UpdateEval().execute(requestPayload: payload) { (result) in
                        //DispatchQueue.main.async {
                            //self.activityIndicatorAccept!.stopAnimating()
                            //self.activityIndicatorAccept!.isHidden = true
                            //self.presentingViewController!.dismiss(animated: false, completion: nil)
                        //}
                    }
                })
                action1.setValue(UIColor.lightGray, forKey: "titleTextColor")
                alert.addAction(action1)
                
                //self.present(alert, animated: true)
                //let storyboard: UIStoryboard = UIStoryboard(name: "PopEval", bundle: nil)
                //let viewController = storyboard.instantiateViewController(withIdentifier: "PopEval") as! PopEval
                //viewController.modalTransitionStyle = .crossDissolve
                //viewController.playerSelf = self.player
                //viewController.playerOther = self.game!.getPlayerOther(username: self.player!.username)
                //viewController.gameTschess = self.game!
                
                if var viewControllerTop = UIApplication.shared.keyWindow?.rootViewController {
                    while let presentedViewController = alert.presentedViewController {
                        viewControllerTop = presentedViewController
                    }
                    viewControllerTop.present(alert, animated: true)
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
            self.labelCheck.isHidden = true
            return
        }
        self.labelCheck.isHidden = false
    }
    
    //func setResolve(resolved: Bool) {
    func setResolve(resolved: Bool, condition: String, winner: Bool) {
        if(!resolved){
            return
        }
        self.labelTitle!.text = "game over"
        self.labelCount.isHidden = true
        self.labelTurn.isHidden = true
        self.labelNote.isHidden = true
        /* * */
        /* * */
        /* * */
        //self.labelTitle.text = "game over"
        //self.labelCount.isHidden = true
        //self.labelTurn.isHidden = true
        //self.labelNote.isHidden = false
        //if(condition == "DRAW"){
            //self.labelNote.text = "😐 you draw. ✍️"
            //return
        //}
        //if(winner){
            //self.labelNote.text = "🙂 you win! 🎉"
            //return
        //}
        //self.labelNote.text = "🙃 you lost. 🤝"
    }
    
}
