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
    
    @IBAction func createButtonClick(_ sender: UIButton) {}
    
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
    
    @objc func testTaskIncrementer() {
        if(self.testTaskLabel.isHidden){
            self.testTaskLabel.isHidden = false
        }
        self.testTaskCounter += 1
        self.testTaskLabel.text = String(testTaskCounter)
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
        
        self.dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardGesture!)
        
        KeyboardAvoiding.avoidingView = self.contentView
        
        let testTaskIncrementer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.testTaskIncrementer))
        self.testTaskImageView.addGestureRecognizer(testTaskIncrementer)
        self.testTaskImageView.isUserInteractionEnabled = true
        let testTaskExecuter: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.testTaskExecuter))
        self.testTaskLabel.addGestureRecognizer(testTaskExecuter)
        self.testTaskLabel.isUserInteractionEnabled = true
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
        
        RequestLogin().execute(requestPayload: requestPayload) { (player) in
            if let player = player {
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                    viewController.setPlayer(player: player)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    return
                }
            }
            
        }
    }
    
    @objc func testTaskExecuter(){
        
        let rowA: [String] = ["RookBlack", "KnightBlack", "BishopBlack", "", "KingBlack", "BishopBlack", "KnightBlack", "RookBlack"]
        let rowB: [String] = ["PawnBlack", "PawnBlack", "", "PawnBlack", "PawnBlack", "PawnBlack", "PawnBlack", "PawnBlack"]
        let rowC: [String] = [String](repeating: "", count: 8)
        var rowD: [String] = [String](repeating: "", count: 8)
        rowD[0] = "QueenBlack"
        //rowD[7] = "QueenWhite"
        
        let rowE: [String] = [String](repeating: "", count: 8)
        let rowF: [String] = [String](repeating: "", count: 8)
        let rowG: [String] = ["PawnWhite", "PawnWhite", "PawnWhite", "PawnWhite", "PawnWhite", "PawnWhite", "PawnWhite", "PawnWhite"]
        let rowH: [String] = ["RookWhite", "KnightWhite", "BishopWhite", "QueenWhite", "KingWhite", "BishopWhite", "KnightWhite", "RookWhite"]
        
        view.removeGestureRecognizer(self.dismissKeyboardGesture!)
        if(self.testTaskCounter == 1){
            let STATE = [rowH, rowG, rowF, rowE, rowD, rowC, rowB, rowA]
            let TURN = "WHITE"
            let REQUEST: [String: Any] = ["state": STATE, "turn": TURN]
            RequestTest().execute(requestPayload: REQUEST) { (game) in
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Tschess", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Tschess") as! Tschess
                    viewController.setPlayerOther(playerOther: game!.getPlayerOther(username: game!.white.username))
                    viewController.setPlayerSelf(playerSelf: game!.white)
                    viewController.setGameTschess(gameTschess: game!)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }
            return
        }
        if(self.testTaskCounter == 2){
        print(" - testTaskCounter: \(testTaskCounter)")
            let STATE = [[""]]
            let TURN = "WHITE"
            let REQUEST: [String: Any] = ["state": STATE, "turn": TURN]
            RequestTest().execute(requestPayload: REQUEST) { (game) in
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Tschess", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Tschess") as! Tschess
                    viewController.setPlayerOther(playerOther: game!.getPlayerOther(username: game!.black.username))
                    viewController.setPlayerSelf(playerSelf: game!.black)
                    viewController.setGameTschess(gameTschess: game!)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }
            return
        }
        if(self.testTaskCounter == 3){
            let STATE = [["DEFAULT"]]
            let TURN = "WHITE"
            let REQUEST: [String: Any] = ["state": STATE, "turn": TURN]
            RequestTest().execute(requestPayload: REQUEST) { (game) in
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Tschess", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Tschess") as! Tschess
                    viewController.setPlayerOther(playerOther: game!.getPlayerOther(username: game!.white.username))
                    viewController.setPlayerSelf(playerSelf: game!.white)
                    viewController.setGameTschess(gameTschess: game!)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }
            return
        }
        if(self.testTaskCounter == 4){
           let STATE = [[""]]
            let TURN = "BLACK"
            let REQUEST: [String: Any] = ["state": STATE, "turn": TURN]
            RequestTest().execute(requestPayload: REQUEST) { (game) in
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Tschess", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Tschess") as! Tschess
                    viewController.setPlayerOther(playerOther: game!.getPlayerOther(username: game!.black.username))
                    viewController.setPlayerSelf(playerSelf: game!.black)
                    viewController.setGameTschess(gameTschess: game!)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }
        }
    }
    
}
