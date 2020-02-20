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
            if(result == nil) {
                self.start()
                return
            }
            sleep(1)
            //DispatchQueue.main.async {
                //let storyboard: UIStoryboard = UIStoryboard(name: "HomeL", bundle: nil)
                //let viewController = storyboard.instantiateViewController(withIdentifier: "HomeL") as! Home
                //viewController.setPlayer(player: result!)
                //UIApplication.shared.keyWindow?.rootViewController = viewController
            //}
            DispatchQueue.main.async {
                let height = self.view.frame.size.height
                SelectHome().execute(player: result!, height: height)
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
