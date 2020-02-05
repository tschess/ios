//
//  Passant.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Passant {
    
    public func evaluate(coordinate: [Int]?, proposed: [Int], state: [[Piece?]]) -> Bool {
        if(coordinate == nil){
            return false
        }
        //var tschessElementMatrix = gamestate.getTschessElementMatrix()
        let tschessElement = state[coordinate![0]][coordinate![1]]
        if(tschessElement == nil){
            return false
        }
        let affiliation = state[coordinate![0]][coordinate![1]]!.affiliation
        
        if(state[coordinate![0]][coordinate![1]]!.name.contains("Pawn")) {
            
            if(!Pawn().advanceTwo(present: coordinate!, proposed: proposed, state: state)){
                return false
            }
            if(coordinate![1] - 1 >= 0){
                let examinee = state[4][coordinate![1] - 1]
                if(examinee != nil) {
                    if(examinee!.name.contains("Pawn")) {
                        if(examinee!.affiliation != affiliation){
                            //state[5][coordinate![1]] = examinee!
                            //state[4][coordinate![1] - 1] = nil
                            //state[coordinate![0]][coordinate![1]] = nil
                            //gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
                            //gamestate.setHighlight(coords: [5,coordinate![1],coordinate![0],coordinate![1]])
                            //gamestate.setDrawProposer(drawProposer: "PASSANT")
                            return true
                        }
                    }
                }
            }
//            if(coordinate![1] + 1 <= 7){
//                let examinee = tschessElementMatrix[4][coordinate![1] + 1]
//                if(examinee != nil) {
//                    if(examinee!.name.contains("Pawn")) {
//                        if(examinee!.affiliation != affiliation){
//                            tschessElementMatrix[5][coordinate![1]] = examinee!
//                            tschessElementMatrix[4][coordinate![1] + 1] = nil
//                            tschessElementMatrix[coordinate![0]][coordinate![1]] = nil
//                            gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
//                            gamestate.setHighlight(coords: [5,coordinate![1],coordinate![0],coordinate![1]])
//                            gamestate.setDrawProposer(drawProposer: "PASSANT")
//                            return true
//                        }
//                    }
//                }
//            }
        }
        return false
    }
    
}
