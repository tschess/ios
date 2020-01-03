//
//  RequestMessage.swift
//  ios
//
//  Created by Matthew on 12/14/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestMessage {
    
    func execute(requestPayload: [String: Any], gameModel: Game, completion: @escaping ((Game?) -> Void)) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/message/request")!
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
                
                //print(json)
                
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
                
                completion(gameModel)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
}
