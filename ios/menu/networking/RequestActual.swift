//
//  RequestActual.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestActual {
    
    //"id":"", "page":0, "size":13
    //print("requestPayload \(requestPayload)")
    func execute(requestPayload: [String: Any], completion: @escaping (([EntityGame]) -> Void)) {
        
        var gameList = [EntityGame]()
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/menu")!
        
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
                print("0")
                completion(gameList)
                return
            }
            guard let data = data else {
                print("1")
                completion(gameList)
                return
            }
            do {
                
                print("x \(data)")
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] else {
                    
                    //
                    
                    print("- 2")
                    let json1 = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Bool]
                    if(json1 == nil){
                        print("111")
                        completion(gameList)
                        return
                    }
                    if(json1!["zero"] != nil){
                        print("d")
                        completion(gameList)
                        return
                    }
                    if(json1!["eol"] != nil){
                        print("r")
                        completion(gameList)
                        return
                    }
                    completion(gameList)
                    return
                }
                print("v")
               
                for index in stride(from: 0, to: json.count, by: 1) {
                     let game: EntityGame = ParseGame().execute(json: json[index])
                    gameList.append(game)
                }
                
                
              //print("z \(json)")
                
                completion(gameList)
                
            } catch let error {
                print(error.localizedDescription)
                completion(gameList)
            }
        })
        task.resume()
    }
    
    
    
}
