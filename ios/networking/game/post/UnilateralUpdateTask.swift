//
//  UnilateralUpdateTask.swift
//  ios
//
//  Created by Matthew on 10/18/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import Foundation

class UnilateralUpdateTask {
    
    func execute(requestPayload: [String: String], operationRoute: String) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/\(operationRoute)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
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
