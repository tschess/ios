//
//  KnightOffense.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class KnightOffense {
    
    let knight: String = "Knight"
    
    func evaluate(coordinate: [Int], affiliation: String, gamestate: Gamestate) -> Bool {

        // minusTwo_minusOne
        if (coordinate[0] - 2 >= 0 && coordinate[1] - 1 >= 0) {
            if(evaluateName(attacker: knight, coordinate: [coordinate[0] - 2, coordinate[1] - 1], affiliation: affiliation, gamestate: gamestate)){
                return true;
            }
        }
        // minusOne_minusTwo
        if (coordinate[0] - 1 >= 0 && coordinate[1] - 2 >= 0) {
            if(evaluateName(attacker: knight, coordinate: [coordinate[0] - 2, coordinate[1] - 1], affiliation: affiliation, gamestate: gamestate)){
                return true;
            }
        }
        // minusTwo_plusOne
        if (coordinate[0] - 2 >= 0 && coordinate[1] + 1 >= 0) {
            if(evaluateName(attacker: knight, coordinate: [coordinate[0] - 2, coordinate[1] - 1], affiliation: affiliation, gamestate: gamestate)){
                return true;
            }
        }
        // minusOne_plusTwo
        if (coordinate[0] - 1 >= 0 && coordinate[1] + 2 >= 0) {
            if(evaluateName(attacker: knight, coordinate: [coordinate[0] - 2, coordinate[1] - 1], affiliation: affiliation, gamestate: gamestate)){
                return true;
            }
        }
        // plusTwo_minusOne
        if (coordinate[0] + 2 >= 0 && coordinate[1] - 1 >= 0) {
            if(evaluateName(attacker: knight, coordinate: [coordinate[0] - 2, coordinate[1] - 1], affiliation: affiliation, gamestate: gamestate)){
                return true;
            }
        }
        // plusTwo_plusOne
        if (coordinate[0] + 2 >= 0 && coordinate[1] + 1 >= 0) {
            if(evaluateName(attacker: knight, coordinate: [coordinate[0] - 2, coordinate[1] - 1], affiliation: affiliation, gamestate: gamestate)){
                return true;
            }
        }
        // plusOne_minusTwo
        if (coordinate[0] + 1 >= 0 && coordinate[1] - 2 >= 0) {
            if(evaluateName(attacker: knight, coordinate: [coordinate[0] - 2, coordinate[1] - 1], affiliation: affiliation, gamestate: gamestate)){
                return true;
            }
        }
        // plusOne_plusTwo
        if (coordinate[0] + 1 >= 0 && coordinate[1] + 2 >= 0) {
            if(evaluateName(attacker: knight, coordinate: [coordinate[0] - 2, coordinate[1] - 1], affiliation: affiliation, gamestate: gamestate)){
                return true;
            }
        }
        return false
    }
    
    func evaluateName(attacker: String, coordinate: [Int], affiliation: String, gamestate: Gamestate) -> Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        if(coordinate[0] >= 0 && coordinate[0] <= 7 && coordinate[1] >= 0 && coordinate[1] <= 7) {
            
            if (tschessElementMatrix[coordinate[0]][coordinate[1]] != nil) {
                
                let occupant = tschessElementMatrix[coordinate[0]][coordinate[1]]!
                
                if(affiliation != occupant.affiliation) {
                    let name = occupant.name
                    
                    if (name.contains(attacker)) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
}
