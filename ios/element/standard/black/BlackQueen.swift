//
//  BlackQueen.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackQueen: Queen {
    
    init() {
        super.init(
            name: "BlackQueen",
            imageDefault: UIImage(named: "black_queen")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_queen"),
            imageSelection: UIImage(named: "selection_black_queen")
        )
    }
}
