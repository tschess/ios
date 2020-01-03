//
//  WhiteSpy.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class WhiteSpy: Spy {
    
    init() {
        super.init(
            name: "WhiteSpy",
            imageDefault: UIImage(named: "white_spy")!,
            affiliation: "WHITE",
            imageTarget: UIImage(named: "target_white_spy"),
            imageSelection: UIImage(named: "selection_white_spy")
        )
    }
}
