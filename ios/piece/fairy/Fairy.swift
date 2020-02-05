//
//  Fairy.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Fairy: Piece {
    
    var tschxValue: String
    
    func setTschxValue(tschxValue: String) {
        self.tschxValue = tschxValue
    }
    
    func getTschxValue() -> String {
        return tschxValue
    }
    
    var description: String
    
    func getDescription(description: String) -> String {
        return description
    }
    
    init(
        name: String,
        strength: String,
        affiliation: String,
        description: String,
        imageDefault: UIImage,
        attackVectorList: Array<String>,
        tschxValue: String,
        imageTarget: UIImage?,
        imageSelection: UIImage?
        ) {
        self.tschxValue = tschxValue
        self.description = description
        super.init(
            name: name,
            strength: strength,
            affiliation: affiliation,
            imageDefault: imageDefault,
            standard: false, // Always 'false'...
            attackVectorList: attackVectorList,
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
}
