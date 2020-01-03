//
//  WhiteGrasshopper.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteGrasshopper: Grasshopper {
    
    init() {
        super.init(
            name: "WhiteGrasshopper",
            imageDefault: UIImage(named: "white_grasshopper")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_grasshopper"),
            imageSelection: UIImage(named: "selection_white_grasshopper")
        )
    }
}
