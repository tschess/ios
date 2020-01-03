//
//  Chat.swift
//  ios
//
//  Created by Matthew on 12/10/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

//limit text 255
class Talk: UIViewController, UITabBarDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var opponentAvatarImageView: UIImageView?
    @IBOutlet weak var opponentUsernameLabel: UILabel?
    @IBOutlet weak var opponentRankLabel: UILabel?
    
    let dateTime: DateTime = DateTime()
    
    var dismissKeyboardGesture: UITapGestureRecognizer?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var myLastMessageTextView: UITextView!
    @IBOutlet weak var envelopeImageViewSelf: UIImageView!
    
    @IBOutlet weak var envelopeImageViewOpponent: UIImageView!
    
    @IBOutlet weak var opponentLastMessageTextView: UITextView!
    
    var opponent: PlayerCore?
    var gameModel: Game?
    var player: Player?
    var gamestate: Gamestate?
    
    var inputText: String?
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButtonImageView: UIImageView!
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    @IBOutlet weak var backButton: UIButton!
    
    public func setOpponent(opponent: PlayerCore){
        self.opponent = opponent
    }
    
    public func setGameModel(gameModel: Game){
        self.gameModel = gameModel
    }
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    public func setGamestate(gamestate: Gamestate){
        self.gamestate = gamestate
    }
    
    var deviceType: String?
    
    private func longView() -> Bool {
        return self.deviceType! == "XENOPHON" || self.deviceType! == "PHAEDRUS" || self.deviceType! == "CALHOUN"
    }
    
    override func viewDidLoad() {
        self.tabBarMenu.delegate = self
        
        self.sendButtonImageView.layer.cornerRadius = 4.5
        self.sendButtonImageView.clipsToBounds = true
        
        self.deviceType = StoryboardSelector().device()
        
        if(self.longView()){
            self.opponentUsernameLabel!.text = self.opponent!.getName()
            self.opponentRankLabel!.text = self.opponent!.getRank()
            
            let dataDecoded: Data = Data(base64Encoded: self.opponent!.getAvatar(), options: .ignoreUnknownCharacters)!
            let decodedImage = UIImage(data: dataDecoded)
            self.opponentAvatarImageView!.image = decodedImage
        }
        
        
        
        let sendMessageRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.sendMessage))
        sendButtonImageView.addGestureRecognizer(sendMessageRecognizer)
        sendButtonImageView.isUserInteractionEnabled = true
        
        self.dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        self.inputTextField.delegate = self
        
        self.inputTextField.text = ""
        
        self.activityIndicator.isHidden = true
        
        self.startPolling()
        
        if(self.gamestate!.getSelfAffiliation() == "WHITE"){
            if(self.gameModel!.getMessageWhite() == "NONE"){
                
                self.envelopeImageViewSelf.image = UIImage(named: "shut")
                
                self.myLastMessageTextView.text = "        \(self.gameModel!.getUsernameWhite()):"
            } else {
                if(!self.gameModel!.getSeenMessageWhite()){
                    self.envelopeImageViewSelf.image = UIImage(named: "shut")
                }
                if(self.gameModel!.getMessageWhitePosted() != "TBD"){
                    let asDate = self.dateTime.toFormatDate(string: self.gameModel!.getMessageWhitePosted())
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    self.myLastMessageTextView.text = "        \(self.gameModel!.getUsernameWhite()) (\(dateFormatter.string(from: asDate))): \(self.gameModel!.getMessageWhite())"
                }}
            if(self.gameModel!.getMessageBlack() == "NONE"){
                self.opponentLastMessageTextView.text = "        \(self.gameModel!.getUsernameBlack()):"
            } else {
                
                PostSeen().execute(idGame: self.gameModel!.getIdentifier(), idPlayer: self.player!.getId()) { (result) in
                    if(!result){
                        //error
                    }
                }
                if(self.gameModel!.getMessageBlackPosted() != "TBD"){
                    let asDate = self.dateTime.toFormatDate(string: self.gameModel!.getMessageBlackPosted())
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    self.opponentLastMessageTextView.text = "        \(self.gameModel!.getUsernameBlack()) (\(dateFormatter.string(from: asDate))): \(self.gameModel!.getMessageBlack())"
                }}
            return
        }
        if(self.gameModel!.getMessageBlack() == "NONE"){
            self.envelopeImageViewSelf.image = UIImage(named: "shut")
            self.myLastMessageTextView.text = "        \(self.gameModel!.getUsernameBlack()):"
        } else {
            if(!self.gameModel!.getSeenMessageBlack()){
                self.envelopeImageViewSelf.image = UIImage(named: "shut")
            }
            if(self.gameModel!.getMessageBlackPosted() != "TBD"){
                let asDate = self.dateTime.toFormatDate(string: self.gameModel!.getMessageBlackPosted())
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                self.myLastMessageTextView.text = "        \(self.gameModel!.getUsernameBlack()) (\(dateFormatter.string(from: asDate))): \(self.gameModel!.getMessageBlack())"
            }}
        if(self.gameModel!.getMessageWhite() == "NONE"){
            self.opponentLastMessageTextView.text = "        \(self.gameModel!.getUsernameWhite()):"
        } else {
            
            PostSeen().execute(idGame: self.gameModel!.getIdentifier(), idPlayer: self.player!.getId()) { (result) in
                if(!result){
                    //error
                }
            }
            if(self.gameModel!.getMessageWhitePosted() != "TBD"){
                let asDate = self.dateTime.toFormatDate(string: self.gameModel!.getMessageWhitePosted())
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                self.opponentLastMessageTextView.text = "        \(self.gameModel!.getUsernameWhite()) (\(dateFormatter.string(from: asDate))): \(self.gameModel!.getMessageWhite())"
            }}
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.addGestureRecognizer(self.dismissKeyboardGesture!)
        self.view.frame.origin.y = -100
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.inputTextField.resignFirstResponder()
        view.removeGestureRecognizer(self.dismissKeyboardGesture!)
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.sendMessage()
        return true
    }
    
    @objc func dismissKeyboard() {
        self.inputTextField.resignFirstResponder()
        view.endEditing(true)
    }
    
    @objc func sendMessage() {
        
        self.myLastMessageTextView.text = ""
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        self.inputText = self.inputTextField.text!
        self.inputTextField.text = ""
        
        self.dismissKeyboard()
        
        let posted = self.dateTime.currentDateString()
        
        let requestPayload = [
            "id_game": self.gameModel!.getIdentifier(),
            "id_player": self.player!.getId(),
            "message": inputText!,
            "posted": posted]
        
        //print("requestPayload: \(requestPayload)")
        
        UpdateMessage().success(requestPayload: requestPayload) { (result) in
            if(result == nil){
                //error
            }
            if(!result!){
                //error
            }
            DispatchQueue.main.async() {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                self.envelopeImageViewSelf.image = UIImage(named: "shut")
                if(self.gamestate!.getSelfAffiliation() == "WHITE"){
                    
                    let asDate = self.dateTime.toFormatDate(string: posted)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    
                    self.gameModel!.setMessageWhite(messageWhite: self.inputText!)
                    self.myLastMessageTextView.text = "        \(self.gameModel!.getUsernameWhite()) (\(dateFormatter.string(from: asDate))): \(self.gameModel!.getMessageWhite())"
                    return
                }
                let asDate = self.dateTime.toFormatDate(string: posted)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                
                self.gameModel!.setMessageWhite(messageWhite: self.inputText!)
                self.myLastMessageTextView.text = "        \(self.gameModel!.getUsernameBlack()) (\(dateFormatter.string(from: asDate))): \(self.gameModel!.getMessageBlack())"
            }
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.stopPolling()
        StoryboardSelector().chess(gameModel: self.gameModel!, player: self.player!, gamestate: self.gamestate!)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            self.stopPolling()
            StoryboardSelector().chess(gameModel: self.gameModel!, player: self.player!, gamestate: self.gamestate!)
        }
    }
    
    var talkPollingTimer: Timer?
    
    func stopPolling() {
        self.talkPollingTimer?.invalidate()
        self.talkPollingTimer = nil
    }
    
    func startPolling() {
        guard talkPollingTimer == nil else {
            return
        }
        self.talkPollingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(talkPollingTask), userInfo: nil, repeats: true)
    }
    
    // MARK: polling task
    
    @objc func talkPollingTask() {
        
        let requestPayload = [
            "id_game": self.gameModel!.getIdentifier(),
            "white_message": self.gameModel!.getMessageWhite(),
            "black_message": self.gameModel!.getMessageBlack()]
        
        RequestMessage().execute(requestPayload: requestPayload, gameModel: self.gameModel!) { (result) in
            if(result == nil){
                return
            }
            self.gameModel = result!
            
            DispatchQueue.main.async() {
                if(self.gamestate!.getSelfAffiliation() == "WHITE"){
                    if(self.gameModel!.getMessageWhite() == "NONE"){
                        if(!self.gameModel!.getSeenMessageWhite()){
                            self.envelopeImageViewSelf.image = UIImage(named: "shut")
                        } else {
                            self.envelopeImageViewSelf.image = UIImage(named: "open")
                        }
                        self.myLastMessageTextView.text = "        \(self.gameModel!.getUsernameWhite()):"
                    } else {
                        if(!self.gameModel!.getSeenMessageWhite()){
                            self.envelopeImageViewSelf.image = UIImage(named: "shut")
                        } else {
                            self.envelopeImageViewSelf.image = UIImage(named: "open")
                        }
                        if(self.gameModel!.getMessageWhitePosted() != "TBD"){
                            let asDate = self.dateTime.toFormatDate(string: self.gameModel!.getMessageWhitePosted())
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "HH:mm"
                            self.myLastMessageTextView.text = "        \(self.gameModel!.getUsernameWhite()) (\(dateFormatter.string(from: asDate))): \(self.gameModel!.getMessageWhite())"
                        }}
                    if(self.gameModel!.getMessageBlack() == "NONE"){
                        
                        PostSeen().execute(idGame: self.gameModel!.getIdentifier(), idPlayer: self.player!.getId()) { (result) in
                            if(!result){
                                //error
                            }
                        }
                        
                        self.opponentLastMessageTextView.text = "        \(self.gameModel!.getUsernameBlack()):"
                    } else {
                        
                        PostSeen().execute(idGame: self.gameModel!.getIdentifier(), idPlayer: self.player!.getId()) { (result) in
                            if(!result){
                                //error
                            }
                        }
                        if(self.gameModel!.getMessageBlackPosted() != "TBD"){
                            let asDate = self.dateTime.toFormatDate(string: self.gameModel!.getMessageBlackPosted())
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "HH:mm"
                            self.opponentLastMessageTextView.text = "        \(self.gameModel!.getUsernameBlack()) (\(dateFormatter.string(from: asDate))): \(self.gameModel!.getMessageBlack())"
                        }}
                    return
                }
                if(self.gameModel!.getMessageBlack() == "NONE"){
                    if(!self.gameModel!.getSeenMessageWhite()){
                        self.envelopeImageViewSelf.image = UIImage(named: "shut")
                    } else {
                        self.envelopeImageViewSelf.image = UIImage(named: "open")
                    }
                    self.myLastMessageTextView.text = "        \(self.gameModel!.getUsernameBlack()):"
                } else {
                    if(!self.gameModel!.getSeenMessageBlack()){
                        self.envelopeImageViewSelf.image = UIImage(named: "shut")
                    } else {
                        self.envelopeImageViewSelf.image = UIImage(named: "open")
                    }
                    if(self.gameModel!.getMessageBlackPosted() != "TBD"){
                        let asDate = self.dateTime.toFormatDate(string: self.gameModel!.getMessageBlackPosted())
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"
                        self.myLastMessageTextView.text = "        \(self.gameModel!.getUsernameBlack()) (\(dateFormatter.string(from: asDate))): \(self.gameModel!.getMessageBlack())"
                    }}
                if(self.gameModel!.getMessageWhite() == "NONE"){
                    
                    PostSeen().execute(idGame: self.gameModel!.getIdentifier(), idPlayer: self.player!.getId()) { (result) in
                        if(!result){
                            //error
                        }
                    }
                    
                    self.opponentLastMessageTextView.text = "        \(self.gameModel!.getUsernameWhite()):"
                } else {
                    
                    PostSeen().execute(idGame: self.gameModel!.getIdentifier(), idPlayer: self.player!.getId()) { (result) in
                        if(!result){
                            //error
                        }
                    }
                    if(self.gameModel!.getMessageWhitePosted() != "TBD"){
                        let asDate = self.dateTime.toFormatDate(string: self.gameModel!.getMessageWhitePosted())
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"
                        self.opponentLastMessageTextView.text = "        \(self.gameModel!.getUsernameWhite()) (\(dateFormatter.string(from: asDate))): \(self.gameModel!.getMessageWhite())"
                    }
                    
                }
            }
        }
    }
}
