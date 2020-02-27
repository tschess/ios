//
//  AmazonBlack.swift
//  ios
//
//  Created by Matthew on 2/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class AmazonBlack: Amazon {
    
    init() {
        super.init(
            name: "AmazonBlack",
            imageDefault: UIImage(named: "black_amazon")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_amazon"),
            imageSelection: UIImage(named: "selection_black_amazon")
        )
    }
}
