//
//  Knight.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Knight: Piece {
    
    init(
        name: String = "Knight",
        imageDefault: UIImage = UIImage(named: "red_knight")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "3",
            affiliation: affiliation,
            imageDefault: imageDefault,
            standard: true,
            attackVectorList: Array<String>(["Knight"]),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    public override func validate(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        if(minusTwo_minusOne(present: present, proposed: proposed, state: state)){
            return true
        }
        if(minusTwo_plusOne(present: present, proposed: proposed, state: state)){
            return true
        }
        if(plusTwo_minusOne(present: present, proposed: proposed, state: state)){
            return true
        }
        if(plusTwo_plusOne(present: present, proposed: proposed, state: state)){
            return true
        }
        if(minusOne_minusTwo(present: present, proposed: proposed, state: state)){
            return true
        }
        if(minusOne_plusTwo(present: present, proposed: proposed, state: state)){
            return true
        }
        if(plusOne_minusTwo(present: present, proposed: proposed, state: state)){
            return true
        }
        if(plusOne_plusTwo(present: present, proposed: proposed, state: state)){
            return true
        }

        return false
    }
    
    public func minusTwo_minusOne(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 2) - proposed[0] == 0 && (present[1] - 1) - proposed[1] == 0) {
            if(state[present[0] - 2][present[1] - 1] != nil) {
                if(state[present[0] - 2][present[1] - 1]!.name == "PieceAnte") {
                    return true
                }
                return state[present[0] - 2][present[1] - 1]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public func minusTwo_plusOne(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 2) - proposed[0] == 0 && (present[1] + 1) - proposed[1] == 0) {
            if(state[present[0] - 2][present[1] + 1] != nil) {
                if(state[present[0] - 2][present[1] + 1]!.name == "PieceAnte") {
                    return true
                }
                return state[present[0] - 2][present[1] + 1]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public func plusTwo_minusOne(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] + 2) - proposed[0] == 0 && (present[1] - 1) - proposed[1] == 0) {
            if(state[present[0] + 2][present[1] - 1] != nil) {
                if(state[present[0] + 2][present[1] - 1]!.name == "PieceAnte") {
                    return true
                }
                return state[present[0] + 2][present[1] - 1]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public func plusTwo_plusOne(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] + 2) - proposed[0] == 0 && (present[1] + 1) - proposed[1] == 0) {
            if(state[present[0] + 2][present[1] + 1] != nil) {
                if(state[present[0] + 2][present[1] + 1]!.name == "PieceAnte") {
                    return true
                }
                return state[present[0] + 2][present[1] + 1]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    
    public func minusOne_minusTwo(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 1) - proposed[0] == 0 && (present[1] - 2) - proposed[1] == 0) {
            if(state[present[0] - 1][present[1] - 2] != nil) {
                if(state[present[0] - 1][present[1] - 2]!.name == "PieceAnte") {
                    return true
                }
                return state[present[0] - 1][present[1] - 2]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    
    public func minusOne_plusTwo(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 1) - proposed[0] == 0 && (present[1] + 2) - proposed[1] == 0) {
            if(state[present[0] - 1][present[1] + 2] != nil) {
                if(state[present[0] - 1][present[1] + 2]!.name == "PieceAnte") {
                    return true
                }
                return state[present[0] - 1][present[1] + 2]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public func plusOne_minusTwo(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] + 1) - proposed[0] == 0 && (present[1] - 2) - proposed[1] == 0) {
            if(state[present[0] + 1][present[1] - 2] != nil) {
                if(state[present[0] + 1][present[1] - 2]!.name == "PieceAnte") {
                    return true
                }
                return state[present[0] + 1][present[1] - 2]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public func plusOne_plusTwo(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] + 1) - proposed[0] == 0 && (present[1] + 2) - proposed[1] == 0) {
            if(state[present[0] + 1][present[1] + 2] != nil) {
                if(state[present[0] + 1][present[1] + 2]!.name == "PieceAnte") {
                    return true
                }
                return state[present[0] + 1][present[1] + 2]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    

}
