//
//  Opponent.swift
//  ios
//
//  Created by S. Matthew English on 11/23/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Opponent: UIView {
    
    @IBOutlet weak var viewHolder00: UIView!
    @IBOutlet weak var imageAvatar00: UIImageView!
    @IBOutlet weak var labelUsername00: UILabel!
    @IBOutlet weak var viewHolder00width: NSLayoutConstraint!
    
    @IBOutlet weak var viewHolder01: UIView!
    @IBOutlet weak var imageAvatar01: UIImageView!
    @IBOutlet weak var labelUsername01: UILabel!
    @IBOutlet weak var viewHolder01width: NSLayoutConstraint!
    
    @IBOutlet weak var viewHolder02: UIView!
    @IBOutlet weak var imageAvatar02: UIImageView!
    @IBOutlet weak var labelUsername02: UILabel!
    @IBOutlet weak var viewHolder02width: NSLayoutConstraint!
    
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    
    
    //func showErrorMessage() {
    //
    //}
    
    

    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()

        let alertController = UIAlertController(title: "Error", message: "fuck", preferredStyle: UIAlertController.Style.alert)
       
            let fuck = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: { _ in
                alertWindow.isHidden = true
            })
        fuck.setValue(UIColor.red, forKey: "titleTextColor")
        
        alertController.addAction(fuck)
        
        alertWindow.windowLevel = UIWindow.Level.alert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    public func set(playerSelf: EntityPlayer) {
        
        //showErrorMessage()
        
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        self.viewHolder00width.constant = screenWidth/3
        self.viewHolder01width.constant = screenWidth/3
        self.viewHolder02width.constant = screenWidth/3
        
        
        
        viewHolder00.isHidden = true
        viewHolder01.isHidden = true
        viewHolder02.isHidden = true
        
        indicatorActivity.isHidden = false
        indicatorActivity.startAnimating()
        
        
       
        let gesture00 = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.viewHolder00.isUserInteractionEnabled = true
        self.viewHolder00.addGestureRecognizer(gesture00)
        
        let gesture01 = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.viewHolder01.isUserInteractionEnabled = true
        self.viewHolder01.addGestureRecognizer(gesture01)
        
        let gesture02 = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.viewHolder02.isUserInteractionEnabled = true
        self.viewHolder02.addGestureRecognizer(gesture02)
       
        
        
        print("!!!!!!")
        self.execute(id: playerSelf.id) { (result) in
            
            DispatchQueue.main.async() {
                self.indicatorActivity.stopAnimating()
                self.indicatorActivity.isHidden = true
            }
            
            let opponent00: EntityPlayer = ParsePlayer().execute(json: result[0])
            DispatchQueue.main.async() {
                self.labelUsername00.text = opponent00.username
                self.imageAvatar00.image = opponent00.getImageAvatar()
                self.imageAvatar00.layer.cornerRadius = self.imageAvatar00.frame.size.width/2
                self.imageAvatar00.clipsToBounds = true
                self.viewHolder00.isHidden = false
                
                
            }
            
            let opponent01: EntityPlayer = ParsePlayer().execute(json: result[1])
            DispatchQueue.main.async() {
                self.labelUsername01.text = opponent01.username
                self.imageAvatar01.image = opponent01.getImageAvatar()
                self.imageAvatar01.layer.cornerRadius = self.imageAvatar01.frame.size.width/2
                self.imageAvatar01.clipsToBounds = true
                self.viewHolder01.isHidden = false
                
            }
            
            let opponent02: EntityPlayer = ParsePlayer().execute(json: result[2])
            DispatchQueue.main.async() {
                self.labelUsername02.text = opponent02.username
                self.imageAvatar02.image = opponent02.getImageAvatar()
                self.imageAvatar02.layer.cornerRadius = self.imageAvatar02.frame.size.width/2
                self.imageAvatar02.clipsToBounds = true
                self.viewHolder02.isHidden = false
                
            }
            
            
        }
        
        
    }
    
    func execute(id: String, completion: @escaping ([[String: Any]]) -> Void) {
        
        //val url = "${ServerAddress().IP}:8080/player/rivals/${this.playerSelf.id}"
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/rivals/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion([["fail": "0"]])
                return
            }
            guard let data = data else {
                completion([["fail": "1"]])
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] else {
                    completion([["fail": "2"]])
                    return
                }
                completion(json)
                
                
                
                
            } catch _ {
                completion([["fail": "3"]])
            }
        }).resume()
    }
    
    
}
