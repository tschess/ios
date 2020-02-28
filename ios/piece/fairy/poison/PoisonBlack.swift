//
//  PoisonPawnBlack.swift
//  ios
//
//  Created by Matthew on 2/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PoisonBlack: Poison {
    
    init(white: Bool) {
        var imageDefault: UIImage = UIImage(named: "black_poison")!
        var imageTarget: UIImage = UIImage(named: "target_black_poison")!
        var imageSelection: UIImage = UIImage(named: "selection_black_poison")!
        if(white){
            imageDefault = UIImage(named: "black_pawn")!
            imageTarget = UIImage(named: "target_black_pawn")!
            imageSelection = UIImage(named: "selection_black_pawn")! //totally redundant...
        }
        super.init(
            name: "PoisonBlack",
            imageDefault: imageDefault,
            affiliation: "BLACK",
            imageTarget: imageTarget,
            imageSelection: imageSelection
        )
    }
}
