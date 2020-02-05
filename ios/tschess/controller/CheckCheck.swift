//
//  CheckCheck.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class CheckCheck {
    
    func check(coordinate: [Int], gamestate: Gamestate) -> Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let king = tschessElementMatrix[coordinate[0]][coordinate[1]]!
        let affiliation = king.affiliation
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                let tschessElement = tschessElementMatrix[i][j]
                if(tschessElement == nil) {
                    continue
                }
                if(tschessElement!.name == "LegalMove") {
                    continue
                }
                let friendly = tschessElement!.affiliation == affiliation
                if(friendly){
                    continue
                }
                if(tschessElement!.validate(present: [i,j], proposed: coordinate, gamestate: gamestate)) {
                    return true
                }
            }
        }
        //special check for hopper...
        if(HopperOffense().evaluate(present: coordinate, gamestate: gamestate, affiliation: gamestate.getSelfAffiliation())){
            return true
        }
        return false
    }
    
    func kingCoordinate(affiliation: String, gamestate: Gamestate) -> [Int] {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                let tschessElement = tschessElementMatrix[i][j]
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
    
    public func circumscribedCheck(coordinate0: [Int], gamestate0: Gamestate) {
        
        let orientation = gamestate0.getOrientationBlack()
        
        var coordinate1: [Int]
        if(orientation){
            coordinate1 = [7-coordinate0[0],7-coordinate0[1]]
        } else {
            coordinate1 = [coordinate0[0],coordinate0[1]]
        }
        var tschessElementMatrix0 = gamestate0.getTschessElementMatrix()
        let tschessElementMatrix1 = MatrixSerializer().canonicalGenerator(localMatrix: tschessElementMatrix0, orientation: orientation)
        let gamestate1 = gamestate0.copy()
        gamestate1.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix1)
        
        let kingCoordinate = self.kingCoordinate(affiliation: gamestate0.getSelfAffiliation(), gamestate: gamestate1)
        
        let listLegalMove = self.listLegalMove(coordinate: coordinate1, gamestate: gamestate1, king: kingCoordinate)
        
        for (element, moveList) in listLegalMove {
            if(element == coordinate1){
                for move in moveList {
                    
                    if(orientation){
                        tschessElementMatrix0[7-move[0]][7-move[1]] = Highlighter().transformElement(tschessElement: tschessElementMatrix0[7-move[0]][7-move[1]])
                    } else {
                        tschessElementMatrix0[move[0]][move[1]] = Highlighter().transformElement(tschessElement: tschessElementMatrix0[move[0]][move[1]])
                    }
                    
                }
            }
        }
        gamestate0.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix0)
    }
    
    public func listLegalMove(coordinate: [Int], gamestate: Gamestate, king: [Int]) -> [[Int]: Array<[Int]>] {
        if(coordinate == king) {
            return self.listKingMove(coordinate: king, gamestate: gamestate)
        }
        return self.thwartDict(king: king, gamestate: gamestate)
    }
    
    func listKingMove(coordinate: [Int], gamestate: Gamestate) -> [[Int]: Array<[Int]>] {
        var arrayList = Array<[Int]>()
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let king = tschessElementMatrix[coordinate[0]][coordinate[1]]
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                if(king!.validate(present: coordinate, proposed: [i,j], gamestate: gamestate)){
                    arrayList.append([i,j])
                }
            }
        }
        return [coordinate: arrayList]
    }
    
    func listCompatriot(king: [Int], gamestate: Gamestate) -> Array<[Int]> {
        var arrayList = Array<[Int]>()
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let kingElement = tschessElementMatrix[king[0]][king[1]]
        let affiliation = kingElement!.affiliation
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                if([i,j] == king){
                    continue
                }
                let tschessElement = tschessElementMatrix[i][j]
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
    
    func listOpponent(king: [Int], gamestate: Gamestate) -> Array<[Int]> {
        var arrayList = Array<[Int]>()
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let kingElement = tschessElementMatrix[king[0]][king[1]]
        let affiliation = kingElement!.affiliation
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                if([i,j] == king){
                    continue
                }
                let tschessElement = tschessElementMatrix[i][j]
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
    
    func listAttacker(king: [Int], gamestate: Gamestate) -> Array<[Int]> {
        var arrayList = Array<[Int]>()
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let listOpponent = self.listOpponent(king: king, gamestate: gamestate)
        for opponent in listOpponent {
            let opponentElement = tschessElementMatrix[opponent[0]][opponent[1]]
            if(opponentElement!.validate(present: opponent, proposed: king, gamestate: gamestate)) {
                arrayList.append(opponent)
            }
        }
        return arrayList
    }
    
    func thwartDict(king: [Int], gamestate: Gamestate) -> [[Int]: Array<[Int]>] {
        var thwartDict = [[Int]: Array<[Int]>]()
        var tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        let listAttacker = self.listAttacker(king: king, gamestate: gamestate)
        let listCompatriot = self.listCompatriot(king: king, gamestate: gamestate)
        
        for coordinateAttacker in listAttacker {
            for coordinateCompatriot in listCompatriot {
                var arrayList = Array<[Int]>()
                
                let attackerElement = tschessElementMatrix[coordinateAttacker[0]][coordinateAttacker[1]]!
                let compatriotElement = tschessElementMatrix[coordinateCompatriot[0]][coordinateCompatriot[1]]!
                
                for i in (0 ..< 8) {
                    for j in (0 ..< 8) {
                        if(compatriotElement.validate(present: coordinateCompatriot, proposed: [i,j], gamestate: gamestate)) {
                            let tschessElement = tschessElementMatrix[i][j]
                            tschessElementMatrix[i][j] = compatriotElement
                            tschessElementMatrix[coordinateCompatriot[0]][coordinateCompatriot[1]] = tschessElement
                            gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
                            
                            if(!attackerElement.validate(present: coordinateAttacker, proposed: king, gamestate: gamestate)) {
                                arrayList.append([i,j])
                            }
                            tschessElementMatrix[i][j] = tschessElement
                            tschessElementMatrix[coordinateCompatriot[0]][coordinateCompatriot[1]] = compatriotElement
                            gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
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
