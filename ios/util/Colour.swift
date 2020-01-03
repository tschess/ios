//
//  Colour.swift
//  ios
//
//  Created by Matthew on 11/20/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Colour {
    
    func getRed() -> UIColor {
        return UIColor(red: 220/255.0, green: 4/255.0, blue: 4/255.0, alpha: 1)
    }
    
    func getInbound() -> UIColor {
        return UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
    }
    
    func getOutbound() -> UIColor {
        return UIColor(red: 15/255.0, green: 15/255.0, blue: 15/255.0, alpha: 1)
    }
    
    func getWin() -> UIColor {
        return UIColor(red: 211/255.0, green: 255/255.0, blue: 211/255.0, alpha: 1)
    }
    
    func getLoss() -> UIColor {
        return UIColor(red: 255/255.0, green: 211/255.0, blue: 211/255.0, alpha: 1)
    }
    
    func getDraw() -> UIColor {
        return UIColor(red: 255/255.0, green: 255/255.0, blue: 204/255.0, alpha: 1)
    }
}
