//
//  LandminePawn.swift
//  ios
//
//  Created by Matthew on 12/6/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Landmine {
    
    public func detonate(coordinate: [Int], proposed: [Int], gamestate: Gamestate) -> Bool {
        var tschessElementMatrix = gamestate.getTschessElementMatrix()
        let elementPresent: TschessElement? = tschessElementMatrix[coordinate[0]][coordinate[1]]
        if(elementPresent == nil){
            //print("A")
            return false
        }
        let elementPropose: TschessElement? = tschessElementMatrix[proposed[0]][proposed[1]]
        if(elementPropose == nil){
            //print("B")
            return false
        }
        if(!(elementPropose!.name.contains("Landmine") && elementPropose!.isTarget)){
            //print("D")
            return false
        }
        if(Processor().validateElement(candidate: elementPropose)){
            if(elementPresent!.name.contains("King")){
                if(gamestate.getOrientationBlack()){
                    tschessElementMatrix[proposed[0]][proposed[1]] = WhiteReveal()
                } else {
                    tschessElementMatrix[proposed[0]][proposed[1]] = BlackReveal()
                }
                tschessElementMatrix[coordinate[0]][coordinate[1]]!.setImageVisible(imageVisible: elementPresent!.imageDefault)
                gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
                gamestate.setWinner(winner: gamestate.getUsernameOpponent())
                //let requestUpdate = GamestateSerializer().execute(gamestate: gamestate)
                //UpdateGamestate().execute(requestPayload: requestUpdate)
                return true
            }
            tschessElementMatrix[coordinate[0]][coordinate[1]] = nil
            tschessElementMatrix[proposed[0]][proposed[1]] = nil
            gamestate.setHighlight(coords: [proposed[0],proposed[1],coordinate[0],coordinate[1]])
            gamestate.setDrawProposer(drawProposer: "LANDMINE")
            gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
            //let requestUpdate = GamestateSerializer().execute(gamestate: gamestate)
            //UpdateGamestate().execute(requestPayload: requestUpdate)
            return true
        }
        //print("E")
        return false
    }
    
}
