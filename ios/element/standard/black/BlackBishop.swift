//
//  BlackBishop.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackBishop: Bishop {
    
    init() {
        super.init(
            name: "BlackBishop",
            imageDefault: UIImage(named: "black_bishop")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_bishop"),
            imageSelection: UIImage(named: "selection_black_bishop")
        )
    }
}
