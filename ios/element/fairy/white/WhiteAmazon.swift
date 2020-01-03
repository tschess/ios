//
//  WhiteAmazon.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteAmazon: Amazon {
    
    init() {
        super.init(
            name: "WhiteAmazon",
            imageDefault: UIImage(named: "white_amazon")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_amazon"),
            imageSelection: UIImage(named: "selection_white_amazon")
        )
    }
}
