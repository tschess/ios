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
            StoryboardSelector().start()
        }
        PlayerDevice().execute(device: device!) { (result) in
            if(result != nil) {
                sleep(1)
                StoryboardSelector().home(player: result!)
                return
            }
            StoryboardSelector().start()
        }
    }
}
