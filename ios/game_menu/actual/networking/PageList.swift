//
//  PostListPage.swift
//  ios
//
//  Created by Matthew on 12/4/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class PageList {
    
    var player: Player?
    var matrixDeserializer: MatrixDeserializer?
    let dateTime: DateTime = DateTime()
    
    func execute(player: Player, page: Int, completion: @escaping (([Game]?) -> Void)) {
        
        self.player = player
        
        matrixDeserializer = MatrixDeserializer()
        matrixDeserializer!.setUsername(username: player.getName())
        
        let requestPayload: [String: Any] = ["id": player.getId(), "page": page, "size": 13]
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/list")!
        
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
                //print("*PageList* \n\n \(json)")
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
            
            let opponent_id = gameDictionary["opponent_id"]! as! String
            let opponent_name = gameDictionary["opponent_name"]! as! String
            let opponent_avatar = gameDictionary["opponent_avatar"]! as! String
            let opponent_elo = String(gameDictionary["opponent_elo"]! as! Int)
            let opponent_rank = String(gameDictionary["opponent_rank"]! as! Int)
            let opponent = PlayerCore(
                id: opponent_id,
                name: opponent_name,
                avatar: opponent_avatar,
                rank: opponent_rank,
                elo: opponent_elo)
            
            let game = Game(opponent: opponent)
            
            let usernameWhite = gameDictionary["white_name"]! as! String
            game.setUsernameWhite(usernameWhite: usernameWhite)
            let usernameBlack = gameDictionary["black_name"]! as! String
            game.setUsernameBlack(usernameBlack: usernameBlack)
            
            let messageWhite = gameDictionary["white_message"]! as! String
            game.setMessageWhite(messageWhite: messageWhite)
            let seenMessageWhite = gameDictionary["white_seen"]! as! Bool
            game.setSeenMessageWhite(seenMessageWhite: seenMessageWhite)
            let messageWhitePosted = gameDictionary["white_posted"]! as! String
            game.setMessageWhitePosted(messageWhitePosted: messageWhitePosted)
            
            let messageBlack = gameDictionary["black_message"]! as! String
            game.setMessageBlack(messageBlack: messageBlack)
            let seenMessageBlack = gameDictionary["black_seen"]! as! Bool
            game.setSeenMessageBlack(seenMessageBlack: seenMessageBlack)
            let messageBlackPosted = gameDictionary["black_posted"]! as! String
            game.setMessageBlackPosted(messageBlackPosted: messageBlackPosted)
            
            let id = gameDictionary["id"]! as! String
            game.setIdentifier(identifier: id)
            
            let status = gameDictionary["status"]! as! String
            game.setGameStatus(gameStatus: status)
            
            let configuration = gameDictionary["config"]! as! [[String]]
            let config0 = ConfigDeserializer().generateTschessElementMatrix(savedConfigurationNestedStringArray: configuration)
            game.setConfigurationInviter(configurationInviter: config0)
            
            let turn = gameDictionary["turn"] as! String
            game.setUsernameTurn(usernameTurn: turn)
            
            let inbound = gameDictionary["inbound"] as! Bool
            game.setInbound(inbound: inbound)
            
            let createdString = gameDictionary["created"] as! String
            let created = dateTime.toFormatDate(string: createdString)
            game.setCreated(created: created)
            
            let drawProposer = gameDictionary["catalyst"]! as! String
            game.setDrawProposer(drawProposer: drawProposer)
            
            let skin = gameDictionary["skin"] as! String
            game.setSkin(skin: skin)
            
            gameList.append(game)
        }
        return gameList
    }
    
}

