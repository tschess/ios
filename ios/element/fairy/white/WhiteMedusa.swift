//
//  WhiteMedusa.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteMedusa: Medusa {
    
    init() {
        super.init(
            name: "WhiteMedusa",
            imageDefault: UIImage(named: "white_medusa")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_medusa"),
            imageSelection: UIImage(named: "selection_white_medusa")
        )
    }
}
