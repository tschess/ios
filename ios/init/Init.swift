//
//  Initializer.swift
//  ios
//
//  Created by Matthew on 9/20/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Init: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        
        let device = UIDevice.current.identifierForVendor?.uuidString
        if(device == nil) {
            self.start()
            return
        }
        PlayerDevice().execute(device: device!) { (result) in
            if(result["fail"] != nil) {
                self.start()
                return
            }
            DispatchQueue.main.async {
                let player: EntityPlayer = ParsePlayer().execute(json: result)
                let height: CGFloat = UIScreen.main.bounds.height
                if(height.isLess(than: 750)){
                    let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                    viewController.playerSelf = player
                    self.navigationController?.pushViewController(viewController, animated: false)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                viewController.playerSelf = player
                self.navigationController?.pushViewController(viewController, animated: false)
                
                if let viewControllers = self.navigationController?.viewControllers {
                      for vc in viewControllers {
                        print("It is in stack \(String(describing: type(of: vc)))")
                      }
                }
                
               
            }
        }
    }
    
    private func start() {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Start", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Start") as! Start
            self.navigationController?.pushViewController(viewController, animated: false)
            
        }
    }
}
