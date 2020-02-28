//
//  RevealWhite.swift
//  ios
//
//  Created by Matthew on 2/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class RevealWhite: Poison {
    
    init() {
        let imageDefault: UIImage = UIImage(named: "white_poison")!
        let imageTarget: UIImage = UIImage(named: "target_white_poison")!
        let imageSelection: UIImage = UIImage(named: "selection_white_poison")!
        super.init(
            name: "RevealWhite",
            imageDefault: imageDefault,
            affiliation: "WHITE",
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
}
