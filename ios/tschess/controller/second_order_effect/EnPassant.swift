//
//  EnPassant.swift
//  ios
//
//  Created by Matthew on 8/27/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class EnPassant {
    
//    public func evaluate(coordinate: [Int]?, proposed: [Int], gamestate: Gamestate) -> Bool {
//        if(coordinate == nil){
//            return false
//        }
//        var tschessElementMatrix = gamestate.getTschessElementMatrix()
//        let tschessElement = tschessElementMatrix[coordinate![0]][coordinate![1]]
//        if(tschessElement == nil){
//            return false
//        }
//        let affiliation = tschessElementMatrix[coordinate![0]][coordinate![1]]!.affiliation
//        
//        if(tschessElementMatrix[coordinate![0]][coordinate![1]]!.name.contains("Pawn")) {
//            
//            if(!Pawn().advanceTwo(present: coordinate!, proposed: proposed, gamestate: gamestate)){
//                return false
//            }
//            if(coordinate![1] - 1 >= 0){
//                let examinee = tschessElementMatrix[4][coordinate![1] - 1]
//                if(examinee != nil) {
//                    if(examinee!.name.contains("Pawn")) {
//                        if(examinee!.affiliation != affiliation){
//                            tschessElementMatrix[5][coordinate![1]] = examinee!
//                            tschessElementMatrix[4][coordinate![1] - 1] = nil
//                            tschessElementMatrix[coordinate![0]][coordinate![1]] = nil
//                            gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
//                            gamestate.setHighlight(coords: [5,coordinate![1],coordinate![0],coordinate![1]])
//                            gamestate.setDrawProposer(drawProposer: "PASSANT")
//                            return true
//                        }
//                    }
//                }
//            }
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
//        }
//        return false
//    }
    
}
