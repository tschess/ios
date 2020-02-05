//
//  King.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class King: Piece {
    
    let kingMovement = MovementKing()
    //let attack = Attack()
    //let threat = Threat()
    
    init(
        name: String = "King",
        imageDefault: UIImage = UIImage(named: "red_king")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "0",
            affiliation: affiliation,
            imageDefault: imageDefault,
            standard: true,
            attackVectorList: Array<String>(["King"]),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    public override func validate(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
//        if(Castle().castle(kingCoordinate: present, proposed: proposed, state: state)){
//            return true
//        }
        if(!kingMovement.movement(present: present, proposed: proposed)) {
            return false
        }
//        if(attack.evaluate(present: present, proposed: proposed, state: state)) {
//            return false
//        }
//        if(threat.evaluate(present: present, proposed: proposed, state: state)) {
//            return false
//        }
        let elementDest = state[proposed[0]][proposed[1]]
        if(elementDest == nil) {
            return true
        }
        if(elementDest!.name == "PieceAnte") {
            return true
        }
        let elementKing = state[present[0]][present[1]]!
        return elementKing.affiliation != elementDest!.affiliation
    }
    
}
