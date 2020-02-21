//
//  SelectInfo.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectInfo {
    
    public func execute(player: EntityPlayer, fairy: Fairy, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "InfoL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "InfoL") as! Info
            viewController.setPlayer(player: player)
            viewController.setFairyElement(fairyElement: fairy)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "InfoP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "InfoP") as! Info
        viewController.setPlayer(player: player)
        viewController.setFairyElement(fairyElement: fairy)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
