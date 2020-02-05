//
//  RookBlack.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class RookBlack: Rook {
    
    init() {
        super.init(
            name: "RookBlack",
            imageDefault: UIImage(named: "black_rook")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_rook"),
            imageSelection: UIImage(named: "selection_black_rook")
        )
    }
}
