//
//  HunterWhite.swift
//  ios
//
//  Created by Matthew on 2/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class HunterWhite: Hunter {
    
    init() {
        super.init(
            name: "HunterWhite",
            imageDefault: UIImage(named: "white_hunter")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_hunter"),
            imageSelection: UIImage(named: "selection_white_hunter")
        )
    }
}
