//
//  EntitySkin.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class EntitySkin {
    
    var name: String
    var foreColor: UIColor
    var foreImage: UIImage?
    var foreAlpha: CGFloat
    var backColor: UIColor
    var backImage: UIImage?
    var backAlpha: CGFloat
    
    var description: String
    
    func getName() -> String {
        return self.name
    }
    
    func getForeColor() -> UIColor {
        return self.foreColor
    }
    
    func getForeImage() -> UIImage? {
        return self.foreImage
    }
    
    func getForeAlpha() -> CGFloat {
        return self.foreAlpha
    }
    
    func getBackColor() -> UIColor {
        return self.backColor
    }
    
    func getBackImage() -> UIImage? {
        return self.backImage
    }
    
    func getBackAlpha() -> CGFloat {
        return self.backAlpha
    }
    
    init(
        name: String,
        foreColor: UIColor,
        foreImage: UIImage? = nil,
        foreAlpha: CGFloat = 1.0,
        backColor: UIColor,
        backImage: UIImage? = nil,
        backAlpha: CGFloat = 1.0,
        description: String) {
        self.name = name
        self.foreColor = foreColor
        self.foreImage = foreImage
        self.foreAlpha = foreAlpha
        self.backColor = backColor
        self.backImage = backImage
        self.backAlpha = backAlpha
        self.description = description
    }
    
}
