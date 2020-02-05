//
//  Initializer.swift
//  ios
//
//  Created by Matthew on 9/20/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Initializer: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        let device = UIDevice.current.identifierForVendor?.uuidString
        if(device == nil) {
            self.start()
            return
        }
        PlayerDevice().execute(device: device!) { (result) in
            if(result != nil) {
                sleep(1)
                let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! Home
                //homeViewController.setPlayer(player: player)
                UIApplication.shared.keyWindow?.rootViewController = homeViewController
                return
            }
            self.start()
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
