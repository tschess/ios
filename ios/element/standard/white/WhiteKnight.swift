//
//  WhiteKnight.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteKnight: Knight {
    
    init() {
        super.init(
            name: "WhiteKnight",
            imageDefault: UIImage(named: "white_knight")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_knight"),
            imageSelection: UIImage(named: "selection_white_knight")
        )
    }
}


