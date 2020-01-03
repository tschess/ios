//
//  BlackGrasshopper.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackGrasshopper: Grasshopper {
    
    init() {
        super.init(
            name: "BlackGrasshopper",
            imageDefault: UIImage(named: "black_grasshopper")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_grasshopper"),
            imageSelection: UIImage(named: "selection_black_grasshopper")
        )
    }
}
