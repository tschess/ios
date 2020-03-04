//
//  CheckCheck.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class Checker {

    func on(affiliation: String, state: [[Piece?]]) -> Bool {
        let kgCrd: [Int] = self.kingCoordinate(affiliation: affiliation, state: state)
        //print("~ king ~\n\(kgCrd)\n")
        //print("\(state)")
        if(self.check(coordinate: kgCrd, state: state)){
            //print("\nTRUE\n\n")
            return true
        }
        return false
    }
    
    func kingCoordinate(affiliation: String, state: [[Piece?]]) -> [Int] {
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
    
    func check(coordinate: [Int], state: [[Piece?]]) -> Bool {
        let king = state[coordinate[0]][coordinate[1]]!
        let affiliation = king.affiliation
        loop0: for i in (0 ..< 8) {
            loop1: for j in (0 ..< 8) {
                let tschessElement = state[i][j]
                if(tschessElement == nil) {
                    continue loop1
                }
                if(tschessElement!.name == "PieceAnte") {
                    continue loop1
                }
                let friendly = tschessElement!.affiliation == affiliation
                if(friendly){
                    continue loop1
                }
                if(tschessElement!.validate(present: [i,j], proposed: coordinate, state: state)) {
                    return true
                }
            }
        }
        return false
    }
    
    public func listLegalMove(coordinate: [Int], state: [[Piece?]], king: [Int]) -> [[Int]: Array<[Int]>] {
        if(coordinate == king) {
            return self.listKingMove(coordinate: king, state: state)
        }
        return self.thwartDict(king: king, state0: state)
    }
    
    func listKingMove(coordinate: [Int], state: [[Piece?]]) -> [[Int]: Array<[Int]>] {
        var arrayList = Array<[Int]>()
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
        let listOpponent = self.listOpponent(king: king, state: state)
        for opponent in listOpponent {
            let opponentElement = state[opponent[0]][opponent[1]]
            if(opponentElement!.validate(present: opponent, proposed: king, state: state)) {
                arrayList.append(opponent)
            }
        }
        return arrayList
    }
    
    func thwartDict(king: [Int], state0: [[Piece?]]) -> [[Int]: Array<[Int]>] {
        var thwartDict = [[Int]: Array<[Int]>]()
        
        var state1 = state0
        
        let listAttacker = self.listAttacker(king: king, state: state1)
        let listCompatriot = self.listCompatriot(king: king, state: state1)
        
        for coordinateAttacker in listAttacker {
            for coordinateCompatriot in listCompatriot {
                var arrayList = Array<[Int]>()
                
                let attackerElement = state1[coordinateAttacker[0]][coordinateAttacker[1]]!
                let compatriotElement = state1[coordinateCompatriot[0]][coordinateCompatriot[1]]!
                
                for i in (0 ..< 8) {
                    for j in (0 ..< 8) {
                        if(compatriotElement.validate(present: coordinateCompatriot, proposed: [i,j], state: state1)) {
                            let tschessElement = state1[i][j]
                            state1[i][j] = compatriotElement
                            state1[coordinateCompatriot[0]][coordinateCompatriot[1]] = tschessElement
                            //gamestate.setTschessElementMatrix(tschessElementMatrix: state)
                            
                            if(!attackerElement.validate(present: coordinateAttacker, proposed: king, state: state1)) {
                                arrayList.append([i,j])
                            }
                            state1[i][j] = tschessElement
                            state1[coordinateCompatriot[0]][coordinateCompatriot[1]] = compatriotElement
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
    
    func thwart(king: [Int], state0: [[Piece?]]) -> Bool {
        //var tschessElementMatrix = gamestate.getTschessElementMatrix()
        var state1 = state0
        
        let listAttacker = self.listAttacker(king: king, state: state1)
        if(listAttacker.isEmpty){
            return true
        }
        
        let coordinateAttacker = listAttacker[0]
        let attackerElement = state1[coordinateAttacker[0]][coordinateAttacker[1]]!
        
        let listCompatriot = self.listCompatriot(king: king, state: state1)
        for coordinateCompatriot in listCompatriot {
            let compatriotElement = state1[coordinateCompatriot[0]][coordinateCompatriot[1]]!
            for i in (0 ..< 8) {
                for j in (0 ..< 8) {
                    if(compatriotElement.validate(present: coordinateCompatriot, proposed: [i,j], state: state1)) {
                        let tschessElement = state1[i][j]
                        state1[i][j] = compatriotElement
                        state1[coordinateCompatriot[0]][coordinateCompatriot[1]] = nil
                        //gamestate.setTschessElementMatrix(tschessElementMatrix: state)
                        if(!attackerElement.validate(present: coordinateAttacker, proposed: king, state: state1)) {
                            if(Checker().check(coordinate: king, state: state1)){
                                return false
                            }
                            return true
                        }
                        state1[i][j] = tschessElement
                        state1[coordinateCompatriot[0]][coordinateCompatriot[1]] = compatriotElement
                        //gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
                    }
                }
            }
        }
        return false
    }
    
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
        let listOpponent = self.listOpponent(king: king, state: state)
        
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
        if(!self.thwart(king: king, state0: state)){
            return true
        }
        return false
    }
    
}
