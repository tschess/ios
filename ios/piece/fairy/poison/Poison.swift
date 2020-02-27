//
//  PoisonPawn.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Poison: Fairy {
    
//    var username: String?
//    var usernameWhite: String?
//    var usernameBlack: String?
//    
//    func setUsername(username: String) {
//        self.username = username
//    }
//    
//    func setUsernameWhite(username: String) {
//        self.usernameWhite = username
//    }
//    
//    func setUsernameBlack(username: String) {
//        self.usernameBlack = username
//    }
    //var white: Bool
    
    init(
        name: String = "Poison",
        imageDefault: UIImage = UIImage(named: "red_poison")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "2",
            affiliation: affiliation,
            description:
            "• identical to a standard pawn with *one* caveat.\r\r" +
            "• when captured, the opponent piece is also destroyed, i.e. eliminated from the game.\r\r" +
            "• if king attempts to capture result is instant checkmate.\r\r",
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
