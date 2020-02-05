//
//  CheckMate.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class CheckMate {
    
    func mate(king: [Int], gamestate: Gamestate) -> Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let kingElement = tschessElementMatrix[king[0]][king[1]]!
        var listValidateKing = Array<[Int]>()
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                if(kingElement.validate(present: king, proposed: [i,j], gamestate: gamestate)){
                    listValidateKing.append([i,j])
                }
            }
        }
        let listOpponent = CanonicalCheck().listOpponent(king: king, gamestate: gamestate)
        
        var listValidateKingOpponent = Array<[Int]>()
        for move in listValidateKing {
            for opponent in listOpponent {
                let opponentElement = tschessElementMatrix[opponent[0]][opponent[1]]!
                if(opponentElement.validate(present: opponent, proposed: move, gamestate: gamestate)) {
                    listValidateKingOpponent.append(move)
                }
            }
        }
        let listKingMove = listValidateKing.filter {!listValidateKingOpponent.contains($0)}
        
        if(listKingMove.count > 0){
            return false
        }
        let listAttacker = self.listAttacker(king: king, gamestate: gamestate)
        if(listAttacker.count > 1){
            return true
        }
        if(!self.thwart(king: king, gamestate: gamestate)){
            return true
        }
        return false
    }
    
    func listAttacker(king: [Int], gamestate: Gamestate) -> Array<[Int]> {
        var arrayList = Array<[Int]>()
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let listOpponent = CanonicalCheck().listOpponent(king: king, gamestate: gamestate)
        for opponent in listOpponent {
            let opponentElement = tschessElementMatrix[opponent[0]][opponent[1]]
            if(opponentElement!.validate(present: opponent, proposed: king, gamestate: gamestate)) {
                arrayList.append(opponent)
            }
            if(opponentElement!.name.contains("Grasshopper")){
                if(HopperOffense().evaluate(present: king, gamestate: gamestate, affiliation: gamestate.getSelfAffiliation())){
                    arrayList.append(opponent)
                }
            }
        }
        return arrayList
    }
    
    func thwart(king: [Int], gamestate: Gamestate) -> Bool {
        var tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        let listAttacker = self.listAttacker(king: king, gamestate: gamestate)
        
        let coordinateAttacker = listAttacker[0]
        let attackerElement = tschessElementMatrix[coordinateAttacker[0]][coordinateAttacker[1]]!
        
        let listCompatriot = CanonicalCheck().listCompatriot(king: king, gamestate: gamestate)
        for coordinateCompatriot in listCompatriot {
            let compatriotElement = tschessElementMatrix[coordinateCompatriot[0]][coordinateCompatriot[1]]!
            for i in (0 ..< 8) {
                for j in (0 ..< 8) {
                    if(compatriotElement.validate(present: coordinateCompatriot, proposed: [i,j], gamestate: gamestate)) {
                        let tschessElement = tschessElementMatrix[i][j]
                        tschessElementMatrix[i][j] = compatriotElement
                        tschessElementMatrix[coordinateCompatriot[0]][coordinateCompatriot[1]] = nil
                        gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
                        if(!attackerElement.validate(present: coordinateAttacker, proposed: king, gamestate: gamestate)) {
                            if(CanonicalCheck().check(coordinate: king, gamestate: gamestate)){
                                return false
                            }
                            return true
                        }
                        
                        
                        
                    
                        if(attackerElement.name.contains("Grasshopper")){
                            if(!HopperOffense().evaluate(present: king, gamestate: gamestate, affiliation: gamestate.getSelfAffiliation())){
                                return true
                            }
                            return false
                        }
                        
                        
                        
                        
                        
                        tschessElementMatrix[i][j] = tschessElement
                        tschessElementMatrix[coordinateCompatriot[0]][coordinateCompatriot[1]] = compatriotElement
                        gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
                    }
                }
            }
        }
        return false
    }
    
}
