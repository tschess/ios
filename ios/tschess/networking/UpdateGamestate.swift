//
//  GameUpdateTask.swift
//  ios
//
//  Created by Matthew on 9/24/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class UpdateGamestate {
    
    var count: Int = 0
    
    public func execute(requestPayload: [String: Any]) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/update")!
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
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    return
                }
                //print(json)
                if(json["update"] != nil){
                    return
                }
                if(self.count == 10){
                    return
                }
                self.count += 1
                sleep(UInt32(self.count))
                self.execute(requestPayload: requestPayload)
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}
