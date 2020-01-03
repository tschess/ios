//
//  WhiteBishop.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteBishop: Bishop {
    
    init() {
        super.init(
            name: "WhiteBishop",
            imageDefault: UIImage(named: "white_bishop")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_bishop"),
            imageSelection: UIImage(named: "selection_white_bishop")
        )
    }
}


