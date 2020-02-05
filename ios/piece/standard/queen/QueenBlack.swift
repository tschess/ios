//
//  QueenBlack.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class QueenBlack: Queen {
    
    init() {
        super.init(
            name: "QueenBlack",
            imageDefault: UIImage(named: "black_queen")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_queen"),
            imageSelection: UIImage(named: "selection_black_queen")
        )
    }
}
