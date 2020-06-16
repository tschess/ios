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
    
    @IBOutlet weak var titleLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var logoHeight: NSLayoutConstraint!
    @IBOutlet weak var logoWidth: NSLayoutConstraint!
    
    @IBOutlet weak var buttonWidthLogin: NSLayoutConstraint!
    @IBOutlet weak var buttonWidthCreate: NSLayoutConstraint!
    
    @IBAction func loginButtonClick(_ sender: UIButton) {
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
        self.buttonLogin.isHidden = true
        self.buttonCreate.isHidden = true
        self.usernameTextField.isHidden = true
        self.passwordTextField.isHidden = true
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        
        var value: String = "NULL"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let note_key: String? = appDelegate.note_key
        if(note_key != nil){
            value = note_key!
        }
        
        let requestPayload = [
            "username": usernameTextString!.lowercased(),
            "password": passwordTextString!,
            "device": deviceId!,
            "note_key": value
        ]
        
        RequestLogin().execute(requestPayload: requestPayload) { (player) in
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
                self.buttonLogin.isHidden = false
                self.buttonCreate.isHidden = false
                self.usernameTextField.isHidden = false
                self.passwordTextField.isHidden = false
                self.usernameTextField.text?.removeAll()
                self.usernameTextField.attributedPlaceholder = NSAttributedString(string: "username",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                self.passwordTextField.text?.removeAll()
                self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "password",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                let storyboard: UIStoryboard = UIStoryboard(name: "Invalid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Invalid") as! CompInvalid
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func createButtonClick(_ sender: UIButton) {
        
        self.dismissKeyboard()
        self.usernameTextString = usernameTextField.text!
        self.passwordTextString = passwordTextField.text!
        
        if(!usernameTextString!.isAlphanumeric && !passwordTextString!.isAlphanumeric){
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Create", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Create") as! Create
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            return
        }
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
        self.buttonLogin.isHidden = true
        self.buttonCreate.isHidden = true
        self.usernameTextField.isHidden = true
        self.passwordTextField.isHidden = true
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        
        var value: String = "NULL"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let note_key: String? = appDelegate.note_key
        if(note_key != nil){
            value = note_key!
        }
        
        let requestPayload = [
            "username": usernameTextString!.lowercased(),
            "password": passwordTextString!,
            "device": deviceId!,
            "note_key": value
        ]
        
        RequestCreate().execute(requestPayload: requestPayload) { (player) in
            if let player = player {
                DispatchQueue.main.async {
                    let height: CGFloat = UIScreen.main.bounds.height
                    //SelectHome().execute(player: player, height: height)
                //}
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
                self.buttonLogin.isHidden = false
                self.buttonCreate.isHidden = false
                self.usernameTextField.isHidden = false
                self.passwordTextField.isHidden = false
                self.usernameTextField.text?.removeAll()
                self.usernameTextField.attributedPlaceholder = NSAttributedString(string: "username",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                self.passwordTextField.text?.removeAll()
                self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "password",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                let storyboard: UIStoryboard = UIStoryboard(name: "Invalid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Invalid") as! CompInvalid
                self.present(viewController, animated: true, completion: nil)
            }
            
        }
        
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.viewControllers = [self]
        //guard let navigationController = self.navigationController else { return }
        //var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        //navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
        //self.navigationController?.viewControllers = navigationArray
        if let viewControllers = self.navigationController?.viewControllers {
            for vc in viewControllers {
                //if vc.isKind(of: YourViewController.classForCoder()) {
                print("---")
                print("It is in stack \(String(describing: type(of: vc)))")
                print("---")
                //Your Process
                //}
            }
        }
        
        self.activityIndicator.isHidden = true
        self.testTaskLabel.isHidden = true
        
        self.usernameTextField.delegate = self
        //self.usernameTextField.tintColor = UIColor.magenta
        self.usernameTextField.attributedPlaceholder = NSAttributedString(string: "username",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        self.passwordTextField.delegate = self
        //self.passwordTextField.tintColor = UIColor.magenta
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
    
    @objc func testTaskIncrementer() {
        self.testTaskCounter += 1
        if(self.testTaskCounter < 3){
            return
        }
        if(self.testTaskLabel.isHidden){
            self.testTaskLabel.isHidden = false
        }
        self.testTaskLabel.text = String(testTaskCounter)
    }
    
    
    @objc func testTaskExecuter(){
        
        let rowA: [String] = ["RookBlack_x", "KnightBlack_x", "BishopBlack_x", "QueenBlack_x", "KingBlack_x", "BishopBlack_x", "KnightBlack_x", "RookBlack_x"]
        let rowB: [String] = ["PawnBlack_x", "PawnBlack_x", "PawnBlack_x", "PawnBlack_x", "PawnBlack_x", "PawnBlack_x", "PawnBlack_x", "PawnBlack_x"]
        var rowC: [String] = [String](repeating: "", count: 8)
        let rowD: [String] = [String](repeating: "", count: 8)
        //rowD[0] = "QueenBlack"
        
        rowC[6] = "PawnWhite"
        
        
        let rowE: [String] = [String](repeating: "", count: 8)
        var rowF: [String] = [String](repeating: "", count: 8)
        rowF[6] = "PawnBlack"
        
        let rowG: [String] = ["PawnWhite_x", "PawnWhite_x", "PawnWhite_x", "PawnWhite_x", "PawnWhite_x", "PawnWhite_x", "PawnWhite_x", "PawnWhite_x"]
        let rowH: [String] = ["RookWhite_x", "KnightWhite_x", "BishopWhite_x", "QueenWhite_x", "KingWhite_x", "BishopWhite_x", "KnightWhite_x", "RookWhite_x"]
        
        view.removeGestureRecognizer(self.dismissKeyboardGesture!)
        if(self.testTaskCounter == 3){
            let STATE = [rowH, rowG, rowF, rowE, rowD, rowC, rowB, rowA]
            let TURN = "WHITE"
            let REQUEST: [String: Any] = ["state": STATE, "turn": TURN]
            RequestTest().execute(requestPayload: REQUEST) { (game) in
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "dTschessP", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessP") as! Tschess
                    viewController.setOther(player: game!.getPlayerOther(username: game!.white.username))
                    viewController.setSelf(player: game!.white)
                    viewController.setGame(game: game!)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }
            return
        }
        if(self.testTaskCounter == 4){
            //print(" - testTaskCounter: \(testTaskCounter)")
            let STATE = [[""]]
            let TURN = "WHITE"
            let REQUEST: [String: Any] = ["state": STATE, "turn": TURN]
            RequestTest().execute(requestPayload: REQUEST) { (game) in
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "dTschessP", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessP") as! Tschess
                    viewController.setOther(player: game!.getPlayerOther(username: game!.black.username))
                    viewController.setSelf(player: game!.black)
                    viewController.setGame(game: game!)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }
            return
        }
        
        
    }
    
    @IBAction func buttonClickRecover(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "Recover", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Recover") as! CompRecov
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
}

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
