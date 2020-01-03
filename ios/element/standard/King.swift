//
//  King.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class King: TschessElement {
    
    let kingMovement = KingMovement()
    let attack = Attack()
    let threat = Threat()
    
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
    
    public override func validate(present: [Int], proposed: [Int], gamestate: Gamestate) ->  Bool {
        if(Castling().castle(kingCoordinate: present, proposed: proposed, gamestate: gamestate)){
            return true
        }
        if(!kingMovement.movement(present: present, proposed: proposed)) {
            return false
        }
        if(attack.evaluate(present: present, proposed: proposed, gamestate: gamestate)) {
            return false
        }
        if(threat.evaluate(present: present, proposed: proposed, gamestate: gamestate)) {
            return false
        }
        let tschessElementMatrix = gamestate.getTschessElementMatrix()
        let elementDest = tschessElementMatrix[proposed[0]][proposed[1]]
        if(elementDest == nil) {
            return true
        }
        if(elementDest!.name == "LegalMove") {
            return true
        }
        let elementKing = tschessElementMatrix[present[0]][present[1]]!
        return elementKing.affiliation != elementDest!.affiliation
    }
    
}
