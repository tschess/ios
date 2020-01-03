//
//  WhiteReveal.swift
//  ios
//
//  Created by Matthew on 12/15/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteReveal: FairyElement {
    
    init() {
        super.init(
            name: "WhiteReveal",
            strength: "2",
            affiliation: "WHITE",
            description: "behaviour identical to a standard pawn with the caveat that when it is captured, the piece that captures it is also removed from the board. self-destructs on promotion. if captured by a king result is instant checkmate for taker",
            imageDefault: UIImage(named: "white_landmine_pawn")!,
            attackVectorList: Array<String>(["Pawn"]),
            tschxValue: String(4),
            imageTarget: UIImage(named: "target_white_landmine_pawn"),
            imageSelection: UIImage(named: "selection_white_landmine_pawn")
        )
    }
}
