//
//  BishopBlack.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//


import UIKit

class BishopBlack: Bishop {
    
    init() {
        super.init(
            name: "BishopBlack",
            imageDefault: UIImage(named: "black_bishop")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_bishop"),
            imageSelection: UIImage(named: "selection_black_bishop")
        )
    }
}
