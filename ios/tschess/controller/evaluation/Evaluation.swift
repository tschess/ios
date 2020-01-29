//
//  Evaluation.swift
//  ios
//
//  Created by Matthew on 8/10/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class Evaluation {
    
    let kingMovement = KingMovement()
    
    func rowStraightDown(present: [Int], proposed: [Int], affiliation: String, gamestate: Gamestate, threat: Bool) -> Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        if (proposed[0] <= 7) {
            if (tschessElementMatrix[proposed[0]][proposed[1]] != nil) {
                return evaluateAttackVector(
                    present: present,
                    proposed: proposed,
                    affiliation: affiliation,
                    vector: "HorizontalVertical",
                    gamestate: gamestate,
                    threat: threat)
            }
            let coordinate0 = proposed[0] + 1
            let coordinate1 = proposed[1]
            return rowStraightDown(
                present: present,
                proposed: [coordinate0, coordinate1],
                affiliation: affiliation,
                gamestate: gamestate,
                threat: threat)
        }
        return false
    }
    
    func rowStraightUp(present: [Int], proposed: [Int], affiliation: String, gamestate: Gamestate, threat: Bool) -> Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        if (proposed[0] >= 0) {
            
            if (tschessElementMatrix[proposed[0]][proposed[1]] != nil) {
                return evaluateAttackVector(
                    present: present,
                    proposed: proposed,
                    affiliation: affiliation,
                    vector: "HorizontalVertical",
                    gamestate: gamestate,
                    threat: threat)
            }
            let coordinate0 = proposed[0] - 1
            let coordinate1 = proposed[1]
            return rowStraightUp(
                present: present,
                proposed: [coordinate0, coordinate1],
                affiliation: affiliation,
                gamestate: gamestate,
                threat: threat)
        }
        return false
    }
    
        func diagonalDownRight(present: [Int], proposed: [Int], affiliation: String, gamestate: Gamestate, threat: Bool) -> Bool {
            let tschessElementMatrix = gamestate.getTschessElementMatrix()
    
            if (proposed[0] <= 7 && proposed[1] <= 7) {
                if (tschessElementMatrix[proposed[0]][proposed[1]] != nil) {
                    return evaluateAttackVector(
                        present: present,
                        proposed: proposed,
                        affiliation: affiliation,
                        vector: "Diagonal",
                        gamestate: gamestate,
                        threat: threat)
                }
                let coordinate0 = proposed[0] + 1
                let coordinate1 = proposed[1] + 1
                return diagonalDownRight(
                    present: present,
                    proposed: [coordinate0, coordinate1],
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)
            }
            return false
        }
    
        func diagonalDownLeft(present: [Int], proposed: [Int], affiliation: String, gamestate: Gamestate, threat: Bool) -> Bool {
            let tschessElementMatrix = gamestate.getTschessElementMatrix()
    
            if (proposed[0] <= 7 && proposed[1] >= 0) {
                if (tschessElementMatrix[proposed[0]][proposed[1]] != nil) {
                    return evaluateAttackVector(
                        present: present,
                        proposed: proposed,
                        affiliation: affiliation,
                        vector: "Diagonal",
                        gamestate: gamestate,
                        threat: threat)
                }
                let coordinate0 = proposed[0] + 1
                let coordinate1 = proposed[1] - 1
                return diagonalDownLeft(
                    present: present,
                    proposed: [coordinate0, coordinate1],
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)
            }
            return false
        }
    
        func diagonalUpLeft(present: [Int], proposed: [Int], affiliation: String, gamestate: Gamestate, threat: Bool) -> Bool {
            let tschessElementMatrix = gamestate.getTschessElementMatrix()
    
            if (proposed[0] >= 0 && proposed[1] >= 0) {
                if (tschessElementMatrix[proposed[0]][proposed[1]] != nil) {
                    return evaluateAttackVector(
                        present: present,
                        proposed: proposed,
                        affiliation: affiliation,
                        vector: "Diagonal",
                        gamestate: gamestate,
                        threat: threat)
                }
                let coordinate0 = proposed[0] - 1
                let coordinate1 = proposed[1] - 1
                return diagonalUpLeft(
                    present: present,
                    proposed: [coordinate0, coordinate1],
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)
            }
            return false
        }
    
        func diagonalUpRight(present: [Int], proposed: [Int], affiliation: String, gamestate: Gamestate, threat: Bool) -> Bool {
            let tschessElementMatrix = gamestate.getTschessElementMatrix()
    
            if (proposed[0] >= 0 && proposed[1] <= 7) {
    
                if (tschessElementMatrix[proposed[0]][proposed[1]] != nil) {
                    return evaluateAttackVector(
                        present: present,
                        proposed: proposed,
                        affiliation: affiliation,
                        vector: "Diagonal",
                        gamestate: gamestate,
                        threat: threat)
                }
                let coordinate0 = proposed[0] - 1
                let coordinate1 = proposed[1] + 1
                return diagonalUpRight(
                    present: present,
                    proposed: [coordinate0, coordinate1],
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)
            }
            return false
        }
    
        func columnLeft(present: [Int], proposed: [Int], affiliation: String, gamestate: Gamestate, threat: Bool) -> Bool {
            let tschessElementMatrix = gamestate.getTschessElementMatrix()
    
            if (proposed[1] >= 0) {
                if (tschessElementMatrix[proposed[0]][proposed[1]] != nil) {
                    return evaluateAttackVector(
                        present: present,
                        proposed: proposed,
                        affiliation: affiliation,
                        vector: "HorizontalVertical",
                        gamestate: gamestate,
                        threat: threat)
                }
                let coordinate0 = proposed[0]
                let coordinate1 = proposed[1] - 1
                return columnLeft(
                    present: present,
                    proposed: [coordinate0, coordinate1],
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)
            }
            return false
        }
    
    func columnRight(present: [Int], proposed: [Int], affiliation: String, gamestate: Gamestate, threat: Bool) -> Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        if (proposed[1] <= 7) {
            if (tschessElementMatrix[proposed[0]][proposed[1]] != nil) {
                return evaluateAttackVector(
                    present: present,
                    proposed: proposed,
                    affiliation: affiliation,
                    vector: "HorizontalVertical",
                    gamestate: gamestate,
                    threat: threat)
            }
            let coordinate0 = proposed[0]
            let coordinate1 = proposed[1] + 1
            return columnRight(
                present: present,
                proposed: [coordinate0, coordinate1],
                affiliation: affiliation,
                gamestate: gamestate,
                threat: threat)
        }
        return false
    }
    
    func evaluateAttackVector(present: [Int], proposed: [Int], affiliation: String, vector: String, gamestate: Gamestate, threat: Bool) -> Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let occupant = tschessElementMatrix[proposed[0]][proposed[1]]!
        
        if(affiliation != occupant.affiliation) {
            
            let attackVectorList = occupant.attackVectorList
            
            for attackVector in attackVectorList {
                if vector.contains(attackVector) {
                    if(threat){
                        return true
                    } else if(!kingMovement.movement(present: present, proposed: proposed)) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func evaluateAttackVector(coordinate: [Int], affiliation: String, vector: String, gamestate: Gamestate) -> Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        
        if(coordinate[0] >= 0 && coordinate[0] <= 7 && coordinate[1] >= 0 && coordinate[1] <= 7) {
            
            if (tschessElementMatrix[coordinate[0]][coordinate[1]] != nil) {
                
                let occupant = tschessElementMatrix[coordinate[0]][coordinate[1]]!
                
                if(affiliation != occupant.affiliation) {
                    
                    let attackVectorList = occupant.attackVectorList
                    
                    for attackVector in attackVectorList {
                        if vector.contains(attackVector) {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
}



