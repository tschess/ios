//
//  KnightBlack.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class KnightBlack: Knight {
    
    init() {
        super.init(
            name: "BlackKnight",
            imageDefault: UIImage(named: "black_knight")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_knight"),
            imageSelection: UIImage(named: "selection_black_knight")
        )
    }
}
