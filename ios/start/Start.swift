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
    
    //MARK: Constant
    let DATE_TIME: DateTime = DateTime()
    
    //MARK: Layout
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentView: UIView!
    
    //MARK: Input
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var usernameTextString: String?
    var passwordTextString: String?
    
    //MARK: Button
    @IBOutlet weak var buttonRecover: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonCreate: UIButton!
    
    //MARK: Test
    @IBOutlet weak var testTaskImageView: UIImageView!
    @IBOutlet weak var testTaskLabel: UILabel!
    var testTaskCounter: Int
    
    required init?(coder aDecoder: NSCoder) {
        self.testTaskCounter = 0
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.isHidden = true
        self.testTaskLabel.isHidden = true
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.usernameTextField.attributedPlaceholder = NSAttributedString(string: "username",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "password",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        let dismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboard)
        
        KeyboardAvoiding.avoidingView = self.contentView
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginButtonClick(_ sender: UIButton) {
        self.usernameTextString = usernameTextField.text!
        self.passwordTextString = passwordTextField.text!
        
        self.dismissKeyboard()
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.buttonLogin.isHidden = true
        self.buttonCreate.isHidden = true
        self.usernameTextField.isHidden = true
        self.passwordTextField.isHidden = true
        
        let updated = DATE_TIME.currentDateString() //this out to happen on the srver only...
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        
        let requestPayload = [
            "username": usernameTextString!,
            "password": passwordTextString!,
            "device": deviceId!,
            "updated": updated
        ]
        
        PlayerLogin().execute(requestPayload: requestPayload) { (player) in
            if let player = player {
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                    viewController.setPlayer(player: player)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    return
                }
            }
            print("fuq")
        }
    }
    
    @IBAction func createButtonClick(_ sender: UIButton) {
        
    }
    
}
