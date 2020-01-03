//
//  WhiteQueen.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteQueen: Queen {
    
    init() {
        super.init(
            name: "WhiteQueen",
            imageDefault: UIImage(named: "white_queen")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_queen"),
            imageSelection: UIImage(named: "selection_white_queen")
        )
    }
}


