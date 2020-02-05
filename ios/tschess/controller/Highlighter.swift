//
//  Highlighter.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class Highlighter {
    
    public func setImageSelection(piece: Piece, state: [[Piece?]]) {
        let imageSelection = piece.getImageSelection()
        piece.setImageVisible(imageVisible: imageSelection)
    }
    
    public func restoreSelection(coordinate: [Int]?, state: [[Piece?]]) {
        if(coordinate == nil){
            return
        }
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let tschessElement = state[coordinate![0]][coordinate![1]]
        if(tschessElement == nil){
            return
        }
        let imageDefault = tschessElement!.getImageDefault()
        tschessElement!.setImageVisible(imageVisible: imageDefault)
    }
    
    public func selectLegalMoves(present0: [Int], state0: [[Piece?]]) {
        
        //let orientation = gamestate0.getOrientationBlack()
        
        var present1: [Int]
//        if(orientation){
//            present1 = [7-present0[0],7-present0[1]]
//        } else {
//            present1 = [present0[0],present0[1]]
//        }
//        var tschessElementMatrix0 = gamestate0.getTschessElementMatrix()
//        let tschessElementMatrix1 = MatrixSerializer().canonicalGenerator(localMatrix: tschessElementMatrix0, orientation: orientation)
//        let gamestate1 = gamestate0.copy()
//        gamestate1.dict = gamestate0.dict
//        gamestate1.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix1)
        
//        let tschessElement = tschessElementMatrix1[present1[0]][present1[1]]!
//
//        for i in (0 ..< 8) {
//            for j in (0 ..< 8) {
//                if(tschessElement.validate(present: present1, proposed: [i,j], gamestate: gamestate1)) {
//                    let king = CanonicalCheck().kingCoordinate(affiliation: gamestate0.getSelfAffiliation(), gamestate: gamestate1)
//                    if(!CanonicalCheck().check(coordinate: king, gamestate: gamestate1)){
//                        if(orientation){
//                            tschessElementMatrix0[7-i][7-j] = self.transformElement(tschessElement: tschessElementMatrix1[i][j])
//                        } else {
//                            tschessElementMatrix0[i][j] = self.transformElement(tschessElement: tschessElementMatrix1[i][j])
//                        }
//                    }
//                }
//            }
//        }
//        gamestate0.dict = gamestate1.dict
//        gamestate0.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix0)
    }
    
    public func transformElement(tschessElement: Piece?) -> Piece? {
        if(tschessElement == nil){
            return PieceAnte()
        }
        let imageTarget = tschessElement!.getImageTarget()
        tschessElement!.setImageVisible(imageVisible: imageTarget)
        tschessElement!.isTarget = true
        return tschessElement
    }
    
    public func neutralize(state: [[Piece?]]) {
        //var tschessElementMatrix = gamestate.getTschessElementMatrix()
        for i in (0 ..< 8) {
            for j in (0 ..< 8) {
                let tschessElement = state[i][j]
                if(tschessElement == nil) {
                    continue
                }
                if(tschessElement!.name == "PieceAnte"){
                    //state[i][j] = nil
                }
                if(tschessElement!.isTarget == true) {
                    let imageDefault = tschessElement!.getImageDefault()
                    state[i][j]!.setImageVisible(imageVisible: imageDefault)
                    state[i][j]!.isTarget = false
                }
                if(tschessElement!.isHopped == true) {
                    state[i][j]!.isHopped = false
                }
            }
        }
        //gamestate.setTschessElementMatrix(tschessElementMatrix: tschessElementMatrix)
    }
    
}
