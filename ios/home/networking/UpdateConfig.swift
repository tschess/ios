//
//  UpdateConfig.swift
//  ios
//
//  Created by Matthew on 11/6/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class UpdateConfig {
    
    func execute(requestPayload: [String: Any], player: Player, completion: @escaping (Player?) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/config")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(nil)
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(nil)
                    return
                }
                //print(json)
                let matrix0 = json["config0"]! as! [[String]]
                let matrix1 = json["config1"]! as! [[String]]
                let matrix2 = json["config2"]! as! [[String]]
                let config0 = ConfigDeserializer().generateTschessElementMatrix(savedConfigurationNestedStringArray: matrix0)
                let config1 = ConfigDeserializer().generateTschessElementMatrix(savedConfigurationNestedStringArray: matrix1)
                let config2 = ConfigDeserializer().generateTschessElementMatrix(savedConfigurationNestedStringArray: matrix2)
              
                player.setConfig0(config0: config0)
                player.setConfig1(config1: config1)
                player.setConfig2(config2: config2)
                
                completion(player)
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        })
        task.resume()
    }
    
}
