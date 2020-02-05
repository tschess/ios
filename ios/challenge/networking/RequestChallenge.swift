//
//  RequestChallenge.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestChallenge {
    
    func execute(requestPayload: [String: Any], completion: @escaping ((Bool) -> Void)) {
        
        print("\n\nRequestChallenge: \(requestPayload)\n\n")
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/challenge")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch _ {
            completion(false)
        }
        
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                print("b")
                completion(false)
                return
            }
            guard let data = data else {
                print("c")
                completion(false)
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("d")
                completion(false)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    print("e")
                    completion(false)
                    return
                }
                
                print(json)
                //print("count: \(json.count)")
                
                //let xxx = json["content"] as! [[String: Any]]
                
                //print("Int(requestPayload[page])! \(requestPayload["page"])")
                
                //let leaderboardPage: [Game] = self.generateLeaderboardPage(page: requestPayload["index"]!, size: requestPayload["size"]!, serverRespose: json)
                //completion(leaderboardPage)
                completion(true)
                
            } catch let error {
                print(error.localizedDescription)
                completion(false)
            }
        }).resume()
    }
    
}
