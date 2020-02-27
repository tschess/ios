//
//  PoisonPawnBlack.swift
//  ios
//
//  Created by Matthew on 2/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PoisonBlack: Poison {
    
    init() {
        super.init(
            name: "PoisonBlack",
            imageDefault: UIImage(named: "black_poison")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_poison"),
            imageSelection: UIImage(named: "selection_black_poison")
        )
    }
}
