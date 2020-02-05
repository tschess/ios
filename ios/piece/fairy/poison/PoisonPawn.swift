//
//  PoisonPawn.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PoisonPawn: Fairy {
    
    var username: String?
    var usernameWhite: String?
    var usernameBlack: String?
    
    func setUsername(username: String) {
        self.username = username
    }
    
    func setUsernameWhite(username: String) {
        self.usernameWhite = username
    }
    
    func setUsernameBlack(username: String) {
        self.usernameBlack = username
    }
    
    init(
        name: String = "LandminePawn",
        imageDefault: UIImage = UIImage(named: "red_landmine_pawn")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "2",
            affiliation: affiliation,
            description: "behaviour identical to a standard pawn with the caveat that when it is captured, the piece that captures it is also removed from the board. self-destructs on promotion. if captured by a king result is instant checkmate for taker",
            imageDefault: imageDefault,
            attackVectorList: Array<String>(["Pawn"]),
            tschxValue: String(4),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    public override func validate(present: [Int], proposed: [Int], state: [[Piece?]]) ->  Bool {
        return Pawn().validate(present: present, proposed: proposed, state: state)
    }

}
