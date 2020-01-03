//
//  BlackArrow.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackArrowPawn: ArrowPawn {
    
    init() {
        super.init(
            name: "BlackArrowPawn",
            imageDefault: UIImage(named: "black_arrow")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_arrow"),
            imageSelection: UIImage(named: "selection_black_arrow")
        )
    }
    
    override public func validate(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        if(BlackPawn().canonicalAttack(present: present, proposed: proposed, gamestate: gamestate)) {
            return true
        }
        if(ArrowPawn().zeroPlus(present: present, proposed: proposed, gamestate: gamestate)) {
            return true
        }
        if(ArrowPawn().zeroMinus(present: present, proposed: proposed, gamestate: gamestate)) {
            return true
        }
        if(ArrowPawn().onePlus(present: present, proposed: proposed, gamestate: gamestate)) {
            return true
        }
        if(ArrowPawn().oneMinus(present: present, proposed: proposed, gamestate: gamestate)) {
            return true
        }
        return false
    }
}
