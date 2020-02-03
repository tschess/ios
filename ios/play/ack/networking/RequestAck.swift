//
//  RequestAck.swift
//  ios
//
//  Created by Matthew on 2/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestAck {
    
    func execute(requestPayload: [String: Any], tschessCore: TschessCore, completion: @escaping ((TschessCore?) -> Void)) {
        
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
                matrixDeserializer.setUsername(username: tschessCore.playerSelf.username)
                matrixDeserializer.setUsernameWhite(username: tschessCore.playerSelf.username)
                matrixDeserializer.setUsernameBlack(username: tschessCore.playerOppo.username)
                matrixDeserializer.setGameStatus(gameStatus: "ONGOING") ///cause its accept this will always be ongoing...
                
                
                let state0: [[String]] = json["state"]! as! [[String]]
                
                let white: Bool = json["white"] as! Bool
                print("white: \(white)")
                tschessCore.white = white
                
                let state = matrixDeserializer.deserialize(stringRepresentation: state0, orientationBlack: !white)
                //print("\n\n state: \(state)")
                tschessCore.state = state
                
                if(!white){
                    matrixDeserializer.setUsernameWhite(username: tschessCore.playerOppo.username)
                    matrixDeserializer.setUsernameBlack(username: tschessCore.playerSelf.username)
                    let state = matrixDeserializer.deserialize(stringRepresentation: state0, orientationBlack: white)
                    //print("\n\n state: \(state)")
                    tschessCore.state = state
                }
                
                let skin: String = json["skin"] as! String
                //print("skin: \(skin)")
                tschessCore.skin = skin
                
                
                completion(tschessCore)
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }).resume()
    }
}
