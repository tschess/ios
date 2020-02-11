//
//  UpdateMate.swift
//  ios
//
//  Created by Matthew on 2/10/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class UpdateMate {
    
    func execute(id: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/mate/\(id)")!
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

