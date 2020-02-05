//
//  UpdateDevice.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import Foundation

class UpdateDevice {
    
    func execute(device: String, completion: @escaping ((Any?) -> Void)) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/clear/\(device)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    completion(nil)
                    return
                }
                if(json["error"] != nil){
                    _ = json["error"]! as! String
                    completion(nil)
                    return
                }
                completion(json)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
}
