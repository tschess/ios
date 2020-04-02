//
//  SelectTschess.swift
//  ios
//
//  Created by Matthew on 2/21/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectTschess {
    
    public func tschess(playerSelf: EntityPlayer, playerOther: EntityPlayer, game: EntityGame, menuList: [EntityGame]? = nil, homeList: [EntityPlayer]? = nil, height: CGFloat) {
        
      
        

            if(height.isLess(than: 750)){
                let storyboard: UIStoryboard = UIStoryboard(name: "dTschessL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessL") as! Tschess
                viewController.setOther(player: game.getPlayerOther(username: playerSelf.username))
                viewController.setSelf(player: playerSelf)
                viewController.setGame(game: game)
                viewController.menuList = menuList
                viewController.homeList = homeList
                UIApplication.shared.keyWindow?.rootViewController = viewController
                return
            }
            let storyboard: UIStoryboard = UIStoryboard(name: "dTschessP", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessP") as! Tschess
            viewController.setOther(player: game.getPlayerOther(username: playerSelf.username))
            viewController.setSelf(player: playerSelf)
            viewController.setGame(game: game)
            viewController.menuList = menuList
            viewController.homeList = homeList
            UIApplication.shared.keyWindow?.rootViewController = viewController
        
        
        
    }
   
}
