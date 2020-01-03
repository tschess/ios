//
//  WhitePawn.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhitePawn: Pawn {
    
    init() {
        super.init(
            name: "WhitePawn",
            imageDefault: UIImage(named: "white_pawn")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_pawn"),
            imageSelection: UIImage(named: "selection_white_pawn")
        )
    }
}


