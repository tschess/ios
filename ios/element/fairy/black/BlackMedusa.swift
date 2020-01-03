//
//  BlackMedusa.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackMedusa: Medusa {
    
    init() {
        super.init(
            name: "BlackMedusa",
            imageDefault: UIImage(named: "black_medusa")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_medusa"),
            imageSelection: UIImage(named: "selection_black_medusa")
        )
    }
}
