//
//  Countdown.swift
//  ios
//
//  Created by S. Matthew English on 8/21/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Countdown {
    
    let label: UILabel
    //let game: EntityGame
    let date: DateTime
    
    init(label: UILabel, date: DateTime) {
        self.label = label
        //self.game = game
        self.date = date
    }
    
    //let resolved: Bool = self.game!.status == "RESOLVED"
    private func setLabelCountdown(update: String) {
        //if(self.game.isResolved()){
            //return
        //}
        let dateUpdate: Date = self.date.toFormatDate(string: update)
        let dateActual: Date = self.date.currentDate()
        let intervalDifference: TimeInterval = dateActual.timeIntervalSince(dateUpdate)
        let intervalStandard: TimeInterval = Double(24) * 60 * 60
        let timeRemaining: TimeInterval = intervalStandard - intervalDifference
        self.label.text = self.formatString(interval: timeRemaining)
    }
    
    private func formatString(interval: TimeInterval) -> String {
        let sec = Int(interval.truncatingRemainder(dividingBy: 60))
        let min = Int(interval.truncatingRemainder(dividingBy: 3600) / 60)
        let hour = Int(interval / 3600)
        let timeout: Bool = hour < 1 && min < 1 && sec < 1
        if (timeout) {
            self.timeout()
            return "00:00:00"
        }
        if(self.label.isHidden){
            self.label.isHidden = false
        }
        return String(format: "%02d:%02d:%02d", hour, min, sec)
    }
    
    private func timeout() {
        let id_game: String = self.game.id
        UpdateTimeout().success(id_game: id_game) { (result) in
            // TODO: handle...
        }
    }
    
    @objc func decCountdown() {
        var interval0: Double = 0
        let componentValueSet = self.label.text!.components(separatedBy: ":")
        for (index, component) in componentValueSet.reversed().enumerated() {
            interval0 += (Double(component) ?? 0) * pow(Double(60), Double(index))
        }
        let interval1: TimeInterval = interval0 - TimeInterval(1.0)
        self.label.text = self.formatString(interval: interval1)
    }
    
}
