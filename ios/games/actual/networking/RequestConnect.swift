//
//  RequestConnect.swift
//  ios
//
//  Created by Matthew on 2/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestConnect {
    
    func execute(requestPayload: [String: Any], gameConnect: GameConnect, completion: @escaping ((GameTschess?) -> Void)) {
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/connect")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(nil)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(nil)
                    return
                }
                
                let matrixDeserializer = MatrixDeserializer()
                matrixDeserializer.setUsername(username: gameConnect.gameAck.playerSelf.username)
                matrixDeserializer.setUsernameWhite(username: gameConnect.gameAck.playerSelf.username)
                matrixDeserializer.setUsernameBlack(username: gameConnect.gameAck.playerOppo.username)
                
                
                
                let status: String = json["status"] as! String
                print("status: \(status)")
                gameConnect.status = status
                matrixDeserializer.setGameStatus(gameStatus: status)
                
                
                
                
                let state0: [[String]] = json["state"]! as! [[String]]
                
                let white: Bool = json["white"] as! Bool
                print("white: \(white)")
                gameConnect.gameAck.white = white
                
                let state = matrixDeserializer.deserialize(stringRepresentation: state0, orientationBlack: !white)
                //print("\n\n state: \(state)")
                gameConnect.gameAck.state = state
                
                if(!white){
                    matrixDeserializer.setUsernameWhite(username: gameConnect.gameAck.playerOppo.username)
                    matrixDeserializer.setUsernameBlack(username: gameConnect.gameAck.playerSelf.username)
                    let state = matrixDeserializer.deserialize(stringRepresentation: state0, orientationBlack: white)
                    //print("\n\n state: \(state)")
                    gameConnect.gameAck.state = state
                }
                
                let skin: String = json["skin"] as! String
                //print("skin: \(skin)")
                gameConnect.gameAck.skin = skin
                
                let date: String = json["date"] as! String
                print("date: \(date)")
                gameConnect.gameAck.date = date
                
                //highlight
                let highlight: String = json["highlight"] as! String
                print("highlight: \(highlight)")
                gameConnect.highlight = highlight
                
                //on_check
                let onCheck: Bool = json["on_check"] as! Bool
                print("onCheck: \(onCheck)")
                gameConnect.onCheck = onCheck
                
                //turn
                let turn: String = json["turn"] as! String
                print("turn: \(turn)")
                gameConnect.turn = turn
                
                let gameTschess: GameTschess = GameTschess(gameConnect: gameConnect)
                completion(gameTschess)
                
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }).resume()
    }
}

