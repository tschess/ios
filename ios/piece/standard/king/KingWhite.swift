//
//  WhiteKnight.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class KingWhite: King {
    
    init() {
        super.init(
            name: "KingWhite",
            imageDefault: UIImage(named: "white_king")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_king"),
            imageSelection: UIImage(named: "selection_white_king")
        )
    }
}
