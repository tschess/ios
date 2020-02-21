//
//  SelectOther.swift
//  ios
//
//  Created by Matthew on 2/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectOther {
    
    public func execute(playerSelf: EntityPlayer, playerOther: EntityPlayer, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "OtherL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "OtherL") as! Other
            viewController.setPlayerSelf(playerSelf: playerSelf)
            viewController.setPlayerOther(playerOther: playerOther)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "OtherP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OtherP") as! Other
        viewController.setPlayerSelf(playerSelf: playerSelf)
        viewController.setPlayerOther(playerOther: playerOther)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
