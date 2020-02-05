//
//  Diagonal.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class Diagonal {
    
    func recurseInto(coordinate: [Int], direction: [Int], state: [[Piece?]]) -> Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()

        if(bounded(coordinate: [coordinate[0], direction[0]]) && bounded(coordinate: [coordinate[1], direction[1]])) {
            if (abs(direction[0]) <= 1 && abs(direction[1]) <= 1) {
                if(state[coordinate[0] + direction[0]][coordinate[1] + direction[1]] != nil) {
                    if(state[coordinate[0] + direction[0]][coordinate[1] + direction[1]]!.name == "PieceAnte") {
                        return true
                    }
                    return false
                }
                return true
            }
            if (state[coordinate[0] + direction[0]][coordinate[1] + direction[1]] == nil ||
                state[coordinate[0] + direction[0]][coordinate[1] + direction[1]]!.name == "PieceAnte") {
                var displacementRow = 0
                if(direction[0] != 0) {
                    displacementRow = direction[0] < 0 ? direction[0] + 1 : direction[0] - 1
                }
                var displacementColumn = 0
                if(direction[1] != 0) {
                    displacementColumn = direction[1] < 0 ? direction[1] + 1 : direction[1] - 1
                }
                return recurseInto(coordinate: coordinate, direction: [displacementRow, displacementColumn], state: state)
            }
        }
        return false
    }
    
    func forSearchCriteria(present: [Int], proposed: [Int], directionA: [Int], directionB: [Int], state: [[Piece?]]) -> Bool {
        if (equivalentMagnitude(directionA: directionA, directionB: directionB) && operatorInRange(directionA: directionA, directionB: directionB)) {
            return recurseInto(coordinate: present, direction: directionB, state: state)
        }
        return false
    }
    
    func equivalentMagnitude(directionA: [Int], directionB: [Int]) -> Bool {
        return directionA[0] * directionB[0] == directionA[1] * directionB[1]
    }
    
    func operatorInRange(directionA: [Int], directionB: [Int]) -> Bool {
        return (directionA[0] * directionB[0]) >= 1 && (directionA[0] * directionB[0]) <= 6 &&
               (directionA[1] * directionB[1]) >= 1 && (directionA[1] * directionB[1]) <= 6
    }
    
    func bounded(coordinate: [Int]) -> Bool {
        return coordinate[0] + coordinate[1] >= 0 && coordinate[0] + coordinate[1] <= 7
    }
    
    func operatorIsZero(coordinate: [Int]) -> Bool {
        return coordinate[0] == 0 && coordinate[1] == 0
    }
    
    func plusPlus(present: [Int], proposed: [Int], state: [[Piece?]]) -> Bool {
        return validator(directionA: [+1, +1], present: present, proposed: proposed, state: state)
    }
    
    func minusPlus(present: [Int], proposed: [Int], state: [[Piece?]]) -> Bool {
        return validator(directionA: [-1, +1], present: present, proposed: proposed, state: state)
    }
    
    func plusMinus(present: [Int], proposed: [Int], state: [[Piece?]]) -> Bool {
        return validator(directionA: [+1, -1], present: present, proposed: proposed, state: state)
    }
    
    func minusMinus(present: [Int], proposed: [Int], state: [[Piece?]]) -> Bool {
        return validator(directionA: [-1, -1], present: present, proposed: proposed, state: state)
    }
    
    func validator(directionA: [Int], present: [Int], proposed: [Int], state: [[Piece?]]) -> Bool {
        let displacementRow = proposed[0] - present[0] - directionA[0]
        let displacementColumn = proposed[1] - present[1] - directionA[1]
        let directionB = [displacementRow, displacementColumn]
        if (operatorIsZero(coordinate: directionB)) {
            return true;
        }
        return forSearchCriteria(present: present, proposed: proposed, directionA: directionA, directionB: directionB, state: state)
    }
    
}
