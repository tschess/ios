//
//  PawnOffense.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class PawnOffense {
    
    let pawn: String = "Pawn"
    
    func c0_m1_c1_m1(coordinate: [Int], affiliation: String, state: [[Piece?]]) -> Bool {
        if (coordinate[0] - 1 >= 0 && coordinate[1] - 1 >= 0) {
            return evaluateName(attacker: pawn, coordinate: [coordinate[0] - 1, coordinate[1] - 1], affiliation: affiliation, state: state)
        }
        return false
    }
    
    func c0_m1_c1_p1(coordinate: [Int], affiliation: String, state: [[Piece?]]) -> Bool {
        if (coordinate[0] - 1 >= 0 && coordinate[1] + 1 <= 7) {
            return evaluateName(attacker: pawn, coordinate: [coordinate[0] - 1, coordinate[1] + 1], affiliation: affiliation, state: state)
        }
        return false
    }
    
    func evaluateName(attacker: String, coordinate: [Int], affiliation: String, state: [[Piece?]]) -> Bool {
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
