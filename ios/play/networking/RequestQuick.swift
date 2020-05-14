//
//  GetQuickTask.swift
//  ios
//
//  Created by Matthew on 12/13/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestQuick {
    
    func success(id: String, completion: @escaping ([String: Any]) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/quick/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(["fail": "0"])
                return
            }
            guard let data = data else {
                completion(["fail": "0"])
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(["fail": "0"])
                    return
                }
                completion(json)
                
            } catch let error {
                print(error.localizedDescription)
                completion(["fail": "0"])
            }
        })
        task.resume()
    }
}
