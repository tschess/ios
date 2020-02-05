//
//  RookWhite.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class RookWhite: Rook {
    
    init() {
        super.init(
            name: "RookWhite",
            imageDefault: UIImage(named: "white_rook")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_rook"),
            imageSelection: UIImage(named: "selection_white_rook")
        )
    }
}
