//
//  QueenWhite.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class QueenWhite: Queen {
    
    init() {
        super.init(
            name: "QueenWhite",
            imageDefault: UIImage(named: "white_queen")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_queen"),
            imageSelection: UIImage(named: "selection_white_queen")
        )
    }
}
