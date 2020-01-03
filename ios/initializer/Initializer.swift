//
//  Initializer.swift
//  ios
//
//  Created by Matthew on 9/20/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Initializer: UIViewController {
    
    let dateTime: DateTime = DateTime()
    
    override func viewDidAppear(_ animated: Bool) {
        
        let device = UIDevice.current.identifierForVendor?.uuidString
        let updated = dateTime.currentDateString()
        let api = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        let requestPayload: [String: Any] = ["device": device ?? "", "updated": updated, "api": api ?? ""]
        
        PlayerDevice().execute(requestPayload: requestPayload) { (result) in
            if(result != nil) {
                sleep(1)
                StoryboardSelector().home(player: result!)
                return
            }
            StoryboardSelector().start()
        }
    }
}
