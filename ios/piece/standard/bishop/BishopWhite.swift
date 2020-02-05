//
//  BishopWhite.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class BishopWhite: Bishop {
    
    init() {
        super.init(
            name: "BishopWhite",
            imageDefault: UIImage(named: "white_bishop")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_bishop"),
            imageSelection: UIImage(named: "selection_white_bishop")
        )
    }
}
