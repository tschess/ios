//
//  RequestRefresh.swift
//  ios
//
//  Created by Matthew on 2/3/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestRefresh {
    
//    func execute(requestPayload: [String: Any], player: Player, completion: @escaping (([Game]?, Player) -> Void)) {
//        
//        //print("page: \(page)")
//        
//        let url = URL(string: "http://\(ServerAddress().IP):8080/player/refresh")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
//        } catch _ {
//            completion(nil, player)
//        }
//        
//        
//        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
//            
//            guard error == nil else {
//                print("b")
//                completion(nil, player)
//                return
//            }
//            guard let data = data else {
//                print("c")
//                completion(nil, player)
//                return
//            }
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
//                print("d")
//                completion(nil, player)
//                return
//            }
//            do {
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
//                    print("e")
//                    completion(nil, player)
//                    return
//                }
//                
//                //print(json)
//                print("count: \(json.count)")
//                
//                let elo = json["elo"] as! Int
//                player.elo = String(elo)
//                
//                let rank = json["rank"] as! Int
//                player.rank = String(rank)
//                
//                let disp = json["disp"] as! Int
//                player.disp = String(disp)
//                
//                //print("Int(requestPayload[page])! \(requestPayload["page"])")
//                
//                let leaderboardPage: [Game] = self.generateLeaderboardPage(
//                    page: 0,
//                    size: requestPayload["size"] as! Int,
//                    serverRespose: json["page"] as! [[String: Any]])
//                
//                completion(leaderboardPage, player)
//                //completion(nil)
//                
//            } catch let error {
//                print(error.localizedDescription)
//                completion(nil, player)
//            }
//        }).resume()
//    }
//    
//    private func generateLeaderboardPage(page: Int, size: Int, serverRespose: [[String: Any]]) -> [Game] {
//        var leaderboardPage = [Game]()
//        for index in stride(from: 0, to: serverRespose.count, by: 1) {
//            
//            let id = serverRespose[index]["id"]! as! String
//            let name = serverRespose[index]["username"]! as! String
//            let avatar = serverRespose[index]["avatar"]! as! String
//            let elo = String(serverRespose[index]["elo"]! as! Int)
//            
//            /* * */
//            //var rank0 =
//            //rank0 += 1
//            let rank = String(serverRespose[index]["rank"]! as! Int)
//            /* * */
//            
//            let disp = String(serverRespose[index]["disp"]! as! Int)
//            let date = serverRespose[index]["date"]! as! String
//            
//            let opponent = PlayerCore(
//                id: id,
//                username: name,
//                avatar: avatar,
//                elo: elo,
//                rank: rank,
//                date: date,
//                disp: disp)
//            
//            let game = Game(opponent: opponent)
//            leaderboardPage.append(game)
//        }
//        return leaderboardPage
//    }
    
}
