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
        
        let height = self.view.frame.size.height
        
        print("\n\n~HEIGHT~ \(height)\n\n")
        
        let device = UIDevice.current.identifierForVendor?.uuidString
        if(device == nil) {
            self.start()
            return
        }
        PlayerDevice().execute(device: device!) { (result) in
            if(result == nil) {
                self.start()
                return
            }
            sleep(1)
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                viewController.setPlayer(player: result!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        }
    }
    
    private func start() {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Start", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Start") as! Start
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
}
