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
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    @IBAction func buttonClickSubmit(_ sender: Any) {
        self.dismissKeyboard()
        self.usernameTextString = usernameTextField.text!
        self.passwordTextString = passwordTextField.text!
        
        if(usernameTextString!.isAlphanumeric && !passwordTextString!.isAlphanumeric){
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Invalid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Invalid") as! ComponentStart
                self.present(viewController, animated: true, completion: nil)
            }
            return
        }
        if(!usernameTextString!.isAlphanumeric && !passwordTextString!.isAlphanumeric){
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Create", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Create") as! Create
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            return
        }
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
      
        self.buttonSubmit.isHidden = true
        self.usernameTextField.isHidden = true
        self.passwordTextField.isHidden = true
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        
        let requestPayload = [
            "username": usernameTextString!,
            "password": passwordTextString!,
            "device": deviceId!
        ]
        RequestCreate().execute(requestPayload: requestPayload) { (player) in
            if let player = player {
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                    viewController.setPlayer(player: player)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    return
                }
            }
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                
                self.buttonSubmit.isHidden = false
                self.usernameTextField.isHidden = false
                self.passwordTextField.isHidden = false
                self.usernameTextField.text?.removeAll()
                self.usernameTextField.attributedPlaceholder = NSAttributedString(string: "username",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.magenta])
                self.passwordTextField.text?.removeAll()
                self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "password",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.magenta])
                let storyboard: UIStoryboard = UIStoryboard(name: "Invalid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Invalid") as! ComponentStart
                self.present(viewController, animated: true, completion: nil)
            }
            
        }
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
        
        //let totalWide = self.view.frame.size.width
        let totalHigh = self.view.frame.size.height
        
        self.titleLabelHeight.constant = totalHigh * 0.111
        
        self.logoHeight.constant = totalHigh * 0.371
        self.logoWidth.constant = logoHeight.constant
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.isHidden = true
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.usernameTextField.attributedPlaceholder = NSAttributedString(string: "username",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.magenta])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "password",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.magenta])
        
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
    
   
    
    
    
    
}
