//
//  SelectActual.swift
//  ios
//
//  Created by Matthew on 2/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectMenu {
    
    public func execute(player: EntityPlayer, menuList: [EntityGame], homeList: [EntityPlayer]? = nil, height: CGFloat) {
        if(height.isLess(than: 750)){
            let storyboard: UIStoryboard = UIStoryboard(name: "MenuL", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "MenuL") as! Menu
            viewController.setMenuTableList(list: menuList)
            viewController.setSelf(player: player)
            viewController.homeList = homeList
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "MenuP", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MenuP") as! Menu
         viewController.setMenuTableList(list: menuList)
        viewController.setSelf(player: player)
        viewController.homeList = homeList
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
