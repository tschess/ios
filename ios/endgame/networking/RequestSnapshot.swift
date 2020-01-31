//
//  RequestSnapshot.swift
//  ios
//
//  Created by Matthew on 1/30/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestSnapshot {
    
    func execute(requestPayload: [String: String], endgameCore: EndgameCore, completion: @escaping ((EndgameCore?) -> Void)) {
        
        print("requestPayload: \(requestPayload)")
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/snapshot")!
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
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    print("e")
                    completion(nil)
                    return
                }
                
                let canonical: Bool = json["canonical"]! as! Bool
                endgameCore.canonical = canonical
                
                let usernameWhite: String = json["username_white"]! as! String
                endgameCore.usernameWhite = usernameWhite
                
                let usernameBlack: String = json["username_black"]! as! String
                endgameCore.usernameBlack = usernameBlack
                
                let moves: Int = json["moves"]! as! Int
                endgameCore.moves = moves
                
                print("outcome: \(json["outcome"])")
                //let outcome: OUTCOME = json["outcome"]! as! OUTCOME
                //endgameCore.outcome = outcome
                
                let state0: [[String]] = json["state"]! as! [[String]]
                
                let matrixDeserializer = MatrixDeserializer()
                matrixDeserializer.setUsername(username: usernameBlack)
                if(canonical){
                   matrixDeserializer.setUsername(username: usernameWhite)
                }
                matrixDeserializer.setUsernameWhite(username: usernameWhite)
                matrixDeserializer.setUsernameBlack(username: usernameBlack)
                matrixDeserializer.setGameStatus(gameStatus: "RESOLVED")
                let state = matrixDeserializer.deserialize(stringRepresentation: state0, orientationBlack: !canonical)
                endgameCore.state = state
                
                completion(endgameCore)
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
}
