//
//  Skin.swift
//  ios
//
//  Created by Matthew on 1/17/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Skin {
    
    var name: String
    var foreColor: UIColor
    var foreImage: UIImage?
    var backColor: UIColor
    var backImage: UIImage?
    
    func getName() -> String {
        return self.name
    }
    
    func getForeColor() -> UIColor {
        return self.foreColor
    }
    
    func getForeImage() -> UIImage? {
        return self.foreImage
    }
    
    func getBackColor() -> UIColor {
        return self.backColor
    }
    
    func getBackImage() -> UIImage? {
        return self.backImage
    }
    
    init(
        name: String,
        foreColor: UIColor,
        foreImage: UIImage? = nil,
        backColor: UIColor,
        backImage: UIImage? = nil
        ) {
        self.name = name
        self.foreColor = foreColor
        self.foreImage = foreImage
        self.backColor = backColor
        self.backImage = backImage
    }
    
}
