//
//  AmazonWhite.swift
//  ios
//
//  Created by Matthew on 2/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class AmazonWhite: Amazon {
    
    init() {
        super.init(
            name: "AmazonWhite",
            imageDefault: UIImage(named: "white_amazon")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_amazon"),
            imageSelection: UIImage(named: "selection_white_amazon")
        )
    }
}
