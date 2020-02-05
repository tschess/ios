//
//  Hunter.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Hunter: Fairy {
    
    let diagonal = Diagonal()
    
    init(
        name: String = "Hunter",
        imageDefault: UIImage = UIImage(named: "red_hunter")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "6",
            affiliation: affiliation,
            description: "moves forward as bishop. moves backward as a knight.",
            imageDefault: imageDefault,
            attackVectorList: Array<String>(["Diagonal", "Knight"]),
            tschxValue: String(4),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    
    public override func validate(present: [Int], proposed: [Int], state: [[Piece?]]) -> Bool {
        
            // forward bishop moves...
            
            if(diagonal.minusPlus(present: present, proposed: proposed, state: state)){
                if(state[proposed[0]][proposed[1]] == nil){
                    return true
                } else {
                    return state[present[0]][present[1]]!.affiliation !=
                        state[proposed[0]][proposed[1]]!.affiliation
                }
            }
            if(diagonal.minusMinus(present: present, proposed: proposed, state: state)){
                if(state[proposed[0]][proposed[1]] == nil){
                    return true
                } else {
                    return state[present[0]][present[1]]!.affiliation !=
                        state[proposed[0]][proposed[1]]!.affiliation
                }
            }
            // backwards knight moves...
            if(plusTwo_minusOne(present: present, proposed: proposed, state: state)){
                return true
            }
            if(plusTwo_plusOne(present: present, proposed: proposed, state: state)){
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
    
    public func plusTwo_minusOne(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] + 2) - proposed[0] == 0 && (present[1] - 1) - proposed[1] == 0){
            if(state[present[0] + 2][present[1] - 1] != nil) {
                return state[present[0] + 2][present[1] - 1]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }

    public func plusTwo_plusOne(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] + 2) - proposed[0] == 0 && (present[1] + 1) - proposed[1] == 0){
            if(state[present[0] + 2][present[1] + 1] != nil) {
                return state[present[0] + 2][present[1] + 1]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public func plusOne_minusTwo(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] + 1) - proposed[0] == 0 && (present[1] - 2) - proposed[1] == 0){
            if(state[present[0] + 1][present[1] - 2] != nil) {
                return state[present[0] + 1][present[1] - 2]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    
    public func plusOne_plusTwo(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] + 1) - proposed[0] == 0 && (present[1] + 2) - proposed[1] == 0){
            if(state[present[0] + 1][present[1] + 2] != nil) {
                return state[present[0] + 1][present[1] + 2]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    //    // minusTwo_minusOne
    //    if (coordinate[0] - 2 >= 0 && coordinate[1] - 1 >= 0) {
    //        if(evaluateName(attacker: knight, coordinate: [coordinate[0] - 2, coordinate[1] - 1], affiliation: affiliation, gamestate: gamestate)){
    //            return true;
    //        }
    //    }
    public func minusTwo_minusOne(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 2) - proposed[0] == 0 && (present[1] - 1) - proposed[1] == 0){
            if(state[present[0] - 2][present[1] - 1] != nil) {
                return state[present[0] - 2][present[1] - 1]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }

    //    // minusTwo_plusOne
    //    if (coordinate[0] - 2 >= 0 && coordinate[1] + 1 >= 0) {
    //        if(evaluateName(attacker: knight, coordinate: [coordinate[0] - 2, coordinate[1] - 1], affiliation: affiliation, gamestate: gamestate)){
    //            return true;
    //        }
    //    }
    public func minusTwo_plusOne(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 2) - proposed[0] == 0 && (present[1] + 1) - proposed[1] == 0){
            if(state[present[0] - 2][present[1] + 1] != nil) {
                return state[present[0] - 2][present[1] + 1]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
  
    //    // minusOne_minusTwo
    //    if (coordinate[0] - 1 >= 0 && coordinate[1] - 2 >= 0) {
    //        if(evaluateName(attacker: knight, coordinate: [coordinate[0] - 2, coordinate[1] - 1], affiliation: affiliation, gamestate: gamestate)){
    //            return true;
    //        }
    //    }
    public func minusOne_minusTwo(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 1) - proposed[0] == 0 && (present[1] - 2) - proposed[1] == 0){
            if(state[present[0] - 1][present[1] - 2] != nil) {
                return state[present[0] - 1][present[1] - 2]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
    public func minusOne_plusTwo(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        //let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if((present[0] - 1) - proposed[0] == 0 && (present[1] + 2) - proposed[1] == 0){
            if(state[present[0] - 1][present[1] + 2] != nil) {
                return state[present[0] - 1][present[1] + 2]!.affiliation !=
                    state[present[0]][present[1]]!.affiliation
            }
            return true
        }
        return false
    }
    
}
