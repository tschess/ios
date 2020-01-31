//
//  RequestChallenge.swift
//  ios
//
//  Created by Matthew on 1/31/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestChallenge {
    
    func execute(requestPayload: [String: Any], completion: @escaping (([Game]?) -> Void)) {
        
        //print("page: \(page)")
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/leaderboard")!
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
                
                //print(json)
                print("count: \(json.count)")
                
                //let xxx = json["content"] as! [[String: Any]]
                
                //print("Int(requestPayload[page])! \(requestPayload["page"])")
                
                //let leaderboardPage: [Game] = self.generateLeaderboardPage(page: requestPayload["index"]!, size: requestPayload["size"]!, serverRespose: json)
                //completion(leaderboardPage)
                completion(nil)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
    private func generateLeaderboardPage(page: Int, size: Int, serverRespose: [[String: Any]]) -> [Game] {
        var leaderboardPage = [Game]()
        for index in stride(from: 0, to: serverRespose.count, by: 1) {
            
            let id = serverRespose[index]["id"]! as! String
            let name = serverRespose[index]["username"]! as! String
            let avatar = serverRespose[index]["avatar"]! as! String
            let elo = String(serverRespose[index]["elo"]! as! Int)
            
            /* * */
            //var rank0 =
            //rank0 += 1
            let rank = String(serverRespose[index]["rank"]! as! Int)
            /* * */
            
            let disp = String(serverRespose[index]["disp"]! as! Int)
            let date = serverRespose[index]["date"]! as! String
            
            let opponent = PlayerCore(
                id: id,
                username: name,
                avatar: avatar,
                elo: elo,
                rank: rank,
                date: date,
                disp: disp)
            
            let game = Game(opponent: opponent)
            leaderboardPage.append(game)
        }
        return leaderboardPage
    }
    
    enum SKIN {
        case DEFAULT
        case IAPETUS
        case CALYPSO
        case HYPERION
        case NEPTUNE
    }
    
}
