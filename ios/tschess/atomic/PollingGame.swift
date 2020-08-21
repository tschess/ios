//
//  PollingGame.swift
//  ios
//
//  Created by S. Matthew English on 8/21/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class PollingGame {
    
    var timer: Timer?
    
    init() {
           
    }
       
    func setTimer() {
        guard self.timer == nil else {
            return
        }
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(pollingTask), userInfo: nil, repeats: true)
    }
       
    func endTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc func pollingTask() {
        let id_game: String = self.game!.id
        GameRequest().execute(id: id_game) { (game0) in
            if(game0 == nil){
                return
            }
            let updatedSv0: String = game0!.updated
            let updatedSv1: Date = self.dateTime.toFormatDate(string: updatedSv0)
            let updatedLc0: String = self.game!.updated
            let updatedLc1: Date = self.dateTime.toFormatDate(string: updatedLc0)
            switch updatedSv1.compare(updatedLc1) {
            case .orderedAscending:
                return
            case .orderedSame:
                return
            case .orderedDescending:
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    let game1 = game0!
                    self.setGame(game: game1)
                    let username: String = self.playerSelf!.username
                    let matrix1: [[Piece?]] = game1.getStateClient(username: username)
                    self.matrix = matrix1
                    
                    
                    // ~ * ~ //
                    self.setCheckMate()
                    // ~ * ~ //
                    
                    
                    self.viewBoard.reloadData()
                    self.setLabelEndgame()
                    
                    self.countdown!.setLabelCountdown(update: game1.updated, resolved: game1.isResolved())
                    
                    self.setLabelTurnary()
                    self.setLabelNotification()
                    self.setLabelCheck()
                }
            }
        }
    }
    
}
