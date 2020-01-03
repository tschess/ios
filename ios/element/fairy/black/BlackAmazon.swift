//
//  BlackAmazon.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackAmazon: Amazon {
    
    init() {
        super.init(
            name: "BlackAmazon",
            imageDefault: UIImage(named: "black_amazon")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_amazon"),
            imageSelection: UIImage(named: "selection_black_amazon")
        )
    }
}
