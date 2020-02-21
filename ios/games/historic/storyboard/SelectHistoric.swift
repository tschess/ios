//
//  SelectHistoric.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectHistoric {
    
    public func execute(player: EntityPlayer, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "HistoricL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "HistoricL") as! Historic
            viewController.setPlayerSelf(playerSelf: player)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "HistoricP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoricP") as! Historic
        viewController.setPlayerSelf(playerSelf: player)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
