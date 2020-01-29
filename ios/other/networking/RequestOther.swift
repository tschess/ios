//
//  DiscoverSetTask.swift
//  ios
//
//  Created by Matthew on 9/24/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestOther {
    
    func execute(requestPayload: [String: Any], completion: @escaping (([Game]?) -> Void)) {
        
        print("requestPayload: \(requestPayload)")
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/other")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch _ {
            completion(nil)
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                print("b")
                completion(nil)
                return
            }
            guard let data = data else {
                print("c")
                completion(nil)
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("d")
                completion(nil)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]] else {
                    print("e")
                    completion(nil)
                    return
                }
                
                print(json)
                print("count: \(json.count)")
                
                //let xxx = json["content"] as! [[String: Any]]
                
                //print("Int(requestPayload[page])! \(requestPayload["page"])")
                let page: Int = requestPayload["index"]! as! Int
                 let size: Int = requestPayload["size"]! as! Int
                //let page: Int = requestPayload["index"]!
                
                let otherPage: [Game] = self.generateLeaderboardPage(page: page, size: size, serverRespose: json)
                completion(otherPage)
                //completion(nil)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
    private func generateLeaderboardPage(page: Int, size: Int, serverRespose: [[String: Any]]) -> [Game] {
        var leaderboardPage = [Game]()
        for index in stride(from: 0, to: serverRespose.count, by: 1) {
            
            let game_id = serverRespose[index]["game_id"]! as! String
            print("game_id: \(game_id)")
            let date_end = serverRespose[index]["date_end"]! as! String
            print("date_end: \(date_end)")
            
            let disp = serverRespose[index]["disp"]! as! Int
            let odds = serverRespose[index]["odds"]! as! Int
            let winner = serverRespose[index]["winner"]! as! Int
            
            
            let opponent_id = serverRespose[index]["opponent_id"]! as! String
            let opponent_username = serverRespose[index]["opponent_username"]! as! String
            let opponent_avatar = serverRespose[index]["opponent_avatar"]! as! String
            
            let opponent = PlayerCore(id: opponent_id, username: opponent_username, avatar: opponent_avatar)
            
            
            //date_end
            let game = Game(opponent: opponent, identifier: game_id, endDate: date_end, disp: disp, odds: odds, winnerInt: winner)
            leaderboardPage.append(game)
        }
        return leaderboardPage
    }
    
}
