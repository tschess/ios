//
//  PostListPage.swift
//  ios
//
//  Created by Matthew on 12/4/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestActual {
    
    var player: Player?
    var matrixDeserializer: MatrixDeserializer?
    let dateTime: DateTime = DateTime()
    
    func execute(player: Player, page: Int, completion: @escaping (([Game]?) -> Void)) {
        
        self.player = player
        
        matrixDeserializer = MatrixDeserializer()
        matrixDeserializer!.setUsername(username: player.getUsername())
        
        let requestPayload: [String: Any] = ["id": player.getId(), "index": page, "size": 8]
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/actual")!
        
        //"id":"", "page":0, "size":13
        
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
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] else {
                    return
                }
                print("*PageList* \n\n \(json.count)")
                var gameList = [Game]()
                
                let responseList = self.generateGameList(serverResponse: json)
                
                if(responseList != nil){
                    gameList.append(contentsOf: responseList!)
                }
                
                completion(gameList)
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        })
        task.resume()
    }
    
    public func generateGameList(serverResponse: [[String: Any]])  -> [Game]? {
        var gameList = [Game]()
        
        for gameDictionary in serverResponse {
            
            let id = gameDictionary["id"]! as! String
            let invitation = gameDictionary["invitation"]! as! Bool
            let inbound = gameDictionary["inbound"]! as! Bool
            let date = gameDictionary["date"]! as! String
            let username = gameDictionary["username"]! as! String
            let avatar = gameDictionary["avatar"]! as! String
            
            let opponent = PlayerCore(username: username, avatar: avatar)
            let game = Game(opponent: opponent, identifier: id, actualDate: date, invitation: invitation, inbound: inbound)
            
            gameList.append(game)
        }
        return gameList
    }
    
}

