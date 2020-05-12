//
//  UpdateRescind.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class UpdateRescind {
    
    func execute(requestPayload: [String: Any], completion: @escaping (([String: Any]) -> Void)) {
        
        //print("\n\nRequestChallenge: \(requestPayload)\n\n")
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/rescind")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch _ {
             completion(["fail": "0"])
            return
        }
        
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
               completion(["fail": "0"])
                return
            }
            guard let data = data else {
               completion(["fail": "0"])
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                completion(["fail": "0"])
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    completion(["fail": "0"])
                    return
                }
                
                
                completion(json)
                
            } catch let error {
                completion(["fail": "0"])
                return
            }
        }).resume()
    }
    
}
