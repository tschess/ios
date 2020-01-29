//
//  PollingAgent.swift
//  ios
//
//  Created by Matthew on 9/24/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class PollingAgent {
    
    func execute(id: String, gamestate: Gamestate, completion: @escaping ((Gamestate?, Error?) -> Void)) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/polling/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                //print(json)
                
                let canonicalGamestateUpdateString = json["state"] as? [[String]]
                
                if(canonicalGamestateUpdateString == nil){
                    completion(nil, nil)
                    return
                }
                
                let playerWhite: Player = PlayerDeserializer().execute(dictionary: json["white"] as! [String: Any])
                gamestate.getGameModel().setUsernameWhite(usernameWhite: playerWhite.getUsername())
                
                let playerBlack: Player = PlayerDeserializer().execute(dictionary: json["black"] as! [String: Any])
                gamestate.getGameModel().setUsernameBlack(usernameBlack: playerBlack.getUsername())
                
                let matrixDeserializer = MatrixDeserializer()
                matrixDeserializer.setUsername(username: gamestate.getUsernameSelf())
                matrixDeserializer.setUsernameWhite(username: playerWhite.getUsername())
                matrixDeserializer.setUsernameBlack(username: playerBlack.getUsername())
                
                let gameStatus = json["status"]! as! String
                matrixDeserializer.setGameStatus(gameStatus: gameStatus)
                
                let orientationBlack = gamestate.getOrientationBlack()
                let tschessElementMatrix = matrixDeserializer.deserialize(stringRepresentation: canonicalGamestateUpdateString!, orientationBlack: orientationBlack)
                
                let lastMoveWhite =  json["white_update"] as! String
                //print("lastMoveWhite: \(lastMoveWhite)")
                
                let lastMoveBlack =  json["black_update"] as! String
                //print("lastMoveBlack: \(lastMoveBlack)")
                
                let usernameTurn =  json["turn"] as! String
                //print("usernameTurn: \(usernameTurn)")
                
                let checkOn =  json["check_on"] as! String
                //print("checkOn: \(checkOn)")
                
                let clock =  String(json["clock"] as! Int)
                //print("checkOn: \(checkOn)")
                gamestate.getGameModel().setClock(clock: clock)
                
                let winner =  json["winner"] as! String
                //print("winner: \(winner)")
                
                let drawProposer = json["catalyst"] as! String
                //print(" - drawProposer: \(drawProposer)")
                
                //print("status: \(gameStatus)")
                
                let updated = json["updated"] as! String
                ///print("server - updated: \(updated)")
                //print(" local - updated: \(gamestate.getUpdated()!)")
                
                let skin = json["skin"] as! String
                //print("- *** - skin: \(skin)")
                
                let gamestateUpdate = Gamestate(gameModel: gamestate.getGameModel(), tschessElementMatrix: gamestate.getTschessElementMatrix())
                gamestateUpdate.setPlayer(player: gamestate.getPlayer())
                gamestateUpdate.processPollingResult(
                    lastMoveWhite: lastMoveWhite,
                    lastMoveBlack: lastMoveBlack,
                    tschessElementMatrix: tschessElementMatrix,
                    usernameTurn: usernameTurn,
                    checkOn: checkOn,
                    winner: winner,
                    drawProposer: drawProposer)
                gamestateUpdate.setGameStatus(gameStatus: gameStatus)
                gamestateUpdate.setUpdated(updated: updated)
                gamestateUpdate.setWinner(winner: winner)
                gamestateUpdate.setSkin(skin: skin)
                
                let highlight =  json["highlight"] as! String
                if(highlight != "NONE"){
                    let highlightCharArray = Array(highlight)
                    let z0 = Int(String(highlightCharArray[0]))!
                    let z1 = Int(String(highlightCharArray[1]))!
                    let x0 = Int(String(highlightCharArray[2]))!
                    let x1 = Int(String(highlightCharArray[3]))!
                    gamestateUpdate.setHighlight(coords: [z0,z1,x0,x1])
                }
                
                completion(gamestateUpdate, nil)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
}
