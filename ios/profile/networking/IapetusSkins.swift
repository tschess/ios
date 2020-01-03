//
//  IapetusSkins.swift
//  ios
//
//  Created by Matthew on 11/17/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class IapetusSkins {
    
    func execute(id: String, completion: @escaping ((steward: Bool?, defaultSkin: Bool?, count: Int?)?) -> Void) {
        
        //print("IapetusSkins: \(id)")
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/iapetus/skins/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
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
                //print("json: \(json)")
                
                let steward = json["steward"] as! Bool
                //print("owner: \(String(describing: owner))")

                let defaultSkin = json["default_skin"] as! Bool
                //print("defaultSkin: \(defaultSkin)")

                let count = json["count"] as! Int
                //print("remaining: \(remaining)")
               
                completion((steward, defaultSkin, count))
                
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
}

