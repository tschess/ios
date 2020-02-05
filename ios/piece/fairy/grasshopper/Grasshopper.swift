//
//  Grasshopper.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Grasshopper: Fairy {
    
    let hopper = Hopper()
    
    init(
        name: String = "Grasshopper",
        imageDefault: UIImage = UIImage(named: "red_grasshopper")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "10",
            affiliation: affiliation,
            description: "moves along the same lines as the rook. when capturing lands on the square immediately beyond the target.",
            imageDefault: imageDefault,
            attackVectorList: Array<String>(["Pawn"]),
            tschxValue: String(6),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    public override func validate(present: [Int], proposed: [Int], state: [[Piece?]]) -> Bool {
        if(hopper.direction_UP(present: present, proposed: proposed, state: state, affiliation: "FUCK")){
            return true
        }
        if(hopper.direction_DOWN(present: present, proposed: proposed, state: state, affiliation: "FUCK")){
            return true
        }
        if(hopper.direction_LEFT(present: present, proposed: proposed, state: state, affiliation: "FUCK")){
            return true
        }
        if(hopper.direction_RIGHT(present: present, proposed: proposed, state: state, affiliation: "FUCK")){
            return true
        }
        return false
    }
    
}
