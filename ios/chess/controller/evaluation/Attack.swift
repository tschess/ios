//
//  Attack.swift
//  ios
//
//  Created by Matthew on 8/10/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class Attack {
    
    let evaluation = Evaluation()
    
    let pawnOffense = PawnOffense()
    
    func rowStraightDown(rowStraightDown: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(rowStraightDown == proposed){
            return evaluation.rowStraightDown(
                present: present,
                proposed: proposed,
                affiliation: affiliation,
                gamestate: gamestate,
                threat: threat)
        }
        return false
    }
    
    func rowStraightDown_lookBehind(rowStraightDown_lookBehind: [Int], rowStraightDown: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(rowStraightDown_lookBehind == proposed){
            if (rowStraightDown_lookBehind[0] >= 0) {
                if (evaluation.rowStraightDown(
                    present: present,
                    proposed: rowStraightDown,
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)) {
                    return true
                }
                return evaluation.evaluateAttackVector(
                    coordinate: rowStraightDown,
                    affiliation: affiliation,
                    vector: "HorizontalVertical",
                    gamestate: gamestate)
            }
        }
        return false
    }

    func rowStraightUp(rowStraightUp: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(rowStraightUp == proposed){
            return evaluation.rowStraightUp(
                present: present,
                proposed: proposed,
                affiliation: affiliation,
                gamestate: gamestate,
                threat: threat)
        }
        return false
    }

    func rowStraightUp_lookBehind(rowStraightUp_lookBehind: [Int], rowStraightUp: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(rowStraightUp_lookBehind == proposed){
            if (rowStraightUp_lookBehind[0] <= 7) {
                if (evaluation.rowStraightUp(
                    present: present,
                    proposed: rowStraightUp,
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)) {
                    return true
                }
                return evaluation.evaluateAttackVector(
                    coordinate: rowStraightUp,
                    affiliation: affiliation,
                    vector: "HorizontalVertical",
                    gamestate: gamestate)
            }
        }
        return false
    }

    func columnLeft(columnLeft: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(columnLeft == proposed){
            return evaluation.columnLeft(
                present: present,
                proposed: columnLeft,
                affiliation: affiliation,
                gamestate: gamestate,
                threat: threat)
        }
        return false
    }

    func columnLeft_lookBehind(columnLeft_lookBehind: [Int], columnLeft: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(columnLeft_lookBehind == proposed){
            if (columnLeft_lookBehind[1] <= 7) {
                if (evaluation.columnLeft(
                    present: present,
                    proposed: columnLeft,
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)) {
                    return true
                }
                return evaluation.evaluateAttackVector(
                    coordinate: columnLeft,
                    affiliation: affiliation,
                    vector: "HorizontalVertical",
                    gamestate: gamestate)
            }
        }
        return false
    }

    func columnRight(columnRight: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(columnRight == proposed){
            return evaluation.columnRight(
                present: present,
                proposed: columnRight,
                affiliation: affiliation,
                gamestate: gamestate,
                threat: threat)
        }
        return false
    }

    func columnRight_lookBehind(columnRight_lookBehind: [Int], columnRight: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(columnRight_lookBehind == proposed){
            if (columnRight_lookBehind[1] >= 0) {
                if (evaluation.columnRight(
                    present: present,
                    proposed: columnRight,
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)) {
                    return true
                }
                return evaluation.evaluateAttackVector(
                    coordinate: columnRight,
                    affiliation: affiliation,
                    vector: "HorizontalVertical",
                    gamestate: gamestate)
            }
        }
        return false
    }

    func diagonalUpRight(diagonalUpRight: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(diagonalUpRight == proposed){
            return evaluation.diagonalUpRight(
                present: present,
                proposed: diagonalUpRight,
                affiliation: affiliation,
                gamestate: gamestate,
                threat: threat)
        }
        return false
    }

    func diagonalUpRight_lookBehind(diagonalUpRight_lookBehind: [Int], diagonalUpRight: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(diagonalUpRight_lookBehind == proposed){
            if (diagonalUpRight_lookBehind[0] >= 0 && diagonalUpRight_lookBehind[1] <= 7) {
                if (evaluation.diagonalUpRight(
                    present: present,
                    proposed: diagonalUpRight,
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)) {
                    return true
                }
                return evaluation.evaluateAttackVector(
                    coordinate: diagonalUpRight,
                    affiliation: affiliation,
                    vector: "Diagonal",
                    gamestate: gamestate)
            }
        }
        return false
    }

    func diagonalDownLeft(diagonalDownLeft: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(diagonalDownLeft == proposed){
            return evaluation.diagonalDownLeft(
                present: present,
                proposed: diagonalDownLeft,
                affiliation: affiliation,
                gamestate: gamestate,
                threat: threat)
        }
        return false
    }

    func diagonalDownLeft_lookBehind(diagonalDownLeft_lookBehind: [Int], diagonalDownLeft: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(diagonalDownLeft_lookBehind == proposed){
            if (diagonalDownLeft_lookBehind[0] <= 7 && diagonalDownLeft_lookBehind[1] >= 0) {
                if (evaluation.diagonalDownLeft(
                    present: present,
                    proposed: diagonalDownLeft,
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)) {
                    return true
                }
                return evaluation.evaluateAttackVector(
                    coordinate: diagonalDownLeft,
                    affiliation: affiliation,
                    vector: "Diagonal",
                    gamestate: gamestate)
            }
        }
        return false
    }

    func diagonalUpLeft(diagonalUpLeft: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(diagonalUpLeft == proposed){
            return evaluation.diagonalUpLeft(
                present: present,
                proposed: diagonalUpLeft,
                affiliation: affiliation,
                gamestate: gamestate,
                threat: threat)
        }
        return false
    }

    func diagonalUpLeft_lookBehind(diagonalUpLeft_lookBehind: [Int], diagonalUpLeft: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(diagonalUpLeft_lookBehind == proposed){
            if (diagonalUpLeft_lookBehind[0] <= 7 && diagonalUpLeft_lookBehind[1] <= 7) {
                if (evaluation.diagonalUpLeft(
                    present: present,
                    proposed: diagonalUpLeft,
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)) {
                    return true
                }
                return evaluation.evaluateAttackVector(
                    coordinate: diagonalUpLeft,
                    affiliation: affiliation,
                    vector: "Diagonal",
                    gamestate: gamestate)
            }
        }
        return false
    }

    func diagonalDownRight(diagonalDownRight: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(diagonalDownRight == proposed){
            return evaluation.diagonalDownRight(
                present: present,
                proposed: diagonalDownRight,
                affiliation: affiliation,
                gamestate: gamestate,
                threat: threat)
        }
        return false
    }

    func diagonalDownRight_lookBehind(diagonalDownRight_lookBehind: [Int], diagonalDownRight: [Int], affiliation: String, present: [Int], proposed: [Int], gamestate: Gamestate, threat: Bool) -> Bool {
        if(diagonalDownRight_lookBehind == proposed){
            if (diagonalDownRight_lookBehind[0] >= 0 && diagonalDownRight_lookBehind[1] >= 0) {
                if (evaluation.diagonalDownRight(
                    present: present,
                    proposed: diagonalDownRight,
                    affiliation: affiliation,
                    gamestate: gamestate,
                    threat: threat)) {
                    return true
                }
                return evaluation.evaluateAttackVector(
                    coordinate: diagonalDownRight,
                    affiliation: affiliation,
                    vector: "Diagonal",
                    gamestate: gamestate)
            }
        }
        return false
    }

    /* * */

    func evaluate(present: [Int], proposed: [Int], gamestate: Gamestate) -> Bool {
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let affiliation = tschessElementMatrix[present[0]][present[1]]!.affiliation

        let rowStraightDown = [present[0] + 1, present[1]]
        if(self.rowStraightDown(
            rowStraightDown: rowStraightDown,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        let rowStraightDown_lookBehind = [present[0] - 1, present[1]]
        if(self.rowStraightDown_lookBehind(
            rowStraightDown_lookBehind: rowStraightDown_lookBehind,
            rowStraightDown: rowStraightDown,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        //
        let rowStraightUp = [present[0] - 1, present[1]]
        if(self.rowStraightUp(
            rowStraightUp: rowStraightUp,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        let rowStraightUp_lookBehind = [present[0] + 1, present[1]]
        if(self.rowStraightUp_lookBehind(
            rowStraightUp_lookBehind: rowStraightUp_lookBehind,
            rowStraightUp: rowStraightUp,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        //
        let columnLeft = [present[0], present[1] - 1]
        if(self.columnLeft(
            columnLeft: columnLeft,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        let columnLeft_lookBehind = [present[0], present[1] + 1]
        if(self.columnLeft_lookBehind(
            columnLeft_lookBehind: columnLeft_lookBehind,
            columnLeft: columnLeft,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        //
        let columnRight = [present[0], present[1] + 1]
        if(self.columnRight(
            columnRight: columnRight,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        let columnRight_lookBehind = [present[0], present[1] - 1]
        if(self.columnRight_lookBehind(
            columnRight_lookBehind: columnRight_lookBehind,
            columnRight: columnRight,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        //
        let diagonalUpRight = [present[0] - 1, present[1] + 1]
        if(self.diagonalUpRight(
            diagonalUpRight: diagonalUpRight,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        let diagonalUpRight_lookBehind = [present[0] + 1, present[1] - 1]
        if(self.diagonalUpRight_lookBehind(
            diagonalUpRight_lookBehind: diagonalUpRight_lookBehind,
            diagonalUpRight: diagonalUpRight,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        //
        let diagonalDownLeft = [present[0] + 1, present[1] - 1]
        if(self.diagonalDownLeft(
            diagonalDownLeft: diagonalDownLeft,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        let diagonalDownLeft_lookBehind = [present[0] - 1, present[1] + 1]
        if(self.diagonalDownLeft_lookBehind(
            diagonalDownLeft_lookBehind: diagonalDownLeft_lookBehind,
            diagonalDownLeft: diagonalDownLeft,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        //
        let diagonalUpLeft = [present[0] - 1, present[1] - 1]
        if(self.diagonalUpLeft(
            diagonalUpLeft: diagonalUpLeft,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        let diagonalUpLeft_lookBehind = [present[0] + 1, present[1] + 1]
        if(self.diagonalUpLeft_lookBehind(
            diagonalUpLeft_lookBehind: diagonalUpLeft_lookBehind,
            diagonalUpLeft: diagonalUpLeft,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        //
        let diagonalDownRight = [present[0] + 1, present[1] + 1]
        if(self.diagonalDownRight(
            diagonalDownRight: diagonalDownRight,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }
        let diagonalDownRight_lookBehind = [present[0] - 1, present[1] - 1]
        if(self.diagonalDownRight_lookBehind(
            diagonalDownRight_lookBehind: diagonalDownRight_lookBehind,
            diagonalDownRight: diagonalDownRight,
            affiliation: affiliation,
            present: present,
            proposed: proposed,
            gamestate: gamestate,
            threat: false)){
            return true
        }

        return false
    }
    
}
