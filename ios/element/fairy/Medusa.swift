//
//  Medusa.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Medusa: FairyElement {
    
    init(
        name: String = "Medusa",
        imageDefault: UIImage = UIImage(named: "red_medusa")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "11",
            affiliation: affiliation,
            description: "Medusa ~ Medusa...",
            imageDefault: imageDefault,
            attackVectorList: Array<String>(["Pawn"]),
            tschxValue: String(6),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
}
