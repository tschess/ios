//
//  Castling.swift
//  ios
//
//  Created by Matthew on 9/11/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Castling {
    
    var transitioner: Transitioner?
    
    public func setTransitioner(transitioner: Transitioner) {
        self.transitioner = transitioner
    }
    
//    func opponentCoordinateList(kingCoordinate: [Int], gamestate: Gamestate) -> Array<[Int]> {
//        var opponentCoordinateList = Array<[Int]>()
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        let kingAffiliation = tschessElementMatrix[kingCoordinate[0]][kingCoordinate[1]]!.affiliation
//        for i in (0 ..< 8) {
//            for j in (0 ..< 8) {
//                if(tschessElementMatrix[i][j] != nil){
//                    if(tschessElementMatrix[i][j]!.affiliation != kingAffiliation) {
//                        opponentCoordinateList.append([i,j])
//                    }
//                }
//            }
//        }
//        //print("opponentCoordinateList: \(opponentCoordinateList)")
//        return opponentCoordinateList
//    }
    
    private func generateSearchSpace(proposed: [Int], affiliation: String) -> [[Int]]? {
        if(affiliation == "WHITE"){
            if(proposed == [7,6]){
                //print("kingSideWhite")
                return [[7,4], [7,5], [7,6]] //kingSideWhite
            }
            if(proposed == [7,2]){
                //print("queenSideWhite")
                return [[7,4], [7,3], [7,2]] //queenSideWhite
            }
        }
        if(affiliation == "BLACK"){
            if(proposed == [7,1]){
                //print("kingSideBlack")
                return [[7,3], [7,2], [7,1]] //kingSideBlack
            }
            if(proposed == [7,5]){
                //print("queenSideBlack")
                return [[7,3], [7,4], [7,5]] //queenSideBlack
            }
        }
        return nil
    }
    
    private func validateRookFirstTouch(proposed: [Int], tschessElementMatrix: [[TschessElement?]], affiliation: String) -> Bool {
        if(affiliation == "WHITE"){
            if(proposed == [7,6]){
                let candidateRook = tschessElementMatrix[7][7]
                if(candidateRook != nil){
                    if(!candidateRook!.name.contains("Rook")){
                        return false
                    } else {
                        return candidateRook!.firstTouch
                    }
                }
            }
            if(proposed == [7,2]){
                let candidateRook = tschessElementMatrix[7][0]
                if(candidateRook != nil){
                    if(!candidateRook!.name.contains("Rook")){
                        return false
                    } else {
                        return candidateRook!.firstTouch
                    }
                }
            }
        }
        if(affiliation == "BLACK"){
            if(proposed == [7,1]){
                let candidateRook = tschessElementMatrix[7][0]
                if(candidateRook != nil){
                    if(!candidateRook!.name.contains("Rook")){
                        return false
                    } else {
                        return candidateRook!.firstTouch
                    }
                }
            }
            if(proposed == [7,5]){
                let candidateRook = tschessElementMatrix[7][7]
                if(candidateRook != nil){
                    if(!candidateRook!.name.contains("Rook")){
                        return false
                    } else {
                        return candidateRook!.firstTouch
                    }
                }
            }
        }
        return false
    }
    
    private func validateKingFirstTouch(kingCoordinate: [Int], tschessElementMatrix: [[TschessElement?]]) -> Bool {
        let tschessElement = tschessElementMatrix[kingCoordinate[0]][kingCoordinate[1]]
        if(tschessElement != nil) {
            if(!tschessElementMatrix[kingCoordinate[0]][kingCoordinate[1]]!.name.contains("King")) {
                return false
            }
        }
        if(!tschessElement!.firstTouch){
            return false
        }
        return true
    }
    
//    public func castle(kingCoordinate: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        if(kingCoordinate[0] != 7 || proposed[0] != 7){
//            return false
//        }
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        let king = tschessElementMatrix[kingCoordinate[0]][kingCoordinate[1]]
//        if(king == nil){
//            return false
//        }
//        let affiliation = king!.affiliation
//        let searchSpace = generateSearchSpace(proposed: proposed, affiliation: affiliation)
//        
//        if(!validateKingFirstTouch(kingCoordinate: kingCoordinate, tschessElementMatrix: tschessElementMatrix)){
//            return false
//        }
//        if(!validateRookFirstTouch(proposed: proposed, tschessElementMatrix: tschessElementMatrix, affiliation: affiliation)){
//            return false
//        }
//        let opponentCoordinateList = self.opponentCoordinateList(kingCoordinate: kingCoordinate, gamestate: gamestate)
//        for opponentCoordinate in opponentCoordinateList {
//            let opponent = gamestate.getTschessElementMatrix()[opponentCoordinate[0]][opponentCoordinate[1]]!
//            //print("opponent: \(opponent)")
//            if(searchSpace != nil) {
//                for space in searchSpace! {
//                    if(opponent.validate(present: opponentCoordinate, proposed: space, gamestate: gamestate)) {
//                        return false
//                    }
//                    if(space == kingCoordinate){
//                        continue
//                    }
//                    let spaceOccupant = tschessElementMatrix[space[0]][space[1]]
//                    if(spaceOccupant != nil){
//                        if(spaceOccupant!.name != "LegalMove"){
//                            return false
//                        }
//                    }
//                }
//            }
//        }
//        return true
//    }
    
