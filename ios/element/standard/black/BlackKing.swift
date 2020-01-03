//
//  BlackKing.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackKing: King {
    
    init() {
        super.init(
            name: "BlackKing",
            imageDefault: UIImage(named: "black_king")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_king"),
            imageSelection: UIImage(named: "selection_black_king")
        )
    }
}
