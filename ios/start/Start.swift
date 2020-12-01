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
        self.testCount = 0
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
        self.testTaskLabel.isHidden = true
        
        // HINT
        self.setHintText()
        
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
    
    //MARK: Button ~ Login
    @IBAction func loginButtonClick(_ sender: UIButton) {
        self.dismissKeyboard()
        self.usernameTextString = usernameTextField.text!
        self.passwordTextString = passwordTextField.text!
        
        if(!usernameTextString!.isAlphanumeric || !passwordTextString!.isAlphanumeric){
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "PopInvalid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PopInvalid") as! PopDismiss
                self.present(viewController, animated: true, completion: nil)
            }
            return
        }
        self.activityIndicatorStart()
        
        let request: [String: String] = core.requestPayload(
            username: usernameTextString!.lowercased(),
            password: passwordTextString!)
        
        RequestLogin().execute(requestPayload: request) { (player) in
            if let player = player {
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! HomeActivity
                    viewController.player = player
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
                
                
                // HINT
                self.setHintText()
                
                let storyboard: UIStoryboard = UIStoryboard(name: "PopInvalid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PopInvalid") as! PopDismiss
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: Test
    @IBOutlet weak var testTaskImageView: UIImageView!
    @IBOutlet weak var testTaskLabel: UILabel!
    var testCount: Int
    
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
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "PopInvalid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PopInvalid") as! PopDismiss
                self.present(viewController, animated: true, completion: nil)
            }
            return
        }
        self.activityIndicatorStart()
        
        let request: [String: String] = core.requestPayload(
            username: usernameTextString!.lowercased(),
            password: passwordTextString!)
        
        RequestCreate().execute(requestPayload: request) { (player) in
            if let player = player {
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! HomeActivity
                    viewController.player = player
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
                let storyboard: UIStoryboard = UIStoryboard(name: "PopInvalid", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PopInvalid") as! PopDismiss
                self.present(viewController, animated: true, completion: nil)
            }
            
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
    
    @objc func testTaskIncrementer() {
        self.testCount += 1
        if(self.testCount < 3){
            return
        }
        if(self.testTaskLabel.isHidden){
            self.testTaskLabel.isHidden = false
        }
        self.testTaskLabel.text = String(testCount)
    }
    
    
    @objc func testTaskExecuter(){
        let rowA: [String] = ["RookBlack_x", "KnightBlack_x", "BishopBlack_x", "QueenBlack_x", "KingBlack_x", "BishopBlack_x", "KnightBlack_x", "RookBlack_x"]
        let rowB: [String] = ["PawnBlack_x", "PawnBlack_x", "PawnBlack_x", "PawnBlack_x", "PawnBlack_x", "PawnBlack_x", "PawnBlack_x", "PawnBlack_x"]
        var rowC: [String] = [String](repeating: "", count: 8)
        let rowD: [String] = [String](repeating: "", count: 8)
        
        rowC[6] = "PawnWhite"
        
        let rowE: [String] = [String](repeating: "", count: 8)
        var rowF: [String] = [String](repeating: "", count: 8)
        rowF[6] = "PawnBlack"
        
        let rowG: [String] = ["PawnWhite_x", "PawnWhite_x", "PawnWhite_x", "PawnWhite_x", "PawnWhite_x", "PawnWhite_x", "PawnWhite_x", "PawnWhite_x"]
        let rowH: [String] = ["RookWhite_x", "KnightWhite_x", "BishopWhite_x", "QueenWhite_x", "KingWhite_x", "BishopWhite_x", "KnightWhite_x", "RookWhite_x"]
        
        view.removeGestureRecognizer(self.dismissKeyboardGesture!)
        if(self.testCount == 3){
            let STATE = [rowH, rowG, rowF, rowE, rowD, rowC, rowB, rowA]
            let TURN = "WHITE"
            let REQUEST: [String: Any] = ["state": STATE, "turn": TURN]
            RequestTest().execute(requestPayload: REQUEST) { (game) in
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "dTschessP", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessP") as! Tschess
                    viewController.playerOther = game!.getPlayerOther(username: game!.white.username)
                    viewController.playerSelf = game!.white
                    viewController.game = game!
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }
            return
        }
        if(self.testCount == 4){
            let STATE = [[""]]
            let TURN = "WHITE"
            let REQUEST: [String: Any] = ["state": STATE, "turn": TURN]
            RequestTest().execute(requestPayload: REQUEST) { (game) in
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "dTschessP", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "dTschessP") as! Tschess
                    viewController.playerOther = game!.getPlayerOther(username: game!.black.username)
                    viewController.playerSelf = game!.black
                    viewController.game = game!
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }
            return
        }
        
        
    }
    
    @IBAction func buttonClickRecover(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: "PopRecover", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PopRecover") as! PopRecover
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
}

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
