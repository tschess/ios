//
//  GameTestTask.swift
//  ios
//
//  Created by Matthew on 10/8/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class TestTask0 {
    
    let dateTime: DateTime = DateTime()
    
    func execute(requestPayload: [String : Any], completion: @escaping (Gamestate) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/test")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    return
                }
                //print("- 12 - 12 - 12 - 12 - 12 - 12 - 12 ")
                //print(json)
                //print("- 12 - 12 - 12 - 12 - 12 - 12 - 12 ")
                
                let id = json["id"]! as! String
                //print(" - id: \(id)")
                
                let clock = json["clock"]! as! Int
                //print(" - clock: \(clock)")
                
                let playerWhite: Player = PlayerDeserializer().execute(dictionary: json["white"] as! [String: Any])
                let playerBlack: Player = PlayerDeserializer().execute(dictionary: json["black"] as! [String: Any])
                
                let gamestateDeserializer = MatrixDeserializer()
                gamestateDeserializer.setUsername(username: playerWhite.getName())
                gamestateDeserializer.setUsernameWhite(username: playerWhite.getName())
                gamestateDeserializer.setUsernameBlack(username: playerBlack.getName())
                
                let gameStatus = json["status"]! as! String
                gamestateDeserializer.setGameStatus(gameStatus: gameStatus)
                
                let state = json["state"]! as! [[String]]
                let tschessElementMatrix = gamestateDeserializer.deserialize(stringRepresentation: state, orientationBlack: false)
                
                let opponent = PlayerCore(
                    id: playerBlack.getId(),
                    name: playerBlack.getName(),
                    avatar: playerBlack.getAvatar(),
                    rank: playerBlack.getRank(),
                    elo: playerBlack.getElo())
                
                let gameModel: Game = Game(opponent: opponent)
                gameModel.setIdentifier(identifier: id)
                gameModel.setClock(clock: String(clock))
                gameModel.setUsernameTurn(usernameTurn: playerWhite.getName())
                gameModel.setUsernameWhite(usernameWhite: playerWhite.getName())
                gameModel.setUsernameBlack(usernameBlack: playerBlack.getName())
                gameModel.setLastMoveBlack(lastMoveBlack: self.dateTime.currentDateString())
                gameModel.setLastMoveWhite(lastMoveWhite: "TBD")
                
                
                
                let messageWhite = json["white_message"]! as! String
                gameModel.setMessageWhite(messageWhite: messageWhite)
                let seenMessageWhite = json["white_seen"]! as! Bool
                gameModel.setSeenMessageWhite(seenMessageWhite: seenMessageWhite)
                let messageWhitePosted = json["white_posted"]! as! String
                gameModel.setMessageWhitePosted(messageWhitePosted: messageWhitePosted)
                
                let messageBlack = json["black_message"]! as! String
                gameModel.setMessageBlack(messageBlack: messageBlack)
                let seenMessageBlack = json["black_seen"]! as! Bool
                gameModel.setSeenMessageBlack(seenMessageBlack: seenMessageBlack)
                let messageBlackPosted = json["black_posted"]! as! String
                gameModel.setMessageBlackPosted(messageBlackPosted: messageBlackPosted)
                
                
                
                let gamestate: Gamestate = Gamestate(gameModel: gameModel, tschessElementMatrix: tschessElementMatrix)
                gamestate.setPlayer(player: playerWhite)
                gamestate.setDrawProposer(drawProposer: "NONE")
                gamestate.setGameStatus(gameStatus: "ONGOING")
                gamestate.setWinner(winner: "TBD")
                gamestate.setUpdated(updated: self.dateTime.currentDateString())
                
                let requestPayload = GamestateSerializer().execute(gamestate: gamestate)
                UpdateGamestate().execute(requestPayload: requestPayload)
                
                completion(gamestate)
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }

}
