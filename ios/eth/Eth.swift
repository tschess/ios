//
//  Eth.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import BlockiesSwift

class Eth: UIViewController, UITabBarDelegate, UITextFieldDelegate { //force people to use the QR code.
    
    //MARK: Constant
    let DATE_TIME: DateTime = DateTime()
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.removeGestureRecognizer(self.dismissKeyboardGesture!)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.addGestureRecognizer(self.dismissKeyboardGesture!)
        
        if nameTextField.isFirstResponder == true {
            nameTextField.placeholder = ""
            nameImageView.isHidden = true
        }
        if emailTextField.isFirstResponder == true {
            emailTextField.placeholder = ""
            emailImageView.isHidden = true
        }
    }
    
    //@IBOutlet weak var handleTextField: UITextField!
    //@IBOutlet weak var handleImageView: UIImageView!
    //var handle: String?
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressImageView: UIImageView!
    var address: String?
    
    
    
    @IBOutlet weak var nameTextField: UITextField! //username
       @IBOutlet weak var nameImageView: UIImageView!
       var name: String?
       
       @IBOutlet weak var surnameTextField: UITextField! //name
       @IBOutlet weak var surnameImageView: UIImageView!
       var surname: String?
   
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailImageView: UIImageView!
    var email: String?
    
    
    var scan: Bool?
    
    public func setScan(scan: Bool){
        self.scan = scan
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    let dateTime: DateTime = DateTime()
    
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameTextField.resignFirstResponder()
        
        self.emailTextField.resignFirstResponder()
        return true
    }
    
    var dismissKeyboardGesture: UITapGestureRecognizer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.activityIndicator.isHidden = true
        
        self.tabBarMenu.delegate = self
        
        self.nameTextField.delegate = self
        self.nameTextField.attributedPlaceholder = NSAttributedString(
            string: self.player!.username,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        self.nameTextField.isUserInteractionEnabled = false
        
        self.surnameTextField.delegate = self
       
        self.emailTextField.delegate = self
//        self.surnameTextField.attributedPlaceholder = NSAttributedString(
//            string: "name",
//            attributes: [
//                NSAttributedString.Key.foregroundColor: UIColor.lightGray
//        ])
        if #available(iOS 13.0, *) {
            let image = UIImage(systemName: "xmark")! //checkmark
            self.surnameImageView.image = image
            self.surnameImageView.tintColor = .red
        }
        
//        self.emailTextField.attributedPlaceholder = NSAttributedString(
//            string: "email",
//            attributes: [
//                NSAttributedString.Key.foregroundColor: UIColor.lightGray
//        ])
        if #available(iOS 13.0, *) {
            let image = UIImage(systemName: "xmark")!
            self.emailImageView.image = image
            self.emailImageView.tintColor = .red
        }
        
        self.dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        DispatchQueue.main.async() {
            let profileStoryboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
            let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "Profile") as! Profile
            profileViewController.setPlayer(player: self.player!)
            UIApplication.shared.keyWindow?.rootViewController = profileViewController
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            print("scanner")
            tabBar.selectedItem = nil
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Scanner", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Scanner") as! Scanner
                viewController.setPlayer(player: self.player!)
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            return
        default: // 1
            //pop up check that they added all the right shit before youu let them linq...
            print("linq...")
            
            tabBar.selectedItem = nil
            DispatchQueue.main.async() {
                self.activityIndicator!.isHidden = false
                self.activityIndicator!.startAnimating()
                
            }
            let updatePayload = [
                "id": "id",
                "address": "address",
                "name": "name",
                "surname": "surname",
                "email": "email",
                "updated": self.DATE_TIME.currentDateString()
                ] as [String: Any]
            
            //            UpdateAddress().execute(updatePayload: updatePayload) { (result) in
            DispatchQueue.main.async() {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
            }
            //                print("UpdateAddress: \(result)")
            //            }
        }
    }
    
    
    
}
