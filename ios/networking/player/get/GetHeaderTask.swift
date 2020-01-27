//
//  GetHeaderTask.swift
//  ios
//
//  Created by Matthew on 9/25/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class GetHeaderTask {
    
    func execute(player: Player, completion: @escaping (Player?, Error?) -> Void) {
        //print(" ~ OOO ~ ")
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/header/\(player.getId())")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            do {
    
                //print(" ~ 111 ~ ")
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    //print(" ~ 222 ~ ")
                    
                    completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                //print(json)
                //print(json.count)
                
                let rank = String(json["rank"]! as! Int)
                //print(" ~ rank ~ \(rank)")
                let tschx = String(json["tschx"]! as! Int)
                //print(" ~ tschx ~ \(tschx)")
                let address = json["address"]! as! String
                //print(" ~ address ~ \(address)")
                
                let avatar = json["avatar"]! as! String
                //print(" ~ avatar ~ \(avatar)")
                
                player.setAvatar(avatar: avatar)
                    
                //player.setTschx(tschx: tschx)
                player.setRank(rank: rank)
                player.setAddress(address: address)
                
                completion(player, nil)
            } catch let error {
                //print(" ~ xxx ~ ")
                print(error.localizedDescription)
                completion(nil, error)
            }
        })
        task.resume()
    }
    
}
