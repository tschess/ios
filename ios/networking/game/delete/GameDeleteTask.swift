//
//  GameDeleteTask.swift
//  ios
//
//  Created by Matthew on 9/24/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class GameDeleteTask {
    
    func execute(id: String) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/delete/\(id)")!
        

        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
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
                //print(json)
            } catch let error {
                
          
                
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
}
