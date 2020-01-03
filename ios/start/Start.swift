//
//  ViewController.swift
//  ios
//
//  Created by Matthew on 7/25/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//
import UIKit
import PushNotifications

class Start: UIViewController, UITextFieldDelegate {
    
    //@IBOutlet weak var recoverAccountButton: UIButton!
    @IBOutlet weak var recoverAccountButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var deviceId: String?
    let dateTime: DateTime = DateTime()
    
    @IBOutlet weak var contentView: UIView!
    //MARK: Properties
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonCreate: UIButton!
    
    @IBOutlet weak var textFieldUsername: UITextField!
    var username: String?
    @IBOutlet weak var textFieldPassword: UITextField!
    var password: String?
    
    @IBOutlet weak var easterEggImageView: UIImageView!
    @IBOutlet weak var easterEggLabel: UILabel!
    var easterEggCounter: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.isHidden = true
        
        self.deviceId = UIDevice.current.identifierForVendor?.uuidString
        self.easterEggCounter = 0
        
        easterEggLabel.isHidden = true
        
        textFieldUsername.delegate = self
        textFieldUsername.attributedPlaceholder = NSAttributedString(string: "username",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textFieldPassword.delegate = self
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: "password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        easterEggImageView.alpha = 0.75
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let easterEggIncrementer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.easterEggIncrementer))
        easterEggImageView.addGestureRecognizer(easterEggIncrementer)
        easterEggImageView.isUserInteractionEnabled = true
        let easterEggSender: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.easterEggSender))
        easterEggLabel.addGestureRecognizer(easterEggSender)
        easterEggLabel.isUserInteractionEnabled = true
    }
    
    @objc func easterEggIncrementer() {
        easterEggCounter! += 1
        easterEggLabel.isHidden = false
        easterEggLabel.text = String(easterEggCounter!)
    }
    
    @objc func easterEggSender(){
        let currentDateTime = dateTime.currentDateString()
        if(easterEggCounter == 1){
            let requestPayload: [String: Any] = [
                "state": testBoardState(),
                "catalyst": "NONE",
                "check_on": "NONE",
                "winner": "TBD",
                "updated": currentDateTime,
                "created": currentDateTime
            ]
            TestTask0().execute(requestPayload: requestPayload) { (result) in
                let gamestate: Gamestate = result
                StoryboardSelector().chess(gamestate: gamestate)
            }
        }
        if(easterEggCounter == 2){
            let requestPayload: [String: Any] = [
                "state": NSNull(),
                "catalyst": "NONE",
                "check_on": "NONE",
                "winner": "TBD",
                "updated": currentDateTime,
                "created": currentDateTime
            ]
            TestTask1().execute(requestPayload: requestPayload) { (result) in
                let gamestate: Gamestate = result
                StoryboardSelector().chess(gamestate: gamestate)
            }
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldUsername.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        return true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: self.contentView.frame.size.height + 16)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: self.contentView.frame.size.height + 16)
    }
    
    func animateViewMoving(up: Bool, moveValue: CGFloat){
        let movementDuration: TimeInterval = 0.2
        let movement: CGFloat = (up ? -moveValue : moveValue)
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    //MARK: Actions
    @IBAction func loginButtonClick(_ sender: UIButton) {
        username = textFieldUsername.text!
        password = textFieldPassword.text!
        
        self.dismissKeyboard()
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.buttonLogin.isHidden = true
        self.buttonCreate.isHidden = true
        self.textFieldUsername.isHidden = true
        self.textFieldPassword.isHidden = true
        
        let updated = dateTime.currentDateString()
        let api = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        
        let requestPayload = ["name":username!,"password":password!,"device":deviceId!,"updated":updated,"api":api]
        LoginTask().execute(requestPayload: requestPayload) { (result, error) in
            if(error != nil) {
                let value = error!
                switch value {
                case "nonexistent":
                    DispatchQueue.main.async() {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        
                        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                        let myString  = "no such username"
                        var myMutableString = NSMutableAttributedString()
                        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                        alertController.setValue(myMutableString, forKey: "attributedTitle")
                        let message  = "\nplease check input\nvalues and try again"
                        var messageMutableString = NSMutableAttributedString()
                        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                        messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                        alertController.setValue(messageMutableString, forKey: "attributedMessage")
                        let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.okHandler)
                        action.setValue(Colour().getRed(), forKey: "titleTextColor")
                        alertController.addAction(action)
                        alertController.view.backgroundColor = UIColor.black
                        alertController.view.layer.cornerRadius = 40
                        self.present(alertController, animated: true, completion: nil)
                    }
                case "password":
                    DispatchQueue.main.async() {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        
                        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                        let myString = "incorrect password"
                        var myMutableString = NSMutableAttributedString()
                        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                        alertController.setValue(myMutableString, forKey: "attributedTitle")
                        let message  = "\nplease check input\nvalues and try again"
                        var messageMutableString = NSMutableAttributedString()
                        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                        messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                        alertController.setValue(messageMutableString, forKey: "attributedMessage")
                        let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.okHandler)
                        action.setValue(Colour().getRed(), forKey: "titleTextColor")
                        alertController.addAction(action)
                        alertController.view.backgroundColor = UIColor.black
                        alertController.view.layer.cornerRadius = 40
                        self.present(alertController, animated: true, completion: nil)
                    }
                default:
                    DispatchQueue.main.async() {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        
                        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                        let myString = "server error"
                        var myMutableString = NSMutableAttributedString()
                        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                        alertController.setValue(myMutableString, forKey: "attributedTitle")
                        let message = "\nplease try again later"
                        var messageMutableString = NSMutableAttributedString()
                        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                        messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                        alertController.setValue(messageMutableString, forKey: "attributedMessage")
                        let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.okHandler)
                        action.setValue(Colour().getRed(), forKey: "titleTextColor")
                        alertController.addAction(action)
                        alertController.view.backgroundColor = UIColor.black
                        alertController.view.layer.cornerRadius = 40
                        self.present(alertController, animated: true, completion: nil)
                    }
                    return
                }
            }
            else if let result = result {
                try? PushNotifications.shared.clearDeviceInterests()
                try? PushNotifications.shared.addDeviceInterest(interest: result.getId())
                StoryboardSelector().home(player: result)
            }
        }
    }
    
    func okHandler(action: UIAlertAction) {
        StoryboardSelector().start()
    }
    
    @IBAction func createButtonClick(_ sender: UIButton) {
        username = textFieldUsername.text!
        password = textFieldPassword.text!
        
        self.dismissKeyboard()
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.buttonLogin.isHidden = true
        self.buttonCreate.isHidden = true
        self.textFieldUsername.isHidden = true
        self.textFieldPassword.isHidden = true
        
        if(username!.isEmpty || password!.isEmpty){
            DispatchQueue.main.async() {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                let myString  = "welcome to tschess"
                var myMutableString = NSMutableAttributedString()
                myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                alertController.setValue(myMutableString, forKey: "attributedTitle")
                let message  = "\nenter your username/password\nand click »create« to begin"
                var messageMutableString = NSMutableAttributedString()
                messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                alertController.setValue(messageMutableString, forKey: "attributedMessage")
                let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.okHandler)
                action.setValue(Colour().getRed(), forKey: "titleTextColor")
                alertController.addAction(action)
                alertController.view.backgroundColor = UIColor.black
                alertController.view.layer.cornerRadius = 40
                self.present(alertController, animated: true, completion: nil)
            }
            return
        }
        
        let updated = dateTime.currentDateString()
        let api = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let requestPayload = [
            "name": username!,
            "password": password!,
            "device": deviceId!,
            "updated": updated,
            "created": updated,
            "api": api
        ]
        PlayerCreate().execute(requestPayload: requestPayload) { (result, error) in
            if(error != nil) {
                let value = error!
                switch value {
                case "username":
                    DispatchQueue.main.async() {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        
                        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                        let myString = "invalid username"
                        var myMutableString = NSMutableAttributedString()
                        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                        alertController.setValue(myMutableString, forKey: "attributedTitle")
                        let message = "\nplease select another username\nand try again"
                        var messageMutableString = NSMutableAttributedString()
                        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                        messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                        alertController.setValue(messageMutableString, forKey: "attributedMessage")
                        let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.okHandler)
                        action.setValue(Colour().getRed(), forKey: "titleTextColor")
                        alertController.addAction(action)
                        alertController.view.backgroundColor = UIColor.black
                        alertController.view.layer.cornerRadius = 40
                        self.present(alertController, animated: true, completion: nil)
                    }
                case "reserved":
                    DispatchQueue.main.async() {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        
                        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                        let myString = "reserved username"
                        var myMutableString = NSMutableAttributedString()
                        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                        alertController.setValue(myMutableString, forKey: "attributedTitle")
                        let message = "\nthis name is already in use\nplease select another"
                        var messageMutableString = NSMutableAttributedString()
                        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                        messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                        alertController.setValue(messageMutableString, forKey: "attributedMessage")
                        let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.okHandler)
                        action.setValue(Colour().getRed(), forKey: "titleTextColor")
                        alertController.addAction(action)
                        alertController.view.backgroundColor = UIColor.black
                        alertController.view.layer.cornerRadius = 40
                        self.present(alertController, animated: true, completion: nil)
                    }
                default:
                    DispatchQueue.main.async() {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        
                        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                        let myString = "server error"
                        var myMutableString = NSMutableAttributedString()
                        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)])
                        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0, length:myString.count))
                        alertController.setValue(myMutableString, forKey: "attributedTitle")
                        let message = "\nplease try again later"
                        var messageMutableString = NSMutableAttributedString()
                        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)])
                        messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:message.count))
                        alertController.setValue(messageMutableString, forKey: "attributedMessage")
                        let action = UIAlertAction(title: "ack", style: UIAlertAction.Style.default, handler: self.okHandler)
                        action.setValue(Colour().getRed(), forKey: "titleTextColor")
                        alertController.addAction(action)
                        alertController.view.backgroundColor = UIColor.black
                        alertController.view.layer.cornerRadius = 40
                        self.present(alertController, animated: true, completion: nil)
                    }
                    return
                }
            }
            else if let result = result {
                try? PushNotifications.shared.clearDeviceInterests()
                try? PushNotifications.shared.addDeviceInterest(interest: result.getId())
                StoryboardSelector().home(player: result)
            }
        }
    }
    
    func testBoardState() -> [[String]] {
        
        var row_0 = [String](repeating: "", count: 8)
        var row_1 = [String](repeating: "", count: 8)
        var row_2 = [String](repeating: "", count: 8)
        var row_3 = [String](repeating: "", count: 8)
        var row_4 = [String](repeating: "", count: 8)
        var row_5 = [String](repeating: "", count: 8)
        var row_6 = [String](repeating: "", count: 8)
        var row_7 = [String](repeating: "", count: 8)
        
        row_0[0] = "WhiteRook_x"
        row_0[1] = "WhiteKnight"
        row_0[2] = "WhiteBishop"
        row_1[5] = "WhiteGrasshopper"
        row_0[4] = "WhiteKing_x"
        //row_0[5] = "WhiteBishop"
        row_0[6] = "WhiteKnight"
        row_0[7] = "WhiteRook_x"

        row_1[0] = "WhitePawn_x"
        row_1[1] = "WhitePawn_x"
        row_1[2] = "WhitePawn_x"
        row_1[3] = "WhitePawn_x"
        //row_1[4] = "WhitePawn_x"
        //row_1[5] = "WhitePawn_x"//
        row_1[6] = "WhitePawn_x"
        row_1[7] = "WhitePawn_x"
        
        row_1[5] = "WhiteGrasshopper"
        row_2[4] = "BlackPawn_x"
        row_4[4] = "BlackPawn_x"
        //row_6[4] = "BlackKing_x"
        
        row_3[1] = "WhiteQueen"
        //row_3[2] = "WhiteBishop"
//
//
//        row_1[2] = "BlackGrasshopper"
//        row_2[1] = "WhitePawn_x"
//        row_4[1] = "WhitePawn_x"
//        row_6[1] = "WhiteKing_x"
        
        row_6[0] = "BlackPawn_x"
        row_6[1] = "BlackPawn_x"
        row_6[2] = "BlackPawn_x"
        row_6[3] = "BlackPawn_x"
        //row_6[4] = "BlackPawn_x"
        //row_6[5] = "BlackPawn_x"//
        row_6[6] = "BlackPawn_x"
        row_6[7] = "BlackPawn_x"

        row_7[0] = "BlackRook_x"
        row_7[1] = "BlackKnight"
        row_7[2] = "BlackBishop"
        //row_7[3] = "BlackQueen"
        row_7[4] = "BlackKing_x"
        //row_7[5] = "BlackBishop"
        row_7[6] = "BlackKnight"
        row_7[7] = "BlackRook_x"
        
        return [row_7, row_6, row_5, row_4, row_3, row_2, row_1, row_0]
    }
    
    @IBAction func recoverAccountButtonClick(_ sender: Any) {
        //print("fuck")
    }
    
}
