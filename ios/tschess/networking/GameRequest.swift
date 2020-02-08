//
//  RequestGame.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class GameRequest {
    
    func execute(id: String, completion: @escaping (EntityGame?) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/request/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                
                let game: EntityGame = ParseGame().execute(json: json)
                completion(game)
                
            } catch let error {
               
                completion(nil)
            }
        })
        task.resume()
    }
}
