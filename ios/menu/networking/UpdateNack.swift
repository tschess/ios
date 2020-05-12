//
//  UpdateNack.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class UpdateNack {
    
    func execute(requestPayload: [String: Any], completion: @escaping (([String: Any]) -> Void)) {
        
        
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/nack")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch _ {
            completion(["fail": "0"])
        }
        
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                
                completion(["fail": "1"])
                return
            }
            guard let data = data else {
                
                completion(["fail": "2"])
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                
                completion(["fail": "3"])
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    
                    completion(["fail": "4"])
                    return
                }
                
                
                completion(json)
                
            } catch let error {
                print(error.localizedDescription)
                completion(["fail": "5"])
            }
        }).resume()
    }
    
}
