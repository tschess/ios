//
//  CheckMate.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class CheckMate {
    
    func mate(king: [Int], state: [[Piece?]]) -> Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let kingElement = state[king[0]][king[1]]!
        var listValidateKing = Array<[Int]>()
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                if(kingElement.validate(present: king, proposed: [i,j], state: state)){
                    listValidateKing.append([i,j])
                }
            }
        }
        let listOpponent = CheckCheck().listOpponent(king: king, state: state)
        
        var listValidateKingOpponent = Array<[Int]>()
        for move in listValidateKing {
            for opponent in listOpponent {
                let opponentElement = state[opponent[0]][opponent[1]]!
                if(opponentElement.validate(present: opponent, proposed: move, state: state)) {
                    listValidateKingOpponent.append(move)
                }
            }
        }
        let listKingMove = listValidateKing.filter {!listValidateKingOpponent.contains($0)}
        
        if(listKingMove.count > 0){
            return false
        }
        let listAttacker = self.listAttacker(king: king, state: state)
        if(listAttacker.count > 1){
            return true
        }
        if(!self.thwart(king: king, state: state)){
            return true
        }
        return false
    }
    
    func listAttacker(king: [Int], state: [[Piece?]]) -> Array<[Int]> {
        var arrayList = Array<[Int]>()
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let listOpponent = CheckCheck().listOpponent(king: king, state: state)
        for opponent in listOpponent {
            let opponentElement = state[opponent[0]][opponent[1]]
            if(opponentElement!.validate(present: opponent, proposed: king, state: state)) {
                arrayList.append(opponent)
            }
            if(opponentElement!.name.contains("Grasshopper")){
                if(HopperOffense().evaluate(present: king, state: state, affiliation: "FUCK")){
                    arrayList.append(opponent)
                }
            }
        }
        return arrayList
    }
    
    func thwart(king: [Int], state: [[Piece?]]) -> Bool {
        //var tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        let listAttacker = self.listAttacker(king: king, state: state)
        
        let coordinateAttacker = listAttacker[0]
        let attackerElement = state[coordinateAttacker[0]][coordinateAttacker[1]]!
        
        let listCompatriot = CheckCheck().listCompatriot(king: king, state: state)
        for coordinateCompatriot in listCompatriot {
            let compatriotElement = state[coordinateCompatriot[0]][coordinateCompatriot[1]]!
            for i in (0 ..< 8) {
                for j in (0 ..< 8) {
                    if(compatriotElement.validate(present: coordinateCompatriot, proposed: [i,j], state: state)) {
                        let tschessElement = state[i][j]
                        //state[i][j] = compatriotElement
                        //state[coordinateCompatriot[0]][coordinateCompatriot[1]] = nil
                        //gamestate.setTschessElementMatrix(tschessElementMatrix: state)
                        if(!attackerElement.validate(present: coordinateAttacker, proposed: king, state: state)) {
                            if(CheckCheck().check(coordinate: king, state: state)){
                                return false
                            }
                            return true
                        }
                        
                        
                        
                    
                        if(attackerElement.name.contains("Grasshopper")){
                            if(!HopperOffense().evaluate(present: king, state: state, affiliation: "FUCK")){
                                return true
                            }
                            return false
                        }
                        
                        
                        
                        
                        
                        //tschessElementMatrix[i][j] = tschessElement
                        //tschessElementMatrix[coordinateCompatriot[0]][coordinateCompatriot[1]] = compatriotElement
                        //gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
                    }
                }
            }
        }
        return false
    }
    
}
