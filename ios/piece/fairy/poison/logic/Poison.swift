//
//  Poison.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Poison {
    
    public func detonate(coordinate: [Int], proposed: [Int], state: [[Piece?]]) -> Bool {
        //var tschessElementMatrix = gamestate.getTschessElementMatrix()
        let elementPresent: Piece? = state[coordinate[0]][coordinate[1]]
        if(elementPresent == nil){
            //print("A")
            return false
        }
        let elementPropose: Piece? = state[proposed[0]][proposed[1]]
        if(elementPropose == nil){
            //print("B")
            return false
        }
        if(!(elementPropose!.name.contains("Poison") && elementPropose!.isTarget)){
            //print("D")
            return false
        }
        if(Processor().validateElement(candidate: elementPropose)){
            if(elementPresent!.name.contains("King")){
//                if(gamestate.getOrientationBlack()){
//                    tschessElementMatrix[proposed[0]][proposed[1]] = WhiteReveal()
//                } else {
//                    tschessElementMatrix[proposed[0]][proposed[1]] = BlackReveal()
//                }
                state[coordinate[0]][coordinate[1]]!.setImageVisible(imageVisible: elementPresent!.imageDefault)
//                gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
//                gamestate.setWinner(winner: gamestate.getUsernameOpponent())
                //let requestUpdate = GamestateSerializer().execute(gamestate: gamestate)
                //UpdateGamestate().execute(requestPayload: requestUpdate)
                return true
            }
//            state[coordinate[0]][coordinate[1]] = nil
//            state[proposed[0]][proposed[1]] = nil
//            gamestate.setHighlight(coords: [proposed[0],proposed[1],coordinate[0],coordinate[1]])
//            gamestate.setDrawProposer(drawProposer: "LANDMINE")
//            gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
            //let requestUpdate = GamestateSerializer().execute(gamestate: gamestate)
            //UpdateGamestate().execute(requestPayload: requestUpdate)
            return true
        }
        //print("E")
        return false
    }
    
}
