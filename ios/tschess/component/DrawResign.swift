//
//  DrawResign.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class DrawResign: UIViewController  {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var surrenderButton: UIButton!
    @IBOutlet weak var proposeDrawButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    private var customTransitioningDelegate = TransitioningDelegate()
    
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
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = customTransitioningDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.isHidden = true
        
        if(!self.gameTschess!.getTurn(username: self.playerSelf!.username)){
            proposeDrawButton.alpha = 0.5
            proposeDrawButton.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func surrenderButtonClick(_ sender: Any) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        let requestPayload = [
            "id_game": self.gameTschess!.id,
            "id_self": self.playerSelf!.id,
            "id_oppo": self.playerOther!.id,
            "white": self.gameTschess!.getWhite(username: self.playerSelf!.username)] as [String: Any]
        
        UpdateResign().execute(requestPayload: requestPayload) { (result) in
            print("result: \(result)")
            
            DispatchQueue.main.async {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
                self.presentingViewController!.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func proposeDrawButtonClick(_ sender: Any) {
        
        let requestPayload = [
            "id_game": self.gameTschess!.id,
            "id_self": self.playerSelf!.id,
            "id_other": self.playerOther!.id,
            "white": self.gameTschess!.getWhite(username: self.playerSelf!.username)] as [String: Any]
        
        UpdateProp().execute(requestPayload: requestPayload) { (result) in
            print("result: \(result)")
            
            DispatchQueue.main.async {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
                self.presentingViewController!.dismiss(animated: false, completion: nil)
            }
        }
        
        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: false, completion: nil)
    }
    
}
