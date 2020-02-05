//
//  Amazon.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Amazon: Fairy {
    
    init(
        name: String = "Amazon",
        imageDefault: UIImage = UIImage(named: "red_amazon")!,
        affiliation: String = "RED",
        imageTarget: UIImage? = nil,
        imageSelection: UIImage? = nil
        ) {
        super.init(
            name: name,
            strength: "10",
            affiliation: affiliation,
            description: "queen+knight compound",
            imageDefault: imageDefault,
            attackVectorList: Array<String>(["HorizontalVertical", "Diagonal", "Knight"]),
            tschxValue: String(4),
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
    
    
    public override func validate(present: [Int], proposed: [Int], state: [[Piece?]]) -> Bool {
        if (Knight().validate(present: present, proposed: proposed, state: state)) {
            return true
        }
        if (Rook().validate(present: present, proposed: proposed, state: state)) {
            return true
        }
        if (Bishop().validate(present: present, proposed: proposed, state: state)) {
            return true
        }
        return false
    }

}
