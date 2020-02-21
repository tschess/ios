//
//  SelectPlay.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectPlay {
    
    public func execute(playerSelf: EntityPlayer, playerOther: EntityPlayer, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "PlayL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PlayL") as! Play
            viewController.setPlayerSelf(playerSelf: playerSelf)
            viewController.setPlayerOther(playerOther: playerOther)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "PlayP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PlayP") as! Play
        viewController.setPlayerSelf(playerSelf: playerSelf)
        viewController.setPlayerOther(playerOther: playerOther)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
