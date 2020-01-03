//
//  BlackKnight.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackKnight: Knight {
    
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
