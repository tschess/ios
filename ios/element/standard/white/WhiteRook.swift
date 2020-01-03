//
//  WhiteRook.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteRook: Rook {
    
    init() {
        super.init(
            name: "WhiteRook",
            imageDefault: UIImage(named: "white_rook")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_rook"),
            imageSelection: UIImage(named: "selection_white_rook")
        )
    }
}
