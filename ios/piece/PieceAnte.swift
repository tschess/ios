//
//  LegalMove.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PieceAnte: Piece {
    
    init() {
        super.init(
            name: "PieceAnte",
            strength: "",
            affiliation: "PieceAnte",
            imageDefault: UIImage(named: "target")!,
            standard: true,
            attackVectorList: Array()
        )
    }
}
