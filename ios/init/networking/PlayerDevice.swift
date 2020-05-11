//
//  GetDevice.swift
//  ios
//
//  Created by Matthew on 11/14/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class PlayerDevice {
    
    func execute(device: String, completion: @escaping ([String: Any]) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/device/\(device)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(["fail": "0"])
                return
            }
            guard let data = data else {
                completion(["fail": "1"])
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(["fail": "2"])
                    return
                }
                completion(json)
                
            } catch _ {
                completion(["fail": "3"])
            }
        }).resume()
    }
}

