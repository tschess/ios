//
//  Transitioner.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class Transitioner {
    
    var coordinate: [Int]?
    
    public func evaluateInput(coordinate: [Int], state: [[Piece?]]) -> [[Piece?]] {
//        if(self.invalid(coordinate: coordinate, state: state)){
//            Highlighter().restoreSelection(coordinate: coordinate, state: state)
//            Highlighter().restoreSelection(coordinate: self.coordinate, state: state)
//            Highlighter().neutralize(state: state)
//            self.coordinate = nil
//            return
//        }
        //if(self.coordinate == nil){
            self.coordinate = coordinate
            let imageSelection = state[self.coordinate![0]][self.coordinate![1]]!.getImageSelection()
            state[self.coordinate![0]][self.coordinate![1]]!.setImageVisible(imageVisible: imageSelection)
            
            //Highlighter().selectLegalMoves(present0: coordinate, state0: state)
            return state
        //}
        //Processor().execute(present: self.coordinate!, proposed: coordinate, state: state)
        //Highlighter().restoreSelection(coordinate: coordinate, state: state)
        //Highlighter().neutralize(state: state)
        
        //gamestate.setHighlight(coords: [self.coordinate![0],self.coordinate![1],coordinate[0],coordinate[1]])
        
        //self.coordinate = nil
        //self.setLastMove(state: state)
        //self.evaluateCheckMate(state: state)
        
        //gamestate.changeTurn()
        //gamestate.setUpdated(updated: dateTime.currentDateString())
        //gamestate.setDrawProposer(drawProposer: "NONE")
        //let requestUpdate = GamestateSerializer().execute(gamestate: gamestate)
        //UpdateGamestate().execute(requestPayload: requestUpdate)
        //gamestate.setHighlight(coords: nil)
        
        
        //return state
    }
    
    
    
    let dateTime: DateTime = DateTime()
    
    
    
    public func getCoordinate() -> [Int]? {
        return coordinate
    }
    
    public func clearCoordinate() {
        self.coordinate = nil
    }
    
    private func invalid(coordinate: [Int], state: [[Piece?]]) -> Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let tschessElement = state[coordinate[0]][coordinate[1]]
        if(self.coordinate == nil){
            if(tschessElement == nil){
                return true
            }
//            if(tschessElement!.affiliation != gamestate.getSelfAffiliation()){
//                return true
//            }
        }
        if(self.coordinate != nil){
            if(self.coordinate! == coordinate){
                return true
            }
            if(!Processor().validateElement(candidate: tschessElement)){
                return true
            }
        }
        return false
    }
    
    private func setLastMove(state: [[Piece?]]) {
        //if(gamestate.getUsernameSelf() == gamestate.getUsernameWhite()) {
            //gamestate.setLastMoveWhite(lastMoveWhite: dateTime.currentDateString())
            //return
        //}
        //gamestate.setLastMoveBlack(lastMoveBlack: dateTime.currentDateString())
    }
    
    public func evaluateCheckMate(state: [[Piece?]]) {
        //gamestate.setCheckOn(checkOn: "NONE")
        //let elementMatrix = gamestate.getTschessElementMatrix()
        //let orientationBlack = gamestate.getOrientationBlack()
        //let elementMatrixCanonical = MatrixSerializer().canonicalGenerator(localMatrix: elementMatrix, orientation: orientationBlack)
        //let gamestateCanonical = gamestate.copy()
        //gamestateCanonical.setTschessElementMatrix(tschessElementMatrix: elementMatrixCanonical)
        
        //let king = CanonicalCheck().kingCoordinate(affiliation: gamestate.getOpponentAffiliation(), gamestate: gamestateCanonical)
        //if(CanonicalCheck().check(coordinate: king, gamestate: gamestateCanonical)){
            //if(CanonicalMate().mate(king: king, gamestate: gamestateCanonical)){
                //gamestate.setWinner(winner: gamestate.getUsernameSelf())
                //return
            //}
            //gamestate.setCheckOn(checkOn: gamestate.getUsernameOpponent())
        //}
    }
}
