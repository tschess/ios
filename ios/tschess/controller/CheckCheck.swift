//
//  CheckCheck.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class CheckCheck {
    
    func check(coordinate: [Int], state: [[Piece?]]) -> Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let king = state[coordinate[0]][coordinate[1]]!
        let affiliation = king.affiliation
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                let tschessElement = state[i][j]
                if(tschessElement == nil) {
                    continue
                }
                if(tschessElement!.name == "PieceAnte") {
                    continue
                }
                let friendly = tschessElement!.affiliation == affiliation
                if(friendly){
                    continue
                }
                if(tschessElement!.validate(present: [i,j], proposed: coordinate, state: state)) {
                    return true
                }
            }
        }
        //special check for hopper...
        if(HopperOffense().evaluate(present: coordinate, state: state, affiliation: "FUCK")){
            return true
        }
        return false
    }
    
    func kingCoordinate(affiliation: String, state: [[Piece?]]) -> [Int] {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                let tschessElement = state[i][j]
                if (tschessElement == nil) {
                    continue
                }
                if(!tschessElement!.name.contains("King")) {
                    continue
                }
                if(tschessElement!.affiliation == affiliation) {
                    return [i,j]
                }
            }
        }
        return []
    }
    
    public func circumscribedCheck(coordinate0: [Int], state: [[Piece?]]) {
        
        let orientation = true //FUCK
        
        var coordinate1: [Int]
        if(orientation){
            coordinate1 = [7-coordinate0[0],7-coordinate0[1]]
        } else {
            coordinate1 = [coordinate0[0],coordinate0[1]]
        }
        //var tschessElementMatrix0 = gamestate0.getTschessElementMatrix()
        //let tschessElementMatrix1 = MatrixSerializer().canonicalGenerator(localMatrix: tschessElementMatrix0, orientation: orientation)
        //let gamestate1 = gamestate0.copy()
        //gamestate1.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix1)
        
        //let kingCoordinate = self.kingCoordinate(affiliation: gamestate0.getSelfAffiliation(), gamestate: gamestate1)
        
//        let listLegalMove = self.listLegalMove(coordinate: coordinate1, gamestate: gamestate1, king: kingCoordinate)
//
//        for (element, moveList) in listLegalMove {
//            if(element == coordinate1){
//                for move in moveList {
//
//                    if(orientation){
//                        tschessElementMatrix0[7-move[0]][7-move[1]] = Highlighter().transformElement(tschessElement: tschessElementMatrix0[7-move[0]][7-move[1]])
//                    } else {
//                        tschessElementMatrix0[move[0]][move[1]] = Highlighter().transformElement(tschessElement: tschessElementMatrix0[move[0]][move[1]])
//                    }
//
//                }
//            }
//        }
//        gamestate0.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix0)
    }
    
    public func listLegalMove(coordinate: [Int], state: [[Piece?]], king: [Int]) -> [[Int]: Array<[Int]>] {
        if(coordinate == king) {
            return self.listKingMove(coordinate: king, state: state)
        }
        return self.thwartDict(king: king, state: state)
    }
    
    func listKingMove(coordinate: [Int], state: [[Piece?]]) -> [[Int]: Array<[Int]>] {
        var arrayList = Array<[Int]>()
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let king = state[coordinate[0]][coordinate[1]]
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                if(king!.validate(present: coordinate, proposed: [i,j], state: state)){
                    arrayList.append([i,j])
                }
            }
        }
        return [coordinate: arrayList]
    }
    
    func listCompatriot(king: [Int], state: [[Piece?]]) -> Array<[Int]> {
        var arrayList = Array<[Int]>()
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let kingElement = state[king[0]][king[1]]
        let affiliation = kingElement!.affiliation
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                if([i,j] == king){
                    continue
                }
                let tschessElement = state[i][j]
                if(tschessElement == nil){
                    continue
                }
                if(tschessElement!.affiliation != affiliation) {
                    continue
                }
                arrayList.append([i,j])
            }
        }
        return arrayList
    }
    
    func listOpponent(king: [Int], state: [[Piece?]]) -> Array<[Int]> {
        var arrayList = Array<[Int]>()
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let kingElement = state[king[0]][king[1]]
        let affiliation = kingElement!.affiliation
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                if([i,j] == king){
                    continue
                }
                let tschessElement = state[i][j]
                if(tschessElement == nil){
                    continue
                }
                if(tschessElement!.affiliation == affiliation) {
                    continue
                }
                arrayList.append([i,j])
            }
        }
        return arrayList
    }
    
    func listAttacker(king: [Int], state: [[Piece?]]) -> Array<[Int]> {
        var arrayList = Array<[Int]>()
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let listOpponent = self.listOpponent(king: king, state: state)
        for opponent in listOpponent {
            let opponentElement = state[opponent[0]][opponent[1]]
            if(opponentElement!.validate(present: opponent, proposed: king, state: state)) {
                arrayList.append(opponent)
            }
        }
        return arrayList
    }
    
    func thwartDict(king: [Int], state: [[Piece?]]) -> [[Int]: Array<[Int]>] {
        var thwartDict = [[Int]: Array<[Int]>]()
        //var tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        let listAttacker = self.listAttacker(king: king, state: state)
        let listCompatriot = self.listCompatriot(king: king, state: state)
        
        for coordinateAttacker in listAttacker {
            for coordinateCompatriot in listCompatriot {
                var arrayList = Array<[Int]>()
                
                let attackerElement = state[coordinateAttacker[0]][coordinateAttacker[1]]!
                let compatriotElement = state[coordinateCompatriot[0]][coordinateCompatriot[1]]!
                
                for i in (0 ..< 8) {
                    for j in (0 ..< 8) {
                        if(compatriotElement.validate(present: coordinateCompatriot, proposed: [i,j], state: state)) {
                            let tschessElement = state[i][j]
                            //state[i][j] = compatriotElement
                            //state[coordinateCompatriot[0]][coordinateCompatriot[1]] = tschessElement
                            //gamestate.setTschessElementMatrix(tschessElementMatrix: state)
                            
                            if(!attackerElement.validate(present: coordinateAttacker, proposed: king, state: state)) {
                                arrayList.append([i,j])
                            }
                            //state[i][j] = tschessElement
                            //state[coordinateCompatriot[0]][coordinateCompatriot[1]] = compatriotElement
                            //gamestate.setTschessElementMatrix(tschessElementMatrix: state)
                        }
                    }
                }
                if(arrayList.count > 0){
                    thwartDict[coordinateCompatriot] = arrayList
                }
            }
        }
        return thwartDict
    }
    
}
