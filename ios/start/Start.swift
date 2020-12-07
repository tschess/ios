//
//  ViewController.swift
//  ios
//
//  Created by Matthew on 7/25/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//
import UIKit
import IHKeyboardAvoiding

class Start: UIViewController, UITextFieldDelegate {
    
    required init?(coder aDecoder: NSCoder) {
        self.core = CoreStart()
        super.init(coder: aDecoder)
    }
    
    //MARK: Override
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = UIScreen.main.bounds.width
        let height: CGFloat = UIScreen.main.bounds.height
        
        self.titleLabelHeight.constant = height * 0.111
        
        self.logoHeight.constant = height * 0.371
        self.logoWidth.constant = logoHeight.constant
        
        self.buttonWidthLogin.constant = width/2
        self.buttonWidthCreate.constant = width/2
    }
    
    private func setHintText() {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let usernameHint = NSAttributedString(string: "username", attributes: attributes)
        let passwordHint = NSAttributedString(string: "password", attributes: attributes)
        self.usernameTextField.text?.removeAll()
        self.passwordTextField.text?.removeAll()
        self.usernameTextField.attributedPlaceholder = usernameHint
        self.passwordTextField.attributedPlaceholder = passwordHint
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NAVIGATION
        self.navigationController?.viewControllers = [self]
        self.core.printNavigationStack(navigationController: navigationController)
        
        // DELEGATE
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        // HIDE
        self.activityIndicator.isHidden = true
        
        // HINT
        self.setHintText()
        
        self.dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardGesture!)
        
        KeyboardAvoiding.avoidingView = self.contentView
    }
    
    //MARK: Layout ~ View
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentView: UIView!
    
    //MARK: Layout ~ Constraint
    @IBOutlet weak var titleLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var logoHeight: NSLayoutConstraint!
    @IBOutlet weak var logoWidth: NSLayoutConstraint!
    @IBOutlet weak var buttonWidthLogin: NSLayoutConstraint!
    @IBOutlet weak var buttonWidthCreate: NSLayoutConstraint!
    
    //MARK: Input
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var usernameTextString: String?
    var passwordTextString: String?
    
    //MARK: Button
    @IBOutlet weak var buttonRecover: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonCreate: UIButton!
    
    
    func renderAlphanumeric() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "🔤 Input invalid 🔢", message: "\nUsername and password must be alphanumeric.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            action.setValue(UIColor.lightGray, forKey: "titleTextColor")
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    //MARK: Button ~ Login
    @IBAction func loginButtonClick(_ sender: UIButton) {
        self.dismissKeyboard()
        self.usernameTextString = usernameTextField.text!
        self.passwordTextString = passwordTextField.text!
        
        if(!usernameTextString!.isAlphanumeric || !passwordTextString!.isAlphanumeric){
            self.renderAlphanumeric()
            return
        }
        self.activityIndicatorStart()
        
        let request: [String: String] = core.requestPayload(
            username: usernameTextString!.lowercased(),
            password: passwordTextString!)
        
        self.execute(requestPayload: request) { (result) in
            self.handleResult(result: result)
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
                self.buttonLogin.isHidden = false
                self.buttonCreate.isHidden = false
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
    
    func renderInvalid() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "🙅‍♀️ Input invalid 🙅‍♂️", message: "\nPlease re-evaluate input and try again.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            action.setValue(UIColor.lightGray, forKey: "titleTextColor")
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    //MARK: Common
    let core: CoreStart
    
    private func activityIndicatorStart() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.buttonLogin.isHidden = true
        self.buttonCreate.isHidden = true
        self.usernameTextField.isHidden = true
        self.passwordTextField.isHidden = true
    }
    
    @IBAction func createButtonClick(_ sender: UIButton) {
        self.dismissKeyboard()
        self.usernameTextString = usernameTextField.text!
        self.passwordTextString = passwordTextField.text!
        
        if(!usernameTextString!.isAlphanumeric && !passwordTextString!.isAlphanumeric){
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Create", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Create") as! Create
                self.navigationController?.pushViewController(viewController, animated: false)
            }
            return
        }
        if(!usernameTextString!.isAlphanumeric || !passwordTextString!.isAlphanumeric){
            self.renderAlphanumeric()
            return
        }
        self.activityIndicatorStart()
        
        let request: [String: String] = core.requestPayload(
            username: usernameTextString!.lowercased(),
            password: passwordTextString!)
        
        self.create(requestPayload: request) { (result) in
            
            //HANDLE RESULT...
            self.handleResult(result: result)
            
        }
        
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
    
    @IBAction func buttonClickRecover(_ sender: Any) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "🔐 Recover account 📧", message: "\nPlease send email to hello@tschess.io", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            action.setValue(UIColor.lightGray, forKey: "titleTextColor")
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    
    func execute(requestPayload: [String: String], completion: @escaping ([String: Any]) -> Void) {
        let url = URL(string: "http://\(ServerAddress().IP):8080/player/login")!
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
    
    
    func create(requestPayload: [String: String], completion: @escaping ([String: Any]) -> Void) {
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

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}



