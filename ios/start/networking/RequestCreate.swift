//
//  RequestCreate.swift
//  ios
//
//  Created by Matthew on 2/11/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestCreate {
    
    func execute(requestPayload: [String: String], completion: @escaping (EntityPlayer?) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/create")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch _ {
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
                if (json["id"] as? String) == nil {
                    //print("MIA")
                    completion(nil)
                    return
                    
                }
                //print("json: \(json)")
                
                let player: EntityPlayer = ParsePlayer().execute(json: json)
                completion(player)
                
                //return
                
                
                
                
                
            } catch _ {
                
                //print("error: \(error)")
                
                completion(nil)
            }
        })
        task.resume()
    }
}
