//
//  LegalMove.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class LegalMove: TschessElement {
    
    init() {
        super.init(
            name: "LegalMove",
            strength: "",
            affiliation: "LegalMove",
            imageDefault: UIImage(named: "target")!,
            standard: true,
            attackVectorList: Array()
        )
    }
}

