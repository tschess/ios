//
//  RevealBlack.swift
//  ios
//
//  Created by Matthew on 2/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class RevealBlack: Poison {
    
    init() {
        let imageDefault: UIImage = UIImage(named: "black_poison")!
        let imageTarget: UIImage = UIImage(named: "target_black_poison")!
        let imageSelection: UIImage = UIImage(named: "selection_black_poison")!
        super.init(
            name: "RevealBlack",
            imageDefault: imageDefault,
            affiliation: "BLACK",
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
}
