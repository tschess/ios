//
//  PoisonPawnWhite.swift
//  ios
//
//  Created by Matthew on 2/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PoisonWhite: Poison {
    
    init(white: Bool) {
        var imageDefault: UIImage = UIImage(named: "white_poison")!
        var imageTarget: UIImage = UIImage(named: "target_white_poison")!
        var imageSelection: UIImage = UIImage(named: "selection_white_poison")!
        if(!white){
            imageDefault = UIImage(named: "white_pawn")!
            imageTarget = UIImage(named: "target_white_pawn")!
            imageSelection = UIImage(named: "selection_white_pawn")! //totally redundant...
        }
        super.init(
            name: "PoisonWhite",
            imageDefault: imageDefault,
            affiliation: "WHITE",
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
}
