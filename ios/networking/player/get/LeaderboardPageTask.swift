//
//  DiscoverSetTask.swift
//  ios
//
//  Created by Matthew on 9/24/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class LeaderboardPageTask {
    
    func execute(requestPayload: [String: Int], completion: @escaping (([Game]?) -> Void)) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/leaderboard")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch _ {
            //print("a")
            completion(nil)
        }
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                //print("b")
                completion(nil)
                return
            }
            guard let data = data else {
                //print("c")
                completion(nil)
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                //print("d")
                completion(nil)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    //print("e")
                    completion(nil)
                    return
                }
                
                //print(json)
                
                let xxx = json["content"] as! [[String: Any]]
                
                //print("Int(requestPayload[page])! \(requestPayload["page"])")
                
                let leaderboardPage: [Game] = self.generateLeaderboardPage(page: requestPayload["page"]!, size: requestPayload["size"]!, serverRespose: xxx)
                completion(leaderboardPage)
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
    private func generateLeaderboardPage(page: Int, size: Int, serverRespose: [[String: Any]]) -> [Game] {
        var leaderboardPage = [Game]()
        for index in stride(from: 0, to: serverRespose.count, by: 1) {
            //print(" --- ")
            let id =  serverRespose[index]["id"] as! String
            //print("\(index): \(identifier)")
            let name =  serverRespose[index]["name"] as! String
            //print("\(index): \(username)")
            let elo = String(serverRespose[index]["elo"] as! Int)
            //let rank = serverRespose[index]["rank"] as! Int
            let rank = String(1 + index + (page * size))
            //print("\(index): \(elo)")
            let avatar =  serverRespose[index]["avatar"] as! String
            //print("\(index): \(avatarUrl)")
            
            let opponent = PlayerCore(id: id, name: name, avatar: avatar, rank: rank, elo: elo)
            
            let game = Game(opponent: opponent)
            leaderboardPage.append(game)
        }
        return leaderboardPage
    }
    
}
