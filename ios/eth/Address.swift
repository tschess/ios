//
//  Eth.swift
//  ios
//
//  Created by Matthew on 11/22/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit
import BlockiesSwift

class Address: UIViewController, UITabBarDelegate, UITextViewDelegate { //force people to use the QR code.
    
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
    
    var flashTextView: UITapGestureRecognizer?
    var dismissKeyboardGesture: UITapGestureRecognizer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        self.activityIndicator.isHidden = true
        
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.tabBarMenu.delegate = self
//
//        self.flashTextView = UITapGestureRecognizer(target: self, action: #selector(self.flash))
//        self.dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//
//        self.ethAddressTextView.delegate = self
//        self.ethAddressTextView.textColor = Colour().getRed()
//        self.ethAddressTextView.tintColor = Colour().getRed()
//        self.ethAddressTextView.backgroundColor = UIColor.black
//
//        let address = self.player!.getAddress()
//        if(address != "TBD"){
//
//            self.blockiesImageView.image = Blockies(seed: address.lowercased()).createImage()
//
//            self.ethAddressTextView.text = address.insertSeparator("\r", atEvery: 14)
//            self.ethAddressTextView.centerContentVertically()
//            self.ethAddressTextView.addGestureRecognizer(flashTextView!)
//            self.ethAddressTextView.isEditable = false
//            self.ethAddressTextView.isSelectable = false
//
//            self.linkAddressButton.alpha = 1
//            self.linkAddressButton.isUserInteractionEnabled = true
//
//            if(self.scan!){
//                self.ethAddressTextView.alpha = 1
//                self.titleLabel.text = "account affiliation"
//                self.linkAddressButton.setTitle("submit", for: .normal)
//                return
//            }
//            self.ethAddressTextView.alpha = 0.8
//            self.titleLabel.text = "validation pending"
//            self.linkAddressButton.setTitle("reset" , for: .normal)
//            return
//        }
//        self.blockiesImageView.image = Blockies(seed: "0x13F74043eA61FE1BC62966A43f9cE9abbAD884E9".lowercased()).createImage()
//
//        self.titleLabel.text = "account affiliation"
//
//        self.ethAddressTextView.text = "0x..."
//        self.ethAddressTextView.centerContentVertically()
//        self.ethAddressTextView.isUserInteractionEnabled = true
//        self.ethAddressTextView.isSelectable = true
//        self.ethAddressTextView.isEditable = true
//        self.ethAddressTextView.alpha = 1
//
//        self.linkAddressButton.setTitle("submit", for: .normal)
//        self.linkAddressButton.isUserInteractionEnabled = false
//        self.linkAddressButton.alpha = 0.6
//    }
    
//    @IBAction func linkAddressButtonClick(_ sender: Any) {
//        var requestPayload = ["id": self.player!.getId(), "updated": dateTime.currentDateString()]
//
//        if(self.linkAddressButton.titleLabel!.text == "submit"){
//            let address = self.ethAddressTextView.text!.replacingOccurrences(of: "\r", with: "")
//            requestPayload["address"] = address
//            UpdateAddress().execute(requestPayload: requestPayload)  { (result) in
//                self.player!.setAddress(address: address)
//            }
//            self.ethAddressTextView.text = address.insertSeparator("\r", atEvery: 14)
//            self.ethAddressTextView.centerContentVertically()
//            self.ethAddressTextView.addGestureRecognizer(flashTextView!)
//            self.ethAddressTextView.isEditable = false
//            self.ethAddressTextView.isSelectable = false
//            self.ethAddressTextView.alpha = 0.8
//
//            self.linkAddressButton.alpha = 1
//            self.linkAddressButton.isUserInteractionEnabled = true
//            self.titleLabel.text = "validation pending"
//            self.linkAddressButton.setTitle("reset" , for: .normal)
//        }
//        if(self.linkAddressButton.titleLabel!.text == "reset"){
//            let address: String = "TBD"
//            requestPayload["address"] = address
//            UpdateAddress().execute(requestPayload: requestPayload)  { (result) in
//                self.player!.setAddress(address: address)
//            }
//            self.blockiesImageView.image = Blockies(seed: "0x13F74043eA61FE1BC62966A43f9cE9abbAD884E9".lowercased()).createImage()
//
//            self.titleLabel.text = "account affiliation"
//
//            self.ethAddressTextView.removeGestureRecognizer(self.flashTextView!)
//            self.ethAddressTextView.text = "0x..."
//            self.ethAddressTextView.centerContentVertically()
//            self.ethAddressTextView.isUserInteractionEnabled = true
//            self.ethAddressTextView.isSelectable = true
//            self.ethAddressTextView.isEditable = true
//            self.ethAddressTextView.alpha = 1
//
//            self.linkAddressButton.setTitle("submit", for: .normal)
//            self.linkAddressButton.isUserInteractionEnabled = false
//            self.linkAddressButton.alpha = 0.6
//        }
//
//    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        view.addGestureRecognizer(self.dismissKeyboardGesture!)
//
//        self.ethAddressTextView.text = ""
//        self.ethAddressTextView.removeGestureRecognizer(self.flashTextView!)
//
//        self.linkAddressButton.setTitle("..." , for: .normal)
//        self.linkAddressButton.isUserInteractionEnabled = false
//        self.linkAddressButton.alpha = 0.6
//    }
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        textView.resignFirstResponder()
//        view.removeGestureRecognizer(self.dismissKeyboardGesture!)
//
//        if(!self.validHex(string: self.ethAddressTextView.text!.replacingOccurrences(of: "\r", with: ""))){
//
//            self.ethAddressTextView.removeGestureRecognizer(self.flashTextView!)
//            self.ethAddressTextView.text = "0x..."
//            self.ethAddressTextView.centerContentVertically()
//            self.ethAddressTextView.isUserInteractionEnabled = true
//            self.ethAddressTextView.isSelectable = true
//            self.ethAddressTextView.isEditable = true
//            self.ethAddressTextView.alpha = 1
//
//            self.linkAddressButton.setTitle("invalid input", for: .normal)
//            self.linkAddressButton.isUserInteractionEnabled = false
//            self.linkAddressButton.alpha = 1.0
//            return
//        }
//
//        if(self.ethAddressTextView.text!.replacingOccurrences(of: "\r", with: "").count < 42){
//
//            self.ethAddressTextView.removeGestureRecognizer(self.flashTextView!)
//            self.ethAddressTextView.text = "0x..."
//            self.ethAddressTextView.centerContentVertically()
//            self.ethAddressTextView.isUserInteractionEnabled = true
//            self.ethAddressTextView.isSelectable = true
//            self.ethAddressTextView.isEditable = true
//            self.ethAddressTextView.alpha = 1
//
//            self.linkAddressButton.setTitle("invalid input", for: .normal)
//            self.linkAddressButton.isUserInteractionEnabled = false
//            self.linkAddressButton.alpha = 1.0
//            return
//        }
//
//        self.ethAddressTextView.text = self.ethAddressTextView.text.replacingOccurrences(of: "\r", with: "")
//
//        self.blockiesImageView.image = Blockies(seed: self.ethAddressTextView.text!.lowercased()).createImage()
//        self.ethAddressTextView.text = self.ethAddressTextView.text.insertSeparator("\r", atEvery: 14)
//        self.ethAddressTextView.centerContentVertically()
//
//        self.linkAddressButton.setTitle("submit", for: .normal)
//        self.linkAddressButton.alpha = 1
//        self.linkAddressButton.isUserInteractionEnabled = true
//    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if(text == "\n") {
//            textView.resignFirstResponder()
//            self.textViewDidEndEditing(self.ethAddressTextView)
//            return true
//        }
//        self.ethAddressTextView.text = textView.text!.replacingOccurrences(of: "\r", with: "")
//        self.ethAddressTextView.text = self.ethAddressTextView.text.insertSeparator("\r", atEvery: 14)
//        self.ethAddressTextView.centerContentVertically()
//        return true
//    }
//
//    private func invalidInput(message: String) {
//        self.linkAddressButton.setTitle(message, for: .normal)
//        self.linkAddressButton.alpha = 0.6
//        self.flash()
//        let generator = UIImpactFeedbackGenerator(style: .light)
//        generator.impactOccurred()
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//        view.removeGestureRecognizer(self.dismissKeyboardGesture!)
//    }
//
//    private func validHex(string: String) -> Bool {
//        let characterSet: CharacterSet = ["0","1","2","3","4","5","6","7","8","9","A","a","B","b","C","c","D","d","E","e","F","f","x"]
//        for character in string.enumerated() {
//            if(!CharacterSet(charactersIn: String(character.element)).isSubset(of: characterSet)){
//                return false
//            }
//        }
//        return true
//    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().purchase(player: self.player!, remaining: 13)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            print("reclaim...")
            //StoryboardSelector().profile(player: self.player!)
        case 1:
            StoryboardSelector().scanner(player: self.player!)
            return
        case 2:
            print("linq...")
            //StoryboardSelector().scanner(player: self.player!)
            return
        default:
            return
        }
    }
    
 
    
}

