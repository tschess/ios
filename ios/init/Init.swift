//
//  Initializer.swift
//  ios
//
//  Created by Matthew on 9/20/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class Init: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        
        let device = UIDevice.current.identifierForVendor?.uuidString
        if(device == nil) {
            self.start()
            return
        }
        self.execute(device: device!) { (result) in
            if(result["fail"] != nil) {
                self.start()
                return
            }
            DispatchQueue.main.async {
                let player: EntityPlayer = ParsePlayer().execute(json: result)
                let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                viewController.player = player
                self.navigationController?.pushViewController(viewController, animated: false)
                
                if let viewControllers = self.navigationController?.viewControllers {
                      for vc in viewControllers {
                        print("It is in stack \(String(describing: type(of: vc)))")
                      }
                }
                
               
            }
        }
    }
    
    private func start() {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Start", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Start") as! Start
            self.navigationController?.pushViewController(viewController, animated: false)
            
        }
    }
    
    func execute(device: String, completion: @escaping ([String: Any]) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/device/\(device)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(["fail": "0"])
                return
            }
            guard let data = data else {
                completion(["fail": "1"])
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(["fail": "2"])
                    return
                }
                completion(json)
                
            } catch _ {
                completion(["fail": "3"])
            }
        }).resume()
    }
}
