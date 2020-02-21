//
//  SelectConfig.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectConfig {
    
    public func execute(player: EntityPlayer, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "ConfigL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ConfigL") as! Config
            viewController.setPlayerSelf(playerSelf: player)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "ConfigP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConfigP") as! Config
        viewController.setPlayerSelf(playerSelf: player)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
