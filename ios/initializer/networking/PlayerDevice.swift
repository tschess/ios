//
//  GetDevice.swift
//  ios
//
//  Created by Matthew on 11/14/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class PlayerDevice {
    
    func execute(device: String, completion: @escaping (EntityPlayer?) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/device/\(device)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                print("A")
                completion(nil)
                return
            }
            guard let data = data else {
                print("B")
                completion(nil)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    print("C")
                    completion(nil)
                    return
                }
                
                
                //let player: EntityPlayer = PlayerDeserializer().execute(dictionary: json)
                print("E")
                completion(nil)
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }).resume()
    }
}

