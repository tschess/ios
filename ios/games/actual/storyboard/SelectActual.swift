//
//  SelectActual.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectActual {
    
    public func execute(player: EntityPlayer, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "ActualL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ActualL") as! Actual
            viewController.setPlayerSelf(playerSelf: player)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "ActualP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ActualP") as! Actual
        viewController.setPlayerSelf(playerSelf: player)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
