//
//  SelectContext.swift
//  ios
//
//  Created by Matthew on 3/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectContext {
    
    public func execute(player: EntityPlayer, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "ContextL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ContextL") as! Context
            viewController.setPlayer(player: player)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "ContextP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ContextP") as! Context
        viewController.setPlayer(player: player)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
