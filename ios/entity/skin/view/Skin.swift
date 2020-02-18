//
//  Skin.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Skin: UIView {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var foregroundView: UIView!
    @IBOutlet weak var foregroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    class func instanceFromNib() -> Skin {
        return UINib(nibName: "Skin", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Skin
    }

}
