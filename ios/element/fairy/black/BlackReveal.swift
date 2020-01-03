//
//  BlackReveal.swift
//  ios
//
//  Created by Matthew on 12/15/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackReveal: FairyElement {
    
    init() {
        super.init(
            name: "BlackReveal",
            strength: "2",
            affiliation: "BLACK",
            description: "behaviour identical to a standard pawn with the caveat that when it is captured, the piece that captures it is also removed from the board. self-destructs on promotion. if captured by a king result is instant checkmate for taker",
            imageDefault: UIImage(named: "black_landmine_pawn")!,
            attackVectorList: Array<String>(["Pawn"]),
            tschxValue: String(4),
            imageTarget: UIImage(named: "target_black_landmine_pawn"),
            imageSelection: UIImage(named: "selection_black_landmine_pawn")
        )
    }
}
