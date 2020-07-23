//
//  Share00.swift
//  ios
//
//  Created by S. Matthew English on 7/23/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class CoreStart {
    
    func requestPayload(username: String, password: String) -> [String: String] {
        let device: String = UIDevice.current.identifierForVendor!.uuidString
        let dict: [String: String] = [
            "username": username,
            "password": password,
            "device": device
        ]
        return dict
    }
    
}
