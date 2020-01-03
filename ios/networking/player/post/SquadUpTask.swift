//
//  SquadUpTask.swift
//  ios
//
//  Created by Matthew on 8/21/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class SquadUpTask {
    
    func execute(requestPayload: [String: String], player: Player, completion: @escaping (Player?, Error?) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/squad")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
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
              
                let fairyElementListAsStringArray = json["squad"]! as! [String]
                let fairyElementList = self.generateFairyElementList(fairyElementListAsStringArray: fairyElementListAsStringArray)
               
                let tschx = json["tschx"]! as! Int
          
                player.setTschx(tschx: String(tschx))
                player.setFairyElementList(fairyElementList: fairyElementList)
                completion(player, nil)
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        })
        
        task.resume()
    }
    
    public func generateFairyElementList(fairyElementListAsStringArray: [String])  -> [FairyElement] {
        var elementSquadList = [FairyElement]()
        for value in fairyElementListAsStringArray {
            elementSquadList.append(generateFairyElement(name: value))
        }
        return elementSquadList
    }
    
    func generateFairyElement(name: String) -> FairyElement {
        if(name.contains("Arrow")){
            return ArrowPawn()
        }
        if(name.contains("Grasshopper")){
            return Grasshopper()
        }
        if(name.contains("Hunter")){
            return Hunter()
        }
        if(name.contains("Landmine")){
            return LandminePawn()
        }
        if(name.contains("Medusa")){
            return Medusa()
        }
        if(name.contains("Spy")){
            return Spy()
        }
        return Amazon()
    }
    
}
