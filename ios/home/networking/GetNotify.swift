//
//  GetNotify.swift
//  ios
//
//  Created by Matthew on 1/30/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class GetNotify {
    
    func execute(id: String, completion: @escaping ((Bool) -> Void)) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/notify/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(false)
                return
            }
            guard let data = data else {
                completion(false)
                return
            }
            if(data.isEmpty){
                completion(false)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    completion(false)
                    return
                }
                if(json["notify"] != nil){
                    completion(true)
                }
                completion(false)
            } catch let error {
                print(error.localizedDescription)
                completion(false)
            }
        }).resume()
    }
}
