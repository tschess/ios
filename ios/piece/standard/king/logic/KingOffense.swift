//
//  KingOffense.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class KingOffense {
    
    let king: String = "King"
    
    func minusMinus(coordinate: [Int], affiliation: String, state: [[Piece?]]) -> Bool {
        if (coordinate[0] - 1 >= 0 && coordinate[1] - 1 >= 0) {
            return evaluateName(attacker: king, coordinate: [coordinate[0] - 1, coordinate[1] - 1], affiliation: affiliation, state: state)
        }
        return false
    }

    func minusPlus(coordinate: [Int], affiliation: String,  state: [[Piece?]]) -> Bool {
        if (coordinate[0] - 1 >= 0 && coordinate[1] + 1 <= 7) {
            return evaluateName(attacker: king, coordinate: [coordinate[0] - 1, coordinate[1] + 1], affiliation: affiliation, state: state)
        }
        return false
    }

    func plusMinus(coordinate: [Int], affiliation: String,  state: [[Piece?]]) -> Bool {
        if (coordinate[0] + 1 <= 7 && coordinate[1] - 1 >= 0) {
            return evaluateName(attacker: king, coordinate: [coordinate[0] + 1, coordinate[1] - 1], affiliation: affiliation, state: state)
        }
        return false
    }

    func plusPlus(coordinate: [Int], affiliation: String,  state: [[Piece?]]) -> Bool {
        if (coordinate[0] + 1 <= 7 && coordinate[1] + 1 <= 7) {
            return evaluateName(attacker: king, coordinate: [coordinate[0] + 1, coordinate[1] + 1], affiliation: affiliation, state: state)
        }
        return false
    }

    func zeroMinus(coordinate: [Int], affiliation: String,  state: [[Piece?]]) -> Bool {
        if (coordinate[0] - 1 >= 0) {
            return evaluateName(attacker: king, coordinate: [coordinate[0] - 1, coordinate[1]], affiliation: affiliation, state: state)
        }
        return false
    }

    func zeroPlus(coordinate: [Int], affiliation: String,  state: [[Piece?]]) -> Bool {
        if (coordinate[0] + 1 <= 7) {
            return evaluateName(attacker: king, coordinate: [coordinate[0] + 1, coordinate[1]], affiliation: affiliation, state: state)
        }
        return false
    }

    func oneMinus(coordinate: [Int], affiliation: String,  state: [[Piece?]]) -> Bool {
        if (coordinate[1] - 1 <= 7) {
            return evaluateName(attacker: king, coordinate: [coordinate[0], coordinate[1] - 1], affiliation: affiliation, state: state)
        }
        return false
    }

    func onePlus(coordinate: [Int], affiliation: String, state: [[Piece?]]) -> Bool {
        if (coordinate[1] + 1 <= 7) {
            return evaluateName(attacker: king, coordinate: [coordinate[0], coordinate[1] + 1], affiliation: affiliation, state: state)
        }
        return false
    }
    
    func evaluateName(attacker: String, coordinate: [Int], affiliation: String,  state: [[Piece?]]) -> Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        if(coordinate[0] >= 0 && coordinate[0] <= 7 && coordinate[1] >= 0 && coordinate[1] <= 7) {
            
            if (state[coordinate[0]][coordinate[1]] != nil) {
                
                let occupant = state[coordinate[0]][coordinate[1]]!
                
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
