//
//  PawnWhite.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PawnWhite: Pawn {
    
    init() {
        super.init(
            name: "PawnWhite",
            imageDefault: UIImage(named: "white_pawn")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_pawn"),
            imageSelection: UIImage(named: "selection_white_pawn")
        )
    }
}
