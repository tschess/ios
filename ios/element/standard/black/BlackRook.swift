//
//  BlackRook.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackRook: Rook {
    
    init() {
        super.init(
            name: "BlackRook",
            imageDefault: UIImage(named: "black_rook")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_rook"),
            imageSelection: UIImage(named: "selection_black_rook")
        )
    }
}
