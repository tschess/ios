//
//  Passant.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Passant {
    
    let white: Bool
    let transitioner: Transitioner
    var tschess: Tschess
    
    init(white: Bool, transitioner: Transitioner, tschess: Tschess){
        self.white = white
        self.transitioner = transitioner
        self.tschess = tschess
    }
    
    public func evaluate(coordinate: [Int]?, proposed: [Int], state0: [[Piece?]]) -> Bool {
        if(coordinate == nil){
            return false
        }
        var state1 = state0
        
        let tschessElement = state1[coordinate![0]][coordinate![1]]
        if(tschessElement == nil){
            return false
        }
        let affiliation = state1[coordinate![0]][coordinate![1]]!.affiliation
        
        let pawn0: Bool = state1[coordinate![0]][coordinate![1]]!.name.contains("Pawn") ||
                          state1[coordinate![0]][coordinate![1]]!.name.contains("Poison")
        if(pawn0) {
            
            if(!Pawn().advanceTwo(present: coordinate!, proposed: proposed, state: state1)){
                return false
            }
            if(coordinate![1] - 1 >= 0){
                let examinee = state1[4][coordinate![1] - 1]
                if(examinee != nil) {
                    
                    let pawn1: Bool = examinee!.name.contains("Pawn") ||
                                      examinee!.name.contains("Poison")
                    
                    if(pawn1) {
                        if(examinee!.affiliation != affiliation){
                            state1[5][coordinate![1]] = examinee!
                            state1[4][coordinate![1] - 1] = nil
                            state1[coordinate![0]][coordinate![1]] = nil
                            
                            self.tschess.matrix = self.transitioner.deselectHighlight(state0: self.tschess.matrix!)
                            let stateUpdate = SerializerState(white: self.white).renderServer(state: state1)
                            
                            let hx: Int = self.white ? 5 : 7 - 5
                            let hy: Int = self.white ? coordinate![1] : 7 - coordinate![1]
                            let h0: Int = self.white ? coordinate![0] : 7 - coordinate![0]
                            let h1: Int = self.white ? coordinate![1] : 7 - coordinate![1]
                            let highlight: String = "\(hx)\(hy)\(h0)\(h1)"
                            
                            let requestPayload: [String: Any] = ["id_game": self.tschess.game!.id, "state": stateUpdate, "highlight": highlight, "condition": "TBD"]
                            DispatchQueue.main.async() {
                                self.tschess.activityIndicator.isHidden = false
                                self.tschess.activityIndicator.startAnimating()
                            }
                            GameUpdate().success(requestPayload: requestPayload) { (success) in
                                if(!success){
                                    //error
                                }
                                self.transitioner.clearCoordinate()
                            }
                            
                            
                            return true
                        }
                    }
                }
            }
            if(coordinate![1] + 1 <= 7){
                let examinee = state1[4][coordinate![1] + 1]
                if(examinee != nil) {
                   
                    let pawn1: Bool = examinee!.name.contains("Pawn") ||
                                      examinee!.name.contains("Poison")
                    
                    if(pawn1) {
                        if(examinee!.affiliation != affiliation){
                            state1[5][coordinate![1]] = examinee!
                            state1[4][coordinate![1] + 1] = nil
                            state1[coordinate![0]][coordinate![1]] = nil
                            
                            
                            self.tschess.matrix = self.transitioner.deselectHighlight(state0: self.tschess.matrix!)
                            let stateUpdate = SerializerState(white: self.white).renderServer(state: state1)
                            
                            let hx: Int = self.white ? 5 : 7 - 5
                            let hy: Int = self.white ? coordinate![1] : 7 - coordinate![1]
                            let h0: Int = self.white ? coordinate![0] : 7 - coordinate![0]
                            let h1: Int = self.white ? coordinate![1] : 7 - coordinate![1]
                            let highlight: String = "\(hx)\(hy)\(h0)\(h1)"
                            
                            let requestPayload: [String: Any] = ["id_game": self.tschess.game!.id, "state": stateUpdate, "highlight": highlight, "condition": "TBD"]
                            DispatchQueue.main.async() {
                                self.tschess.activityIndicator.isHidden = false
                                self.tschess.activityIndicator.startAnimating()
                            }
                            GameUpdate().success(requestPayload: requestPayload) { (success) in
                                if(!success){
                                    //error
                                }
                                self.transitioner.clearCoordinate()
                            }
                            
                            
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
}
