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
        
        if(!usernameTextString!.isAlphanumeric || !passwordTextString!.isAlphanumeric){
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Invalid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Invalid") as! CompInvalid
                self.present(viewController, animated: true, completion: nil)
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
            "username": usernameTextString!.lowercased(),
            "password": passwordTextString!,
            "device": deviceId!
        ]
        
        RequestCreate().execute(requestPayload: requestPayload) { (player) in
            if let player = player {
                DispatchQueue.main.async {
                    let height: CGFloat = UIScreen.main.bounds.height
                    if(height.isLess(than: 750)){
                        let storyboard: UIStoryboard = UIStoryboard(name: "HomeL", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeL") as! Home
                        viewController.playerSelf = player
                        self.navigationController?.pushViewController(viewController, animated: false)
                        return
                    }
                    let storyboard: UIStoryboard = UIStoryboard(name: "HomeP", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "HomeP") as! Home
                    viewController.playerSelf = player
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
                return
            }
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                
                self.buttonSubmit.isHidden = false
                self.usernameTextField.isHidden = false
                self.passwordTextField.isHidden = false
                self.usernameTextField.text?.removeAll()
                self.usernameTextField.attributedPlaceholder = NSAttributedString(string: "username: 6 alphanumeric characters",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                self.passwordTextField.text?.removeAll()
                self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "password: 6 alphanumeric characters",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                let storyboard: UIStoryboard = UIStoryboard(name: "Invalid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Invalid") as! CompInvalid
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
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "password (six characters)",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
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
