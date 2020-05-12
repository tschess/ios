//
//  Evaluate.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Evaluate: UIViewController  {
    
    @IBOutlet weak var imageAccept: UIImageView!
    @IBOutlet weak var buttonAccept: UIButton!
    @IBOutlet weak var activityIndicatorAccept: UIActivityIndicatorView!
    
    @IBOutlet weak var buttonReject: UIButton!
    @IBOutlet weak var imageReject: UIImageView!
    @IBOutlet weak var activityIndicatorReject: UIActivityIndicatorView!
    
    private var customTransitioningDelegate = TransDraw()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configure()
    }
    
    var gameTschess: EntityGame?
    
    public func setGameTschess(gameTschess: EntityGame) {
        self.gameTschess = gameTschess
    }
    
    var playerOther: EntityPlayer?
    
    func setPlayerOther(playerOther: EntityPlayer){
        self.playerOther = playerOther
    }
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    @objc func ack(gesture: UIGestureRecognizer) {
           self.buttonClickResign("~")
       }
    
    @objc func nack(gesture: UIGestureRecognizer) {
        self.buttonClickReject("~")
    }
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = customTransitioningDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorAccept!.isHidden = true
        self.activityIndicatorReject!.isHidden = true
        
        let ack = UITapGestureRecognizer(target: self, action: #selector(self.ack))
        self.imageAccept.addGestureRecognizer(ack)
        self.imageAccept.isUserInteractionEnabled = true
        
        let nack = UITapGestureRecognizer(target: self, action: #selector(self.nack))
        self.imageReject.addGestureRecognizer(nack)
        self.imageReject.isUserInteractionEnabled = true
    }
    
    @objc func dismiss(gesture: UIGestureRecognizer) {
        DispatchQueue.main.async {
            self.presentingViewController!.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func buttonClickResign(_ sender: Any) {
        self.activityIndicatorAccept.isHidden = false
        self.activityIndicatorAccept.startAnimating()
        
        self.buttonAccept.isHidden = true
        self.imageAccept.isHidden = true
        
        let requestPayload = [
            "id_game": self.gameTschess!.id,
            "id_self": self.playerSelf!.id,
            "accept": true] as [String: Any]
        
        UpdateEval().execute(requestPayload: requestPayload) { (result) in
            
            DispatchQueue.main.async {
                self.activityIndicatorAccept!.stopAnimating()
                self.activityIndicatorAccept!.isHidden = true
                self.presentingViewController!.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func buttonClickReject(_ sender: Any) {
        self.activityIndicatorReject.isHidden = false
        self.activityIndicatorReject.startAnimating()
        
        self.buttonReject.isHidden = true
        self.imageReject.isHidden = true
        
        let requestPayload = [
        "id_game": self.gameTschess!.id,
        "id_self": self.playerSelf!.id,
        "accept": false] as [String: Any]
        
        UpdateEval().execute(requestPayload: requestPayload) { (result) in
            DispatchQueue.main.async {
                self.activityIndicatorReject!.stopAnimating()
                self.activityIndicatorReject!.isHidden = true
                self.presentingViewController!.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    
}
