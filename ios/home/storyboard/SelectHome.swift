//
//  SelectHome.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectHome {
    
    public func execute(player: EntityPlayer, menuList: [EntityGame]? = nil, homeList: [EntityPlayer]? = nil, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "HomeL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "HomeL") as! Home
            //viewController.setPlayer(player: player)
            viewController.playerSelf = player
            //viewController.menuList = menuList
            //viewController.homeList = homeList
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "HomeP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeP") as! Home
        viewController.playerSelf = player
        //viewController.menuList = menuList
        //viewController.homeList = homeList
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
