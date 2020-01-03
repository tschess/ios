//
//  BlackHunter.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackHunter: Hunter {
    
    init() {
        super.init(
            name: "BlackHunter",
            imageDefault: UIImage(named: "black_hunter")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_hunter"),
            imageSelection: UIImage(named: "selection_black_hunter")
        )
    }
    
    override public func validate(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        // forward bishop moves...
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        if(diagonal.plusPlus(present: present, proposed: proposed, gamestate: gamestate)){
            if(tschessElementMatrix[proposed[0]][proposed[1]] == nil){
                return true
            } else {
                return tschessElementMatrix[present[0]][present[1]]!.affiliation !=
                    tschessElementMatrix[proposed[0]][proposed[1]]!.affiliation
            }
        }
        if(diagonal.plusMinus(present: present, proposed: proposed, gamestate: gamestate)){
            if(tschessElementMatrix[proposed[0]][proposed[1]] == nil){
                return true
            } else {
                return tschessElementMatrix[present[0]][present[1]]!.affiliation !=
                    tschessElementMatrix[proposed[0]][proposed[1]]!.affiliation
            }
        }
        // backwards knight moves...
        if(Knight().minusTwo_minusOne(present: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        if(Knight().minusTwo_plusOne(present: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        if(Knight().minusOne_minusTwo(present: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        if(Knight().minusOne_plusTwo(present: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        return false
    }
}
