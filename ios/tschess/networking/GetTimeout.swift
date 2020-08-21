//
//  UpdateTimeout.swift
//  ios
//
//  Created by S. Matthew English on 5/20/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class GetTimeout {
    
    func success(id_game: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/timeout/\(id_game)")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                completion(true)
                
            } catch let error {
                
                completion(false)
            }
        })
        task.resume()
    }
}

