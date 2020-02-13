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
                let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
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
                let storyboard: UIStoryboard = UIStoryboard(name: "iRecent", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "iRecent") as! Recent
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
                let storyboard: UIStoryboard = UIStoryboard(name: "cRecent", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "cRecent") as! Recent
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
                let storyboard: UIStoryboard = UIStoryboard(name: "hRecent", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "hRecent") as! Recent
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
                let storyboard: UIStoryboard = UIStoryboard(name: "nRecent", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "nRecent") as! Recent
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
                let storyboard: UIStoryboard = UIStoryboard(name: "dRecent", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "dRecent") as! Recent
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

