//
//  Explode.swift
//  ios
//
//  Created by Matthew on 2/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Landmine {
    
    var tschess: Tschess
    
    let game_id: String
    let white: Bool
  
    var transitioner: Transitioner
    var activityIndicator: UIActivityIndicatorView
    
    init(game_id: String, white: Bool, transitioner: Transitioner, activityIndicator: UIActivityIndicatorView, tschess: Tschess) {
        self.game_id = game_id
        self.white = white
        self.transitioner = transitioner
        self.activityIndicator = activityIndicator
        self.tschess = tschess
    }
    
    public func evaluate(coordinate: [Int]?, proposed: [Int], state0: [[Piece?]]) -> Bool {
        if(coordinate == nil){
            return false
        }
        let elementAttacker: Piece? = state0[coordinate![0]][coordinate![1]]
        if(elementAttacker == nil){
            return false
        }
        let elementAttacked: Piece? = state0[proposed[0]][proposed[1]]
        if(elementAttacked == nil){
            return false
        }
        if(!(elementAttacked!.name.contains("Poison") && elementAttacked!.isTarget)){
            return false
        }
        //they are attacking a poison pawn...
        var stateX: [[Piece?]] = self.transitioner.deselectHighlight(state0: state0)
        
        if(elementAttacker!.name.contains("King")){
            if(!self.white){
                stateX[proposed[0]][proposed[1]] = RevealWhite()
            } else {
                stateX[proposed[0]][proposed[1]] = RevealBlack()
            }
            /**
             GTFO...
             */
            let stateUpdate: [[String]] = SerializerState(white: self.white).renderServer(state: stateX)
            let requestPayload: [String: Any] = ["id_game": self.game_id, "state": stateUpdate]
            DispatchQueue.main.async() {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }
            UpdateMine().success(requestPayload: requestPayload) { (success) in
                if(!success){
                    //error
                }
                self.transitioner.clearCoordinate()
            }
            self.tschess.renderDialogPoison()
            return true
        }
        
        stateX[proposed[0]][proposed[1]] = nil
        stateX[coordinate![0]][coordinate![1]] = nil
        let stateUpdate: [[String]] = SerializerState(white: self.white).renderServer(state: stateX)
        
        let hx: Int = self.white ? proposed[0] : 7 - proposed[0]
        let hy: Int = self.white ? proposed[1] : 7 - proposed[1]
        let h0: Int = self.white ? coordinate![0] : 7 - coordinate![0]
        let h1: Int = self.white ? coordinate![1] : 7 - coordinate![1]
        let highlight: String = "\(hx)\(hy)\(h0)\(h1)"
        
        let requestPayload: [String: Any] = ["id_game": self.game_id, "state": stateUpdate, "highlight": highlight, "condition": "LANDMINE"]
        DispatchQueue.main.async() {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        GameUpdate().success(requestPayload: requestPayload) { (success) in
            if(!success){
                //error
            }
            self.transitioner.clearCoordinate()
        }
        self.tschess.renderDialogPoison()
        return true
    }
    
}
