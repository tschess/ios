//
//  PawnBlack.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PawnBlack: Pawn {
    
    init() {
        super.init(
            name: "PawnBlack",
            imageDefault: UIImage(named: "black_pawn")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_pawn"),
            imageSelection: UIImage(named: "selection_black_pawn")
        )
    }
    
}
