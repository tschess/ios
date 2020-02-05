//
//  RequestAck.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestAck {
    
    func execute(requestPayload: [String: Any], gameAck: GameAck, completion: @escaping ((GameTschess?) -> Void)) {
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/ack")!
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
                matrixDeserializer.setUsername(username: gameAck.playerSelf.username)
                matrixDeserializer.setUsernameWhite(username: gameAck.playerSelf.username)
                matrixDeserializer.setUsernameBlack(username: gameAck.playerOppo.username)
                matrixDeserializer.setGameStatus(gameStatus: "ONGOING") ///cause its accept this will always be ongoing...
                
                
                let state0: [[String]] = json["state"]! as! [[String]]
                
                let white: Bool = json["white"] as! Bool
                print("white: \(white)")
                gameAck.white = white
                
                let state = matrixDeserializer.deserialize(stringRepresentation: state0, orientationBlack: !white)
                //print("\n\n state: \(state)")
                gameAck.state = state
                
                if(!white){
                    matrixDeserializer.setUsernameWhite(username: gameAck.playerOppo.username)
                    matrixDeserializer.setUsernameBlack(username: gameAck.playerSelf.username)
                    let state = matrixDeserializer.deserialize(stringRepresentation: state0, orientationBlack: white)
                    //print("\n\n state: \(state)")
                    gameAck.state = state
                }
                
                let skin: String = json["skin"] as! String
                //print("skin: \(skin)")
                gameAck.skin = skin
                
                let date: String = json["date"] as! String
                print("date: \(date)")
                gameAck.date = date
                
                let gameTschess: GameTschess = GameTschess(gameAck: gameAck)
                completion(gameTschess)
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }).resume()
    }
}
