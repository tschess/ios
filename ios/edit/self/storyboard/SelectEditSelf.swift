//
//  SelectEditSelf.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectEditSelf {
    
    public func execute(player: EntityPlayer, title: String, select: Int, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "EditSelfL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "EditSelfL") as! EditSelf
            viewController.playerSelf = player
            viewController.titleText = title
            viewController.selection = select
            viewController.BACK = "CONFIG"
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "EditSelfP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditSelfP") as! EditSelf
        viewController.playerSelf = player
        viewController.titleText = title
        viewController.selection = select
        viewController.BACK = "CONFIG"
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
