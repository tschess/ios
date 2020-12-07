//
//  NoteKey.swift
//  ios
//
//  Created by S. Matthew English on 5/28/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class NoteKey {
    
    func execute(payload: [String: String], completion: @escaping (([String: String]) -> Void)) {
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/note")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
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
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String] else {
                    completion(["fail": "3"])
                    return
                }
                completion(json)
            } catch _ {
                completion(["fail": "4"])
            }
            
        }).resume()
    }
    
}
