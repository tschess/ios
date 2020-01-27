//
//  PostListPage.swift
//  ios
//
//  Created by Matthew on 12/4/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class PageHistoric {
    
    let dateTime: DateTime = DateTime()
    
    var name: String?
    
    public func setName(name: String) {
        self.name = name
    }
    
    func executeLeaderboard(gameModel: Game, page: Int, completion: @escaping (([Game]?) -> Void)) {
        self.execute(id: gameModel.getOpponentId(), page: page){ (result) in
            completion(result)
        }
    }
    
    var matrixDeserializer: MatrixDeserializer = MatrixDeserializer()
    
    public func setMatrixDeserializer(name: String) {
        self.matrixDeserializer.setUsername(username: name)
    }
    
    func execute(id: String, page: Int, completion: @escaping (([Game]?) -> Void)) {
        
        let requestPayload: [String: Any] = ["id": id, "page": page, "size": 13]
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/historic")!
        
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
                //print("*PageHistoric* \n\n \(json)")
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
            
            let oppId = gameDictionary["opp_id"]! as! String
            let oppName = gameDictionary["opp_username"]! as! String
            let oppAvatar = gameDictionary["opp_avatar"]! as! String
            let oppElo = String(gameDictionary["opp_elo"]! as! Int)
            let oppRank = String(gameDictionary["opp_rank"]! as! Int)
            
            let oppDisp = String(gameDictionary["opp_disp"]! as! Int)
            let oppDate = gameDictionary["opp_date"]! as! String
           
            
            let opponent = PlayerCore(
                id: oppId,
                username: oppName,
                avatar: oppAvatar,
                elo: oppElo,
                rank: oppRank,
                date: oppDate,
                disp: oppDisp)
            
            let game = Game(opponent: opponent)
            
            let id = gameDictionary["id"]! as! String
            game.setIdentifier(identifier: id)
            
            let gameStatus = gameDictionary["status"]! as! String
            game.setGameStatus(gameStatus: gameStatus)
            matrixDeserializer.setGameStatus(gameStatus: gameStatus)
            
            let whiteName = gameDictionary["white_name"] as! String
            game.setUsernameWhite(usernameWhite: whiteName)
            matrixDeserializer.setUsernameWhite(username: whiteName)
            
            let blackName = gameDictionary["black_name"] as! String
            game.setUsernameBlack(usernameBlack: blackName)
            matrixDeserializer.setUsernameBlack(username: blackName)
            
            let state = gameDictionary["state"]  as? [[String]]
            
            var orientationBlack: Bool = false
            if(self.name! == blackName){
                orientationBlack = true
            }
            
            if(state != nil){
                let tschessElementMatrix = matrixDeserializer.deserialize(stringRepresentation: state!, orientationBlack: orientationBlack)
                game.setState(state: tschessElementMatrix)
            }
            
            let winner = gameDictionary["winner"] as! String
            game.setWinner(winner: winner)
            
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

