//
//  Eth.swift
//  ios
//
//  Created by Matthew on 11/22/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit
import BlockiesSwift

class Address: UIViewController, UITabBarDelegate, UITextFieldDelegate { //force people to use the QR code.
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if inputTextFieldName.isFirstResponder == true {
            inputTextFieldName.placeholder = ""
            inputImageName.isHidden = true
        }
        if inputTextFieldSurname.isFirstResponder == true {
            inputTextFieldSurname.placeholder = ""
            inputImageSurname.isHidden = true
        }
        if inputTextFieldEmail.isFirstResponder == true {
            inputTextFieldEmail.placeholder = ""
            inputImageEmail.isHidden = true
        }
    }
    
    @IBOutlet weak var inputTextFieldName: UITextField!
    @IBOutlet weak var inputImageName: UIImageView!
    
    @IBOutlet weak var inputTextFieldSurname: UITextField!
    @IBOutlet weak var inputImageSurname: UIImageView!
    
    @IBOutlet weak var inputTextFieldEmail: UITextField!
    @IBOutlet weak var inputImageEmail: UIImageView!
    
    var scan: Bool?
    
    public func setScan(scan: Bool){
        self.scan = scan
    }
    
    @IBOutlet weak var blockieImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    let dateTime: DateTime = DateTime()
    
    var player: Player?
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.inputTextFieldName.resignFirstResponder()
        self.inputTextFieldSurname.resignFirstResponder()
        self.inputTextFieldEmail.resignFirstResponder()
        return true
    }
    
    
    var flashTextView: UITapGestureRecognizer?
    var dismissKeyboardGesture: UITapGestureRecognizer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.activityIndicator.isHidden = true
        
        self.tabBarMenu.delegate = self
        
        self.inputTextFieldName.delegate = self
        self.inputTextFieldSurname.delegate = self
        self.inputTextFieldEmail.delegate = self
        self.inputTextFieldName.attributedPlaceholder = NSAttributedString(
            string: "Max",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
        if #available(iOS 13.0, *) {
            let image = UIImage(systemName: "xmark")! //checkmark
            self.inputImageName.image = image
            self.inputImageName.tintColor = .red
        }
        
        self.inputTextFieldSurname.attributedPlaceholder = NSAttributedString(
            string: "Musterman",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
        if #available(iOS 13.0, *) {
            let image = UIImage(systemName: "xmark")!
            self.inputImageSurname.image = image
            self.inputImageSurname.tintColor = .red
        }
        
        self.inputTextFieldEmail.attributedPlaceholder = NSAttributedString(
            string: "max.musterman@gmx.com",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
        if #available(iOS 13.0, *) {
            let image = UIImage(systemName: "xmark")!
            self.inputImageEmail.image = image
            self.inputImageEmail.tintColor = .red
        }
        
        let dismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboard)
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().purchase(player: self.player!, remaining: 13)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            print("scanner")
            StoryboardSelector().scanner(player: self.player!)
            return
        case 2:
            print("linq...")
            //pop up check that they added all the right shit before youu let them linq...
            return
        default:
            return
        }
    }
    
    
    
}



