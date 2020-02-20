//
//  SelectRecent.swift
//  ios
//
//  Created by Matthew on 2/13/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectRecent {
    
    //todo - move to game entity itself...
    func getSkinGame(username: String, game: EntityGame) -> String {
        if(game.white.username == username){
            return game.white_skin
        }
        return game.black_skin
    }
    
    public func snapshot(playerOther: EntityPlayer, playerSelf: EntityPlayer, recentGameList: [EntityGame], presentor: UIViewController) {
        
        if(recentGameList.isEmpty){
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "HomeL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "HomeL") as! Home
                viewController.setPlayer(player: playerSelf)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            return
        }
        
        var recentGameList1 = recentGameList
        
        let game: EntityGame = recentGameList1.removeLast()
        
        let skin: String = self.getSkinGame(username: playerSelf.username, game: game)
        
        
        switch skin {
        case "IAPETUS":
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "iRecentL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "iRecentL") as! Recent
                viewController.setGame(game: game)
                viewController.setRecentGameList(recentGameList: recentGameList1)
                viewController.setPlayerOther(playerOther: playerOther)
                viewController.setPlayerSelf(playerSelf: playerSelf)
                //presentor.present(viewController, animated: false, completion: nil)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            return
        case "CALYPSO":
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "cRecentL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "cRecentL") as! Recent
                viewController.setGame(game: game)
                viewController.setRecentGameList(recentGameList: recentGameList1)
                viewController.setPlayerOther(playerOther: playerOther)
                viewController.setPlayerSelf(playerSelf: playerSelf)
                //presentor.present(viewController, animated: false, completion: nil)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            return
        case "HYPERION":
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "hRecentL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "hRecentL") as! Recent
                viewController.setGame(game: game)
                viewController.setRecentGameList(recentGameList: recentGameList1)
                viewController.setPlayerOther(playerOther: playerOther)
                viewController.setPlayerSelf(playerSelf: playerSelf)
                //presentor.present(viewController, animated: false, completion: nil)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            return
        case "NEPTUNE":
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "nRecentL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "nRecentL") as! Recent
                viewController.setGame(game: game)
                viewController.setRecentGameList(recentGameList: recentGameList1)
                viewController.setPlayerOther(playerOther: playerOther)
                viewController.setPlayerSelf(playerSelf: playerSelf)
                //presentor.present(viewController, animated: false, completion: nil)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            return
        default:
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "dRecentL", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "dRecentL") as! Recent
                viewController.setGame(game: game)
                viewController.setRecentGameList(recentGameList: recentGameList1)
                viewController.setPlayerOther(playerOther: playerOther)
                viewController.setPlayerSelf(playerSelf: playerSelf)
                //presentor.present(viewController, animated: false, completion: nil)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        }
        
    }
    
}

