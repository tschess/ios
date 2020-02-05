//
//  UpdateEth.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class UpdateEth {
  
    func execute(updatePayload: [String: Any], completion: @escaping (String) -> Void) {
        
        //print("UpdateAddress - requestPayload: \(requestPayload)")
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/address")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: updatePayload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion("ERROR")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion("ERROR")
                return
            }
            guard let data = data else {
                completion("ERROR")
                return
            }
            do {
                guard (try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) != nil else {
                    completion("ERROR")
                    return
                }
                //print("UpdateAddress: \(json)")
                completion("OK")
            } catch let error {
                print(error.localizedDescription)
                completion("ERROR")
            }
        })
        task.resume()
    }
    
}
