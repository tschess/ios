//
//  SelectSnapshot.swift
//  ios
//
//  Created by Matthew on 2/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class SelectSnapshot {
    
   
    
    public func snapshot(playerSelf: EntityPlayer, game: EntityGame, presentor: UIViewController) {
        
       
            DispatchQueue.main.async {
                let height: CGFloat = UIScreen.main.bounds.height
                if(height.isLess(than: 750)){
                    let storyboard: UIStoryboard = UIStoryboard(name: "DefaultL", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "DefaultL") as! Snapshot
                    viewController.setGame(game: game)
                    viewController.setPlayer(player: playerSelf)
                    presentor.present(viewController, animated: false, completion: nil)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "DefaultP", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "DefaultP") as! Snapshot
                viewController.setGame(game: game)
                viewController.setPlayer(player: playerSelf)
                presentor.present(viewController, animated: false, completion: nil)
               
                //UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        
        
    }
    
}


