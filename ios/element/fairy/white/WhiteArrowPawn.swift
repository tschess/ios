//
//  WhiteArrow.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteArrowPawn: ArrowPawn {
    
    init() {
        super.init(
            name: "WhiteArrowPawn",
            imageDefault: UIImage(named: "white_arrow")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_arrow"),
            imageSelection: UIImage(named: "selection_white_arrow")
        )
    }
}
