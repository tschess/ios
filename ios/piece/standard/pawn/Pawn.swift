//
//  Pawn.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Pawn: Piece {
    
    init(
        name: String = "Pawn",
        imageDefault: UIImage = UIImage(named: "red_pawn")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
    ) {
        super.init(
            name: name,
            strength: "1",
            affiliation: affiliation,
            imageDefault: imageDefault,
            standard: true,
            attackVectorList: Array<String>(["Pawn"]),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    public override func validate(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        if(advanceOne(present: present, proposed: proposed, state: state)) {
            return true
        }
        if(advanceTwo(present: present, proposed: proposed, state: state)) {
            return true
        }
        if(attack(present: present, proposed: proposed, state: state)) {
            return true
        }
        return false
    }
    
    public func advanceOne(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()

        if((present[0] - 1) - proposed[0] == 0 && (present[1] - proposed[1] == 0)) {
            if(state[present[0] - 1][present[1]] != nil) {
                if(state[present[0] - 1][present[1]]!.name == "PieceAnte") {
                    return true
                }
                return false
            }
            return true
        }
        return false
    }
    
    public func advanceTwo(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        if(!self.firstTouch){
            return false
        }
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()

        if((present[0] - 2) - proposed[0] == 0 && (present[1] - proposed[1] == 0)) {

            if(state[present[0] - 2][present[1]] != nil) {
                if(state[present[0] - 2][present[1]]!.name != "PieceAnte") {
                    return false
                }
            } //it IS nil (2) ...
            if(state[present[0] - 1][present[1]] != nil) {
                if(state[present[0] - 1][present[1]]!.name != "PieceAnte") {
                    return false
                }
            } //it IS nil (1)
            //either they're both legal move or they're both nil...
            return state[present[0]][present[1]]!.firstTouch
        }
        return false
    }
    
    public func attack(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 1) - proposed[0] == 0 && ((present[1] + 1) - proposed[1] == 0)) {
            if(state[present[0] - 1][present[1] + 1] != nil) {
                if(state[present[0] - 1][present[1] + 1]!.name != "PieceAnte") {
                    return state[present[0] - 1][present[1] + 1]!.affiliation !=
                        state[present[0]][present[1]]!.affiliation
                }
            }
        }
        if((present[0] - 1) - proposed[0] == 0 && ((present[1] - 1) - proposed[1] == 0)) {
            if(state[present[0] - 1][present[1] - 1] != nil) {
                if(state[present[0] - 1][present[1] - 1]!.name != "PieceAnte") {
                    return state[present[0] - 1][present[1] - 1]!.affiliation !=
                        state[present[0]][present[1]]!.affiliation
                }
            }
        }
        return false
    }
    
}
