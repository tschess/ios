//
//  Enter.swift
//  ios
//
//  Created by Matthew on 3/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Enter: UIView {
    
    class func instanceFromNib() -> Enter {
        return UINib(nibName: "Enter", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Enter
    }

}
