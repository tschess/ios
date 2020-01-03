//
//  BlackSpy.swift
//  ios
//
//  Created by Matthew on 8/2/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class BlackSpy: Spy {
    
    init() {
        super.init(
            name: "BlackSpy",
            imageDefault: UIImage(named: "black_spy")!,
            affiliation: "BLACK",
            imageTarget: UIImage(named: "target_black_spy"),
            imageSelection: UIImage(named: "selection_black_spy")
        )
    }
}
