//
//  RequestActual.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestActual {
    
    func execute(requestPayload: [String: Any], completion: @escaping (([EntityGame]?) -> Void)) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/actual")!
        
        //"id":"", "page":0, "size":13
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] else {
                    return
                }
                print("*PageList* \n\n \(json.count)")
              
                
               var gameList = [EntityGame]()
                for index in stride(from: 0, to: json.count, by: 1) {
                     let game: EntityGame = ParseGame().execute(json: json[index])
                    gameList.append(game)
                }
               
                
                completion(gameList)
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        })
        task.resume()
    }
    
    
    
}
