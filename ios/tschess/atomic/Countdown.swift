//
//  Countdown.swift
//  ios
//
//  Created by S. Matthew English on 8/21/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Countdown {
    
    var timerCountdown: Timer?
    
    let label: UILabel
    let date: DateTime
    let id: String
    
    init(label: UILabel, date: DateTime, id: String) {
        self.id = id
        self.date = date
        self.label = label
        self.setFont()
    }
    
    func setTimer() {
        guard self.timerCountdown == nil else {
            
            print("G - 0")
            
            return
        }
        
        print("G - X")
        
        self.timerCountdown = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decCountdown), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        self.timerCountdown?.invalidate()
        self.timerCountdown = nil
    }
    
    @objc func decCountdown() {
        
        print("G - 1313")
        
           var interval0: Double = 0
           let componentValueSet = self.label.text!.components(separatedBy: ":")
           for (index, component) in componentValueSet.reversed().enumerated() {
               interval0 += (Double(component) ?? 0) * pow(Double(60), Double(index))
           }
           let interval1: TimeInterval = interval0 - TimeInterval(1.0)
        //DispatchQueue.main.async {
           self.label.text = self.formatString(interval: interval1)
        //}
       }
    
    private func formatString(interval: TimeInterval) -> String {
        let sec = Int(interval.truncatingRemainder(dividingBy: 60))
        let min = Int(interval.truncatingRemainder(dividingBy: 3600) / 60)
        let hour = Int(interval / 3600)
        let timeout: Bool = hour < 1 && min < 1 && sec < 1
        if (timeout) {
            
            print("G - T0")
            
            self.timeout()
            return "00:00:00"
        }
        //DispatchQueue.main.async {
        if(self.label.isHidden){
            self.label.isHidden = false
        }
        //}
        return String(format: "%02d:%02d:%02d", hour, min, sec)
    }
    
    //let resolved: Bool = self.game!.status == "RESOLVED"
    func setLabelCountdown(update: String) {
        //if(self.game.isResolved()){
            //return
        //}
        
        print("G - update: \(update)")
        
        let dateUpdate: Date = self.date.toFormatDate(string: update)
        let dateActual: Date = self.date.currentDate()
        let intervalDifference: TimeInterval = dateActual.timeIntervalSince(dateUpdate)
        let intervalStandard: TimeInterval = Double(24) * 60 * 60
        let timeRemaining: TimeInterval = intervalStandard - intervalDifference
        //DispatchQueue.main.async {
        self.label.text = self.formatString(interval: timeRemaining)
        //}
    }
    
    private func timeout() {
        GetTimeout().success(id_game: self.id) { (result) in
            // TODO: handle...
        }
    }
    
    private func setFont() {
        guard #available(iOS 13, *) else {
            return
        }
        let height: CGFloat = UIScreen.main.bounds.height
        if(height.isLess(than: 750)){
            self.label.font = UIFont.monospacedSystemFont(ofSize: 19.0, weight: .light)
            return
        }
        self.label.font = UIFont.monospacedSystemFont(ofSize: 22.0, weight: .light)
    }
    
}
