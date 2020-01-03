//
//  Spy.swift
//  ios
//
//  Created by Matthew on 8/1/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Spy: FairyElement {
    
    init(
        name: String = "Spy",
        imageDefault: UIImage = UIImage(named: "red_spy")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "13",
            affiliation: affiliation,
            description: "captures in whichever way it's intended target captures. moves as a king when not attacking.",
            imageDefault: imageDefault,
            attackVectorList: Array<String>(["Pawn"]),
            tschxValue: String(6),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
}
