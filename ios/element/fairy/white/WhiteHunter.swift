//
//  WhiteHunter.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteHunter: Hunter {
    
    init() {
        super.init(
            name: "WhiteHunter",
            imageDefault: UIImage(named: "white_hunter")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_hunter"),
            imageSelection: UIImage(named: "selection_white_hunter")
        )
    }
}
