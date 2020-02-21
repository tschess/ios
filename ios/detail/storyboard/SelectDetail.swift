//
//  SelectDetail.swift
//  ios
//
//  Created by Matthew on 2/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectDetail {
    
    public func execute(player: EntityPlayer, skin: EntitySkin, height: CGFloat) {
        
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "DetailL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "DetailL") as! Detail
            viewController.setPlayer(player: player)
            viewController.setSkin(skin: skin)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "DetailP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailP") as! Detail
        viewController.setPlayer(player: player)
        viewController.setSkin(skin: skin)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
}
