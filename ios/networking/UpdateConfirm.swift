//
//  UpdateConfirm.swift
//  ios
//
//  Created by S. Matthew English on 8/27/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class UpdateConfirm {
    
    func execute(requestPayload: [String: Any], completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/confirm")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //yayaya
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch _ {
            completion(false)
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
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
                if(json["success"] != nil){
                    //print("A")
                    completion(true)
                }
                completion(false)
                
                
            } catch let error {
                completion(false)
            }
        })
        task.resume()
    }
}
