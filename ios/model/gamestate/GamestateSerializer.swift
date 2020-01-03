//
//  GamestateSerializer.swift
//  ios
//
//  Created by Matthew on 11/8/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class GamestateSerializer {
    
    func execute(gamestate: Gamestate, updated: String = DateTime().currentDateString()) -> [String: Any] {
       
        let identifier = gamestate.getIdentifier()
        let username_turn = gamestate.getUsernameTurn()
        
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let orientationBlack = gamestate.getOrientationBlack()
        
        let stringMatrix = MatrixSerializer().serialize(elementRepresentation: tschessElementMatrix, orientationBlack: orientationBlack)
        
        let last_move_white = gamestate.getLastMoveWhite()
        let last_move_black = gamestate.getLastMoveBlack()
        
        let highlightGamestate = gamestate.getHighlight()
        var highlight = "NONE"
        if(highlightGamestate != nil){
            var cumulator: String = ""
            for coord in highlightGamestate! {
                for i in coord {
                    cumulator.append(String(i))
                }
            }
            highlight = cumulator
        }
        
        let requestPayload = [
            "id": identifier,
            "state": stringMatrix,
            "highlight": highlight,
            
            "white_update": last_move_white,
            "black_update": last_move_black,
            
            "check_on": gamestate.getCheckOn(),
            "turn": username_turn,
            "winner": gamestate.getWinner(),
            
            "catalyst": gamestate.getDrawProposer(),
            "updated": updated,
            
            "notification_id": gamestate.getOpponentId(),
            "notification_name": gamestate.getSelfName()
            
            ] as [String : Any]
        return requestPayload
    }
    
}
