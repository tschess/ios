//
//  BlackPawn.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackPawn: Pawn {
    
    init() {
        super.init(
            name: "BlackPawn",
            imageDefault: UIImage(named: "black_pawn")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_pawn"),
            imageSelection: UIImage(named: "selection_black_pawn")
        )
    }
    
//    override public func validate(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        if(self.canonicalAdvanceOne(present: present, proposed: proposed, gamestate: gamestate)) {
//            return true
//        }
//        if(self.canonicalAdvanceTwo(present: present, proposed: proposed, gamestate: gamestate)) {
//            return true
//        }
//        if(self.canonicalAttack(present: present, proposed: proposed, gamestate: gamestate)) {
//            return true
//        }
//        return false
//    }
    
//    public func canonicalAdvanceOne(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        let coordinate0: Bool = ((present[0] + 1) - proposed[0]) == 0
//        let coordinate1: Bool = (present[1] - proposed[1]) == 0
//        if(!coordinate0 || !coordinate1){
//            return false
//        }
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        let tschessElement = tschessElementMatrix[proposed[0]][proposed[1]]
//        
//        var vacant: Bool = false
//        if(tschessElement == nil){
//            vacant = true
//        }
//        var legalMove: Bool = false
//        if(!vacant){
//            if(tschessElement!.name == "LegalMove"){
//                legalMove = true
//            }
//        }
//        if(!vacant && !legalMove){
//            return false
//        }
//        return true
//    }
    
//    public func canonicalAdvanceTwo(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        if(present[0] != 1){
//            return false
//        }
//        let coordinate0: Bool = ((present[0] + 2) - proposed[0]) == 0
//        let coordinate1: Bool = (present[1] - proposed[1]) == 0
//        if(!coordinate0 || !coordinate1){
//            return false
//        }
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        
//        let tschessElement2 = tschessElementMatrix[proposed[0]][proposed[1]]
//        var vacant2: Bool = false
//        if(tschessElement2 == nil){
//            vacant2 = true
//        }
//        var legalMove2: Bool = false
//        if(!vacant2){
//            if(tschessElement2!.name == "LegalMove"){
//                legalMove2 = true
//            }
//        }
//        if(!vacant2 && !legalMove2){
//            return false
//        }
//        
//        let tschessElement1 = tschessElementMatrix[present[0] + 1][proposed[1]]
//        var vacant1: Bool = false
//        if(tschessElement1 == nil){
//            vacant1 = true
//        }
//        var legalMove1: Bool = false
//        if(!vacant1){
//            if(tschessElement1!.name == "LegalMove"){
//                legalMove1 = true
//            }
//        }
//        if(!vacant1 && !legalMove1){
//            return false
//        }
//        
//        return tschessElementMatrix[present[0]][present[1]]!.firstTouch
//    }
    
//    public func canonicalAttack(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
//        let tschessElementMatrix = gamestate.getTschessElementMatrix()
//        let tschessElement = tschessElementMatrix[proposed[0]][proposed[1]]
//        if(tschessElement == nil) {
//            return false
//        }
//        if(tschessElement!.name == "LegalMove") {
//            return false
//        }
//        if(tschessElement!.affiliation == "BLACK"){
//            return false
//        }
//        let coordinate0: Bool = ((present[0] + 1) - proposed[0]) == 0
//        let coordinate1_plus: Bool = ((present[1] + 1) - proposed[1]) == 0
//        let coordinate1_minus: Bool = ((present[1] - 1) - proposed[1]) == 0
//        
//        if(coordinate0 && coordinate1_plus) {
//            return true
//        }
//        if(coordinate0 && coordinate1_minus) {
//            return true
//        }
//        return false
//    }
}
