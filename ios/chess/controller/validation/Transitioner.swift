//
//  Transitioner.swift
//  ios
//
//  Created by Matthew on 11/7/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class Transitioner {
    
    let dateTime: DateTime = DateTime()
    
    var coordinate: [Int]?
    
    public func getCoordinate() -> [Int]? {
        return coordinate
    }
    
    public func clearCoordinate() {
        self.coordinate = nil
    }
    
    private func invalid(coordinate: [Int], gamestate: Gamestate) -> Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let tschessElement = tschessElementMatrix[coordinate[0]][coordinate[1]]
        if(self.coordinate == nil){
            if(tschessElement == nil){
                return true
            }
            if(tschessElement!.affiliation != gamestate.getSelfAffiliation()){
                return true
            }
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
    
    public func evaluateInput(coordinate: [Int], gamestate: Gamestate) {
        if(self.invalid(coordinate: coordinate, gamestate: gamestate)){
            Highlighter().restoreSelection(coordinate: coordinate, gamestate: gamestate)
            Highlighter().restoreSelection(coordinate: self.coordinate, gamestate: gamestate)
            Highlighter().neutralize(gamestate: gamestate)
            self.coordinate = nil
            return
        }
        if(self.coordinate == nil){
            self.coordinate = coordinate
            let tschessElementMatrix = gamestate.getTschessElementMatrix()
            let tschessElement = tschessElementMatrix[self.coordinate![0]][self.coordinate![1]]!
            Highlighter().setImageSelection(tschessElement: tschessElement, gamestate: gamestate)
            if(gamestate.getCheckOn() == gamestate.getUsernameSelf()) {
                CanonicalCheck().circumscribedCheck(coordinate0: coordinate, gamestate0: gamestate)
                return
            }
            Highlighter().selectLegalMoves(present0: coordinate, gamestate0: gamestate)
            return
        }
        Processor().execute(present: self.coordinate!, proposed: coordinate, gamestate: gamestate)
        Highlighter().restoreSelection(coordinate: coordinate, gamestate: gamestate)
        Highlighter().neutralize(gamestate: gamestate)
        
        gamestate.setHighlight(coords: [self.coordinate![0],self.coordinate![1],coordinate[0],coordinate[1]])
        
        self.coordinate = nil
        self.setLastMove(gamestate: gamestate)
        self.evaluateCheckMate(gamestate: gamestate)
        
        gamestate.changeTurn()
        gamestate.setUpdated(updated: dateTime.currentDateString())
        gamestate.setDrawProposer(drawProposer: "NONE")
        let requestUpdate = GamestateSerializer().execute(gamestate: gamestate)
        UpdateGamestate().execute(requestPayload: requestUpdate)
        gamestate.setHighlight(coords: nil)
    }
    
    private func setLastMove(gamestate: Gamestate) {
        if(gamestate.getUsernameSelf() == gamestate.getUsernameWhite()) {
            gamestate.setLastMoveWhite(lastMoveWhite: dateTime.currentDateString())
            return
        }
        gamestate.setLastMoveBlack(lastMoveBlack: dateTime.currentDateString())
    }
    
    public func evaluateCheckMate(gamestate: Gamestate) {
        gamestate.setCheckOn(checkOn: "NONE")
        let elementMatrix = gamestate.getTschessElementMatrix()
        let orientationBlack = gamestate.getOrientationBlack()
        let elementMatrixCanonical = MatrixSerializer().canonicalGenerator(localMatrix: elementMatrix, orientation: orientationBlack)
        let gamestateCanonical = gamestate.copy()
        gamestateCanonical.setTschessElementMatrix(tschessElementMatrix: elementMatrixCanonical)
        
        let king = CanonicalCheck().kingCoordinate(affiliation: gamestate.getOpponentAffiliation(), gamestate: gamestateCanonical)
        if(CanonicalCheck().check(coordinate: king, gamestate: gamestateCanonical)){
            if(CanonicalMate().mate(king: king, gamestate: gamestateCanonical)){
                gamestate.setWinner(winner: gamestate.getUsernameSelf())
                return
            }
            gamestate.setCheckOn(checkOn: gamestate.getUsernameOpponent())
        }
    }
}
