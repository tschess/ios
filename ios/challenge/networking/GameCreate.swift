//
//  GameCreateTask.swift
//  ios
//
//  Created by Matthew on 9/24/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class GameCreate {
    
    func success(requestPayload: [String: Any], completion: @escaping (Any?) -> Void) {
        
        //print("YYY \(requestPayload)")
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/create")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
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
                //print("ZZZ \(json)")
                completion(json)
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        })
        task.resume()
    }
}
