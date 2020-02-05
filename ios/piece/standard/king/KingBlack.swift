//
//  KingBlack.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class KingBlack: King {
    
    init() {
        super.init(
            name: "KingBlack",
            imageDefault: UIImage(named: "black_king")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_king"),
            imageSelection: UIImage(named: "selection_black_king")
        )
    }
}
