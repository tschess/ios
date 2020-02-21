//
//  SelectSkins.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectSkins {
    
    public func execute(player: EntityPlayer, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "SkinsL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "SkinsL") as! Skins
            viewController.setPlayer(player: player)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "SkinsP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SkinsP") as! Skins
        viewController.setPlayer(player: player)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
