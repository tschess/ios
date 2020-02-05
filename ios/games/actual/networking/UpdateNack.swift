//
//  UpdateNack.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class UpdateNack {
    
        func execute(requestPayload: [String: Any], completion: @escaping ((EntityPlayer?) -> Void)) {
            
            print("\n\nUpdateNack: \(requestPayload)\n\n")
            
            let url = URL(string: "http://\(ServerAddress().IP):8080/game/nack")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
            } catch _ {
                completion(nil)
            }
            
            
            URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                
                guard error == nil else {
                    print("b")
                    completion(nil)
                    return
                }
                guard let data = data else {
                    print("c")
                    completion(nil)
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("d")
                    completion(nil)
                    return
                }
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                        print("e")
                        completion(nil)
                        return
                    }
                    
                   let player: EntityPlayer = ParsePlayer().execute(json: json)
                    completion(player)
                    
                } catch let error {
                    print(error.localizedDescription)
                    completion(nil)
                }
            }).resume()
        }
        
    }
