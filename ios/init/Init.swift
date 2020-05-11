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
            //sleep(1)
            DispatchQueue.main.async {
                let player: EntityPlayer = ParsePlayer().execute(json: result)
                
                let height: CGFloat = UIScreen.main.bounds.height
                SelectHome().execute(player: player, height: height)
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
