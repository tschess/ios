//
//  UpdateMessage.swift
//  ios
//
//  Created by Matthew on 12/14/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class UpdateMessage {
    
    func success(requestPayload: [String: Any], completion: @escaping ((Bool?) -> Void)) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/message/update")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(false)
                return
            }
            guard let data = data else {
                completion(false)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(false)
                    return
                }
                //print(json)
                let result = json["result"] as? String
                if(result != nil){
                    if(result! == "success"){
                        completion(true)
                    }
                }
                completion(false)
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
}
