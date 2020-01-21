//
//  SampleSkin.swift
//  ios
//
//  Created by Matthew on 1/21/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SampleSkin: UIView {

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "SampleSkin", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

}
