//
//  HunterBlack.swift
//  ios
//
//  Created by Matthew on 2/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class HunterBlack: Hunter {
    
    init() {
        super.init(
            name: "HunterBlack",
            imageDefault: UIImage(named: "black_hunter")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_hunter"),
            imageSelection: UIImage(named: "selection_black_hunter")
        )
    }
}
