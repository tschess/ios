//
//  HopperOffense.swift
//  ios
//
//  Created by Matthew on 10/15/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class HopperOffense {
    
    public func threat(present: [Int], proposed: [Int], gamestate0: Gamestate, affiliation: String) ->  Bool {
        //cache
        let tschessElementMatrix0 = gamestate0.getTschessElementMatrix()
        let elementPresent = tschessElementMatrix0[present[0]][present[1]]
        if(elementPresent == nil){
            return false
        }
        var tschessElementMatrix1 = gamestate0.getTschessElementMatrix()
        let gamestate1 = gamestate0.copy()
        gamestate1.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix1)
        
        tschessElementMatrix1[present[0]][present[1]] = nil
        tschessElementMatrix1[proposed[0]][proposed[1]] = elementPresent
        gamestate1.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix1)
        if(self.evaluate(present: proposed, gamestate: gamestate1, affiliation: affiliation)){
            gamestate0.dict = gamestate1.dict
            return true
        }
        return false
    }
    
    public func evaluate(present: [Int], gamestate: Gamestate, affiliation: String) ->  Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let elementPresent = tschessElementMatrix[present[0]][present[1]]
        if(elementPresent == nil){
            return false
        }
        let affiliationPresent = elementPresent!.affiliation
        
        let adjacent_UP: [Int]? = self.bounded(coordinate: [present[0] - 1, present[1]])
        let adjacent_DW: [Int]? = self.bounded(coordinate: [present[0] + 1, present[1]])
        let adjacent_LF: [Int]? = self.bounded(coordinate: [present[0], present[1] - 1])
        let adjacent_RT: [Int]? = self.bounded(coordinate: [present[0], present[1] + 1])
    
        var opponentHopper: [Int]?
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                let tschessElement = tschessElementMatrix[i][j]
                if(tschessElement == nil){
                    continue
                }
                let affiliationElement = tschessElement!.affiliation
                if(affiliationElement == affiliationPresent){
                    continue
                }
                let nameElement = tschessElement!.name
                if(nameElement.contains("Grasshopper")){
                    opponentHopper = [i,j]
                }
            }
        }
        if(opponentHopper == nil){
            return false
        }
        
        //cache
        let tschessElementMatrix0 = gamestate.getTschessElementMatrix()
        
        //adjacent_UP
        if(adjacent_UP != nil){
            if(Hopper().direction_UP(present: opponentHopper!, proposed: adjacent_UP!, gamestate: gamestate, affiliation: affiliation)){
                let tschessElementMatrixX = gamestate.getTschessElementMatrix()      ///???? do I need this?...
                let elementPresentX = tschessElementMatrixX[present[0]][present[1]]  ///???? maybe redundant...
                if(elementPresentX!.isHopped){
                    gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix0)
                    return true
                }
            }
        }
        //adjacent_DW
        if(adjacent_DW != nil){
            if(Hopper().direction_DOWN(present: opponentHopper!, proposed: adjacent_DW!, gamestate: gamestate, affiliation: affiliation)){
                let tschessElementMatrixX = gamestate.getTschessElementMatrix()      ///???? do I need this?...
                let elementPresentX = tschessElementMatrixX[present[0]][present[1]]  ///???? maybe redundant...
                if(elementPresentX!.isHopped){
                    gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix0)
                    return true
                }
            }
        }
        //adjacent_LF
        if(adjacent_LF != nil){
            if(Hopper().direction_LEFT(present: opponentHopper!, proposed: adjacent_LF!, gamestate: gamestate, affiliation: affiliation)){
                let tschessElementMatrixX = gamestate.getTschessElementMatrix()      ///???? do I need this?...
                let elementPresentX = tschessElementMatrixX[present[0]][present[1]]  ///???? maybe redundant...
                if(elementPresentX!.isHopped){
                    gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix0)
                    return true
                }
            }
        }
        //adjacent_RT
        if(adjacent_RT != nil){
            if(Hopper().direction_RIGHT(present: opponentHopper!, proposed: adjacent_RT!, gamestate: gamestate, affiliation: affiliation)){
                let tschessElementMatrixX = gamestate.getTschessElementMatrix()      ///???? do I need this?...
                let elementPresentX = tschessElementMatrixX[present[0]][present[1]]  ///???? maybe redundant...
                if(elementPresentX!.isHopped){
                    gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix0)
                    return true
                }
            }
        }
        return false
    }
    
    private func bounded(coordinate: [Int]) -> [Int]? {
        if(coordinate[0] < 0 || coordinate[0] > 7){
            return nil
        }
        if(coordinate[1] < 0 || coordinate[1] > 7){
            return nil
        }
        return coordinate
    }
}
