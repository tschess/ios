//
//  SelectHome.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

//SelectHome().execute(player: EntityPlayer, height: Int)

class SelectHome {
    
    public func execute(player: EntityPlayer, height: CGFloat) {
        if(height.isLess(than: 750)){
            //DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "HomeL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "HomeL") as! Home
                viewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            //}
            return
        }
        //DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "HomeP", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "HomeP") as! Home
            viewController.setPlayer(player: player)
            UIApplication.shared.keyWindow?.rootViewController = viewController
        //}
    }
}
