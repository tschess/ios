//
//  RequestAck.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestAck {
    
    func execute(requestPayload: [String: Any], completion: @escaping (([String: Any]) -> Void)) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/ack")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(["fail": "0"])
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(["fail": "0"])
                return
            }
            guard let data = data else {
                completion(["fail": "0"])
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(["fail": "0"])
                    return
                }
                
                //print("json: \(json)")
                
                
                completion(json)
                
            } catch let error {
                print(error.localizedDescription)
                completion(["fail": "0"])
            }
        }).resume()
    }
}
