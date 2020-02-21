//
//  SelectFairies.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectFairies {
    
    public func execute(player: EntityPlayer, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "FairiesL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "FairiesL") as! Fairies
            viewController.setPlayer(player: player)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "FairiesP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FairiesP") as! Fairies
        viewController.setPlayer(player: player)
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
