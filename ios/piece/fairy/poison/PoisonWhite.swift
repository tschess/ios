//
//  PoisonPawnWhite.swift
//  ios
//
//  Created by Matthew on 2/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PoisonWhite: Poison {
    
    init() {
        super.init(
            name: "PoisonWhite",
            imageDefault: UIImage(named: "white_poison")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_poison"),
            imageSelection: UIImage(named: "selection_white_poison")
        )
    }
}
