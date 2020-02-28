//
//  Passant.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Passant {
    
    var white: Bool
    
    init(white: Bool){
        self.white = white
    }
    
    var transitioner: Transitioner?
    
    public func setTransitioner(transitioner: Transitioner) {
        self.transitioner = transitioner
    }
    
    var chess: Tschess?
    
    public func setChess(chess: Tschess) {
        self.chess = chess
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
        
        if(state1[coordinate![0]][coordinate![1]]!.name.contains("Pawn")) {
            
            if(!Pawn().advanceTwo(present: coordinate!, proposed: proposed, state: state1)){
                return false
            }
            if(coordinate![1] - 1 >= 0){
                let examinee = state1[4][coordinate![1] - 1]
                if(examinee != nil) {
                    if(examinee!.name.contains("Pawn")) {
                        if(examinee!.affiliation != affiliation){
                            state1[5][coordinate![1]] = examinee!
                            state1[4][coordinate![1] - 1] = nil
                            state1[coordinate![0]][coordinate![1]] = nil
                            
                            self.chess!.tschessElementMatrix = self.transitioner!.deselectHighlight(state0: self.chess!.tschessElementMatrix!)
                            let stateUpdate = SerializerState(white: white).renderServer(state: state1)
                            
                            let hx: Int = white ? proposed[0] : 7 - proposed[0]
                            let hy: Int = white ? proposed[1] : 7 - proposed[1]
                            let h0: Int = white ? coordinate![0] : 7 - coordinate![0]
                            let h1: Int = white ? coordinate![1] : 7 - coordinate![1]
                            let highlight: String = "\(hx)\(hy)\(h0)\(h1)"
                            
                            let requestPayload: [String: Any] = ["id_game": self.chess!.game!.id, "state": stateUpdate, "highlight": highlight, "condition": "TBD"]
                            DispatchQueue.main.async() {
                                self.chess!.activityIndicator.isHidden = false
                                self.chess!.activityIndicator.startAnimating()
                            }
                            GameUpdate().success(requestPayload: requestPayload) { (success) in
                                if(!success){
                                    //error
                                }
                                self.transitioner!.clearCoordinate()
                            }
                            
                            
                            return true
                        }
                    }
                }
            }
            if(coordinate![1] + 1 <= 7){
                let examinee = state1[4][coordinate![1] + 1]
                if(examinee != nil) {
                    if(examinee!.name.contains("Pawn")) {
                        if(examinee!.affiliation != affiliation){
                            state1[5][coordinate![1]] = examinee!
                            state1[4][coordinate![1] + 1] = nil
                            state1[coordinate![0]][coordinate![1]] = nil
                            
                            
                            self.chess!.tschessElementMatrix = self.transitioner!.deselectHighlight(state0: self.chess!.tschessElementMatrix!)
                            let stateUpdate = SerializerState(white: white).renderServer(state: state1)
                            
                            let hx: Int = white ? proposed[0] : 7 - proposed[0]
                            let hy: Int = white ? proposed[1] : 7 - proposed[1]
                            let h0: Int = white ? coordinate![0] : 7 - coordinate![0]
                            let h1: Int = white ? coordinate![1] : 7 - coordinate![1]
                            let highlight: String = "\(hx)\(hy)\(h0)\(h1)"
                            
                            let requestPayload: [String: Any] = ["id_game": self.chess!.game!.id, "state": stateUpdate, "highlight": highlight, "condition": "TBD"]
                            DispatchQueue.main.async() {
                                self.chess!.activityIndicator.isHidden = false
                                self.chess!.activityIndicator.startAnimating()
                            }
                            GameUpdate().success(requestPayload: requestPayload) { (success) in
                                if(!success){
                                    //error
                                }
                                self.transitioner!.clearCoordinate()
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
