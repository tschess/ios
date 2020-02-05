//
//  KnightWhite.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class KnightWhite: Knight {
    
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
