//
//  ViewController.swift
//  ios
//
//  Created by Matthew on 7/25/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//
import UIKit
import IHKeyboardAvoiding

class Create: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func buttonClickBack(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Start", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Start") as! Start
            //UIApplication.shared.keyWindow?.rootViewController = viewController
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    @IBAction func buttonClickSubmit(_ sender: Any) {
        self.dismissKeyboard()
        self.usernameTextString = usernameTextField.text!
        self.passwordTextString = passwordTextField.text!
        
        if(!usernameTextString!.isAlphanumeric || !passwordTextString!.isAlphanumeric){
            self.renderAlphanumeric()
            //DispatchQueue.main.async {
                //let storyboard: UIStoryboard = UIStoryboard(name: "PopInvalid", bundle: nil)
                //let viewController = storyboard.instantiateViewController(withIdentifier: "PopInvalid") as! PopDismiss
                //self.present(viewController, animated: true, completion: nil)
            //}
            return
        }
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        self.buttonSubmit.isHidden = true
        self.usernameTextField.isHidden = true
        self.passwordTextField.isHidden = true
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        
        let payload = [
            "username": usernameTextString!.lowercased(),
            "password": passwordTextString!,
            "device": deviceId!
        ]
        
        self.execute(requestPayload: payload) { (result) in
            self.handleResult(result: result)
        }
        //handleResult(result
        
        //RequestCreate().execute(requestPayload: requestPayload) { (player) in
        //    if let player = player {
        //        DispatchQueue.main.async {
        //            let height: CGFloat = UIScreen.main.bounds.height
        //            if(height.isLess(than: 750)){
        //                let storyboard: UIStoryboard = UIStoryboard(name: "HomeL", bundle: nil)
        //                let viewController = storyboard.instantiateViewController(withIdentifier: "HomeL") as! Home
        //                viewController.player = player
        //                self.navigationController?.pushViewController(viewController, animated: false)
        //                return
        //            }
        //            let storyboard: UIStoryboard = UIStoryboard(name: "HomeP", bundle: nil)
        //            let viewController = storyboard.instantiateViewController(withIdentifier: "HomeP") as! Home
        //            viewController.player = player
        //            self.navigationController?.pushViewController(viewController, animated: false)
        //        }
        //        return
        //    }
        //    DispatchQueue.main.async {
        //        self.activityIndicator.isHidden = true
        //        self.activityIndicator.stopAnimating()
        //
        //        self.buttonSubmit.isHidden = false
        //        self.usernameTextField.isHidden = false
        //        self.passwordTextField.isHidden = false
        //        self.usernameTextField.text?.removeAll()
        //        self.usernameTextField.attributedPlaceholder = NSAttributedString(string: "username: 6 alphanumeric characters",
        //                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        //        self.passwordTextField.text?.removeAll()
        //        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "password: 6 alphanumeric characters",
        //                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        //        let storyboard: UIStoryboard = UIStoryboard(name: "PopInvalid", bundle: nil)
        //        let viewController = storyboard.instantiateViewController(withIdentifier: "PopInvalid") as! PopDismiss
        //        self.present(viewController, animated: true, completion: nil)
        //    }
        //
        //}
    }
    
    func renderError() -> [String: String] {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "📡 Server error 👽", message: "\nCheck network connectivity.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            action.setValue(UIColor.lightGray, forKey: "titleTextColor")
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        return ["login": "error"]
    }
    
    func renderInvalid() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "🙅‍♀️ Input invalid 🙅‍♂️", message: "\nPlease re-evaluate input and try again.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            action.setValue(UIColor.lightGray, forKey: "titleTextColor")
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    func renderAlphanumeric() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "🔤 Input invalid 🔢", message: "\nUsername and password must be alphanumeric.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            action.setValue(UIColor.lightGray, forKey: "titleTextColor")
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    func handleResult(result: [String: Any]) {
        
        if (result["id"] as? String) != nil {
            let player: EntityPlayer = ParsePlayer().execute(json: result)
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                viewController.player = player
                self.navigationController?.pushViewController(viewController, animated: false)
            }
            return
        }
        if let error = result as? [String: String] {
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
               
                self.buttonSubmit.isHidden = false
                
                self.usernameTextField.isHidden = false
                self.passwordTextField.isHidden = false
            }
            let unknown = error["unknown"] == "login"
            if(unknown){
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "❓ Username unknown 🧐", message: "\nNo registered player under this name.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    action.setValue(UIColor.lightGray, forKey: "titleTextColor")
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
                return
            }
            let invalid = error["invalid"] == "login"
            if(invalid){
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "🔑 Incorrect password 😸", message: "\nPlease re-evaluate input and try again.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    action.setValue(UIColor.lightGray, forKey: "titleTextColor")
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
                return
            }
            let reserved = error["reserved"] == "create"
            if(reserved){
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "⚔️ Username reserved 😯", message: "\nThis username is reserved already! Please choose another.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    action.setValue(UIColor.lightGray, forKey: "titleTextColor")
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
                return
            }
        }
        self.renderInvalid()
    }
    
    @IBOutlet weak var titleLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var logoHeight: NSLayoutConstraint!
    @IBOutlet weak var logoWidth: NSLayoutConstraint!
    
    @IBOutlet weak var buttonSubmit: UIButton!
    
    //MARK: Layout
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentView: UIView!
    
    //MARK: Input
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var usernameTextString: String?
    var passwordTextString: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let height: CGFloat = UIScreen.main.bounds.height
        
        self.titleLabelHeight.constant = height * 0.111
        
        self.logoHeight.constant = height * 0.371
        self.logoWidth.constant = logoHeight.constant
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.isHidden = true
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.usernameTextField.attributedPlaceholder = NSAttributedString(string: "username (alphanumeric)",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "password (six characters)",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        self.dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardGesture!)
        
        KeyboardAvoiding.avoidingView = self.contentView
    }
    
    var dismissKeyboardGesture: UITapGestureRecognizer?
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
    }
    
    
    func execute(requestPayload: [String: String], completion: @escaping ([String: Any]) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/create")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPayload, options: .prettyPrinted)
        } catch _ {
            completion(self.renderError())
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(self.renderError())
                return
            }
            guard let data = data else {
                completion(self.renderError())
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(self.renderError())
                    return
                }
                completion(json)
            } catch _ {
                completion(self.renderError())
            }
        })
        task.resume()
    }
    
    
    
}
