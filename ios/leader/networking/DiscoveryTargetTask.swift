//
//  DiscoveryTargetTask.swift
//  ios
//
//  Created by Matthew on 9/24/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class DiscoveryTargetTask {
    
    func execute(name: String, completion: @escaping (Any?) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/target/\(name)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    completion(nil)
                    return
                }
                //print("json: \(json)")
                if(json["error"] != nil){
                    let error = json["error"]! as! String
                    completion(error)
                    return
                }
                let id =  json["id"] as! String
                let name =  json["name"] as! String
                let elo =  String(json["elo"] as! Int)
                let rank =  String(json["rank"] as! Int)
                let avatar =  json["avatar"] as! String
                let opponent = PlayerCore(id: id, name: name, avatar: avatar, rank: rank, elo: elo)
                let game = Game(opponent: opponent)
                completion(game)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
}
