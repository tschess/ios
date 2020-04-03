//
//  SelectAck.swift
//  ios
//
//  Created by Matthew on 2/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectAck {
    
    //public func execute(              playerSelf: EntityPlayer, playerOther: EntityPlayer, game: EntityGame, menuList: [EntityGame]? = nil, homeList: [EntityPlayer]? = nil, height: CGFloat) {
    public func execute(selection: Int,
                        playerSelf: EntityPlayer,
                        playerOther: EntityPlayer,
                        game: EntityGame,
                        menuList: [EntityGame]? = nil,
                        homeList: [EntityPlayer]? = nil,
                        height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "AckL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "AckL") as! Ack
            viewController.setPlayerSelf(playerSelf: playerSelf)
            viewController.setPlayerOther(playerOther: playerOther)
            viewController.setGameTschess(gameTschess: game)
            viewController.setSelection(selection: selection)
            viewController.menuList = menuList
            viewController.homeList = homeList
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "AckP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AckP") as! Ack
        viewController.setPlayerSelf(playerSelf: playerSelf)
        viewController.setPlayerOther(playerOther: playerOther)
        viewController.setGameTschess(gameTschess: game)
        viewController.setSelection(selection: selection)
        viewController.menuList = menuList
        viewController.homeList = homeList
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
