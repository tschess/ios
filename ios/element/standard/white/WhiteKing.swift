//
//  WhiteKing.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteKing: King {
    
    init() {
        super.init(
            name: "WhiteKing",
            imageDefault: UIImage(named: "white_king")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_king"),
            imageSelection: UIImage(named: "selection_white_king")
        )
    }
}
