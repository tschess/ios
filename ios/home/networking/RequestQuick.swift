//
//  GetQuickTask.swift
//  ios
//
//  Created by Matthew on 12/13/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class RequestQuick {
    
    func success(id: String, completion: @escaping (Any?) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/quick/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
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
                print("\n\n--RequestQuick--\n\n")
                //print(json)
                if(json["error"] != nil){
                    let error = json["error"]! as! String
                    //print("\n\n ERROR: \(error)\n\n")
                    completion(error)
                    return
                }
                let opponent: PlayerCore = PlayerCoreDeserializer().execute(dictionary: json)
                completion(opponent)
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        })
        task.resume()
    }
}
