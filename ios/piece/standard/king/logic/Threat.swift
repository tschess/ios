//
//  Threat.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class Threat {
    
    let evaluation = Evaluation()
    
    let pawnOffense = PawnOffense()
    let knightOffense = KnightOffense()
    let kingOffense = KingOffense()
    let hopperOffense = HopperOffense()
    
    func evaluate(present: [Int], proposed: [Int], state: [[Piece?]]) -> Bool {
        
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let affiliation = state[present[0]][present[1]]!.affiliation
        
        if(hopperOffense.threat(present: present, proposed: proposed, state: state, affiliation: "FUCK")){
            return true
        }
        
        if(knightOffense.evaluate(coordinate: proposed, affiliation: affiliation, state: state)){
            return true
        }
        
        if (kingOffense.minusMinus(coordinate: proposed, affiliation: affiliation, state: state)){
            return true
        }
        
        if (kingOffense.minusPlus(coordinate: proposed, affiliation: affiliation, state: state)){
            return true
        }
        
        if (kingOffense.plusMinus(coordinate: proposed, affiliation: affiliation, state: state)){
            return true
        }
        
        if (kingOffense.plusPlus(coordinate: proposed, affiliation: affiliation, state: state)){
            return true
        }
        
        if (kingOffense.zeroMinus(coordinate: proposed, affiliation: affiliation, state: state)){
            return true
        }
        
        if (kingOffense.zeroPlus(coordinate: proposed, affiliation: affiliation, state: state)){
            return true
        }
        
        if (kingOffense.oneMinus(coordinate: proposed, affiliation: affiliation, state: state)){
            return true
        }
        
        if (kingOffense.onePlus(coordinate: proposed, affiliation: affiliation, state: state)){
            return true
        }
        
        /* * */
        
        if (pawnOffense.c0_m1_c1_m1(coordinate: proposed, affiliation: affiliation, state: state)) {
            return true
        }
        
        if (pawnOffense.c0_m1_c1_p1(coordinate: proposed, affiliation: affiliation, state: state)) {
            return true
        }
        
        /* * */
        
        if(evaluation.rowStraightUp(
            present: present,
            proposed: [proposed[0] - 1, proposed[1]],
            affiliation: affiliation,
            state: state,
            threat: true)){
            return true
        }
        if(evaluation.rowStraightDown(
            present: present,
            proposed: [proposed[0] + 1, proposed[1]],
            affiliation: affiliation,
            state: state,
            threat: true)){
            return true
        }
        if(evaluation.columnLeft(
            present: present,
            proposed: [proposed[0], proposed[1] - 1],
            affiliation: affiliation,
            state: state,
            threat: true)){
            return true
        }
        if(evaluation.columnRight(
            present: present,
            proposed: [proposed[0], proposed[1] + 1],
            affiliation: affiliation,
            state: state,
            threat: true)){
            return true
        }
        if(evaluation.diagonalUpRight(
            present: present,
            proposed: [proposed[0] - 1, proposed[1] + 1],
            affiliation: affiliation,
            state: state,
            threat: true)){
            return true
        }
        if(evaluation.diagonalDownLeft(
            present: present,
            proposed: [proposed[0] + 1, proposed[1] - 1],
            affiliation: affiliation,
            state: state,
            threat: true)){
            return true
        }
        if(evaluation.diagonalUpLeft(
            present: present,
            proposed: [proposed[0] - 1, proposed[1] - 1],
            affiliation: affiliation,
            state: state,
            threat: true)){
            return true
        }
        if(evaluation.diagonalDownRight(
            present: present,
            proposed: [proposed[0] + 1, proposed[1] + 1],
            affiliation: affiliation,
            state: state,
            threat: true)){
            return true
        }
        return false
    }
    
}