//    public func execute(coordinate: [Int], proposed: [Int], gamestate: Gamestate) -> Bool {
//        if(coordinate[0] != 7 || proposed[0] != 7){
//            return false
//        }
//        var tschessElementMatrix = gamestate.getTschessElementMatrix()
//        let tschessElement = tschessElementMatrix[coordinate[0]][coordinate[1]]
//        if(tschessElement == nil){
//            return false
//        }
//        if(!tschessElement!.name.contains("King")) {
//            return false
//        }
//        let tschessElementProposed = tschessElementMatrix[proposed[0]][proposed[1]]
//        if(tschessElementProposed == nil){
//            return false
//        }
//        if(tschessElementProposed!.name != "LegalMove") {
//            return false
//        }
//        let affiliation = tschessElement!.affiliation
//        if(affiliation == "WHITE"){
//            if(proposed == [7,6]){
//                
//                let rook = tschessElementMatrix[7][7]
//                if(rook == nil){
//                    return false
//                }
//                if(!rook!.name.contains("Rook")){
//                    return false
//                }
//                
//                let imageDefault = tschessElement!.getImageDefault()
//                tschessElement!.setImageVisible(imageVisible: imageDefault)
//                tschessElementMatrix[7][6] = tschessElement
//                tschessElementMatrix[7][6]!.setFirstTouch(firstTouch: false)
//                tschessElementMatrix[coordinate[0]][coordinate[1]] = nil
//                tschessElementMatrix[7][5] = rook!
//                tschessElementMatrix[7][5]!.setFirstTouch(firstTouch: false)
//                tschessElementMatrix[7][7] = nil
//                gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
//                gamestate.setDrawProposer(drawProposer: "CASTLE")
//                gamestate.setHighlight(coords: [7,6,7,5])
//                
//                return true
//                
//            }
//            if(proposed == [7,2]){
//                
//                let rook = tschessElementMatrix[7][0]
//                if(rook == nil){
//                    return false
//                }
//                if(!rook!.name.contains("Rook")){
//                    return false
//                }
//              
//                let imageDefault = tschessElement!.getImageDefault()
//                tschessElement!.setImageVisible(imageVisible: imageDefault)
//                tschessElementMatrix[7][2] = tschessElement
//                tschessElementMatrix[7][2]!.setFirstTouch(firstTouch: false)
//                tschessElementMatrix[coordinate[0]][coordinate[1]] = nil
//                tschessElementMatrix[7][3] = rook!
//                tschessElementMatrix[7][3]!.setFirstTouch(firstTouch: false)
//                tschessElementMatrix[7][0] = nil
//                gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
//                gamestate.setDrawProposer(drawProposer: "CASTLE")
//                gamestate.setHighlight(coords: [7,3,7,2])
//                
//                return true
//            }
//        }
//        if(affiliation == "BLACK"){
//            if(proposed == [7,1]){
//                
//                let rook = tschessElementMatrix[7][0]
//                if(rook == nil){
//                    return false
//                }
//                if(!rook!.name.contains("Rook")){
//                    return false
//                }
//                
//                let imageDefault = tschessElement!.getImageDefault()
//                tschessElement!.setImageVisible(imageVisible: imageDefault)
//                tschessElementMatrix[7][1] = tschessElement
//                tschessElementMatrix[7][1]!.setFirstTouch(firstTouch: false)
//                tschessElementMatrix[coordinate[0]][coordinate[1]] = nil
//                tschessElementMatrix[7][2] = rook!
//                tschessElementMatrix[7][2]!.setFirstTouch(firstTouch: false)
//                tschessElementMatrix[7][0] = nil
//                gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
//                gamestate.setDrawProposer(drawProposer: "CASTLE")
//                gamestate.setHighlight(coords: [7,2,7,1])
//                
//                return true
//                
//            }
//            if(proposed == [7,5]){
//                
//                let rook = tschessElementMatrix[7][7]
//                if(rook == nil){
//                    return false
//                }
//                if(!rook!.name.contains("Rook")){
//                   return false
//                }
//                
//                let imageDefault = tschessElement!.getImageDefault()
//                tschessElement!.setImageVisible(imageVisible: imageDefault)
//                tschessElementMatrix[7][5] = tschessElement
//                tschessElementMatrix[7][5]!.setFirstTouch(firstTouch: false)
//                tschessElementMatrix[coordinate[0]][coordinate[1]] = nil
//                tschessElementMatrix[7][4] = rook!
//                tschessElementMatrix[7][4]!.setFirstTouch(firstTouch: false)
//                tschessElementMatrix[7][7] = nil
//                gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
//                gamestate.setDrawProposer(drawProposer: "CASTLE")
//                gamestate.setHighlight(coords: [7,4,7,5])
//                
//                return true
//            }
//        }
//        return false
//    }
    
}
