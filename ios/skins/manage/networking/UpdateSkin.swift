//
//  UpdateSkin.swift
//  ios
//
//  Created by Matthew on 11/17/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class UpdateSkin {
    
    func execute(requestPayload: [String: Any], completion: @escaping (Error?) -> Void) {
        
        //print("requestPayload: \(requestPayload)")
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/skin")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(error)
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(error)
                return
            }
            guard let data = data else {
                completion(NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                
                //print("UpdateSkin: \(json)")
              
                completion(nil)
            } catch let error {
                print(error.localizedDescription)
                completion(error)
            }
        })
        task.resume()
    }
}

