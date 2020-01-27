//
//  TestTask1.swift
//  ios
//
//  Created by Matthew on 10/11/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class TestTask1 {
    
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
        let session = URLSession.shared
        _ = session.dataTask(with: request, completionHandler: { data, response, error in
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
                
                let gamestateDeserializer = MatrixDeserializer()
                gamestateDeserializer.setUsername(username: "black")
                gamestateDeserializer.setUsernameWhite(username: "white")
                gamestateDeserializer.setUsernameBlack(username: "black")
                
                let gameStatus = json["status"]! as! String
                gamestateDeserializer.setGameStatus(gameStatus: gameStatus)
                
                let state = json["state"]! as! [[String]]
                let tschessElementMatrix = gamestateDeserializer.deserialize(stringRepresentation: state, orientationBlack: true)
                //print(" - tschessElementMatrix: \(tschessElementMatrix)")
                
                let black_update = json["black_update"]! as! String
                //print(" - black_update: \(black_update)")
                
                let white_update = json["white_update"]! as! String
                //print(" - white_update: \(white_update)")
                
                let turn = json["turn"]! as! String
                //print(" - turn: \(turn)")
                
                let playerWhite: Player = PlayerDeserializer().execute(dictionary: json["white"] as! [String: Any])
                let playerBlack: Player = PlayerDeserializer().execute(dictionary: json["black"] as! [String: Any])
                
                
                let opponent = PlayerCore(
                    id: playerWhite.getId(),
                    username: playerWhite.getUsername(),
                    avatar: playerWhite.getAvatar(),
                    elo: playerWhite.getElo(),
                    rank: playerWhite.getRank(),
                    date: playerWhite.getDate(),
                    disp: playerWhite.getDisp())
                
                let gameModel: Game = Game(opponent: opponent)
                gameModel.setIdentifier(identifier: id)
                gameModel.setClock(clock: String(clock))
                gameModel.setUsernameTurn(usernameTurn: turn)
                gameModel.setUsernameWhite(usernameWhite: playerWhite.getUsername())
                gameModel.setUsernameBlack(usernameBlack: playerBlack.getUsername())
                gameModel.setLastMoveBlack(lastMoveBlack: black_update)
                gameModel.setLastMoveWhite(lastMoveWhite: white_update)
                
                
                let messageWhite = json["white_message"]! as! String
                //print(" - messageWhite: \(messageWhite)")
                gameModel.setMessageWhite(messageWhite: messageWhite)
                let seenMessageWhite = json["white_seen"]! as! Bool
                //print(" - seenMessageWhite: \(seenMessageWhite)")
                gameModel.setSeenMessageWhite(seenMessageWhite: seenMessageWhite)
                let messageWhitePosted = json["white_posted"]! as! String
                //print(" - messageWhitePosted: \(messageWhitePosted)")
                gameModel.setMessageWhitePosted(messageWhitePosted: messageWhitePosted)
                
                let messageBlack = json["black_message"]! as! String
                //print(" - messageBlack: \(messageBlack)")
                gameModel.setMessageBlack(messageBlack: messageBlack)
                let seenMessageBlack = json["black_seen"]! as! Bool
                //print(" - seenMessageBlack: \(seenMessageBlack)")
                gameModel.setSeenMessageBlack(seenMessageBlack: seenMessageBlack)
                let messageBlackPosted = json["black_posted"]! as! String
                //print(" - messageBlackPosted: \(messageBlackPosted)")
                gameModel.setMessageBlackPosted(messageBlackPosted: messageBlackPosted)
                
                let gamestate: Gamestate = Gamestate(gameModel: gameModel, tschessElementMatrix: tschessElementMatrix)
                gamestate.setPlayer(player: playerBlack)
                gamestate.setGameStatus(gameStatus: "ONGOING")
                
                let winner = json["winner"]! as! String
                gamestate.setWinner(winner: winner)
                
                completion(gamestate)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
}
