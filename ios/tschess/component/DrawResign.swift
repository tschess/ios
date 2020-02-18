//
//  DrawResign.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class DrawResign: UIViewController  {
    
    @IBOutlet weak var imageDismiss: UIImageView!
    
    @IBOutlet weak var imageResign: UIImageView!
    @IBOutlet weak var buttonResign: UIButton!
    @IBOutlet weak var activityIndicatorResign: UIActivityIndicatorView!
    
    @IBOutlet weak var buttonDraw: UIButton!
    @IBOutlet weak var imageDraw: UIImageView!
    @IBOutlet weak var activityIndicatorDraw: UIActivityIndicatorView!
    
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
        self.activityIndicatorResign!.isHidden = true
        self.activityIndicatorDraw!.isHidden = true
        if(!self.gameTschess!.getTurn(username: self.playerSelf!.username)){
            buttonDraw.titleLabel!.alpha = 0.5
            buttonDraw.isUserInteractionEnabled = false
            imageDraw.alpha = 0.5
        }
        let dismiss = UITapGestureRecognizer(target: self, action: #selector(self.dismiss(gesture:)))
        self.imageDismiss.addGestureRecognizer(dismiss)
        self.imageDismiss.isUserInteractionEnabled = true
    }
    
    @objc func dismiss(gesture: UIGestureRecognizer) {
        DispatchQueue.main.async {
           self.presentingViewController!.dismiss(animated: false, completion: nil)
        }
    }
   
    @IBAction func buttonClickResign(_ sender: Any) {
        self.activityIndicatorResign.isHidden = false
        self.activityIndicatorResign.startAnimating()
        
        self.buttonResign.isHidden = true
        self.imageResign.isHidden = true
        
        let requestPayload = [
            "id_game": self.gameTschess!.id,
            "id_self": self.playerSelf!.id,
            "id_oppo": self.playerOther!.id,
            "white": self.gameTschess!.getWhite(username: self.playerSelf!.username)] as [String: Any]
        
        UpdateResign().execute(requestPayload: requestPayload) { (result) in
            print("result: \(result)")
            DispatchQueue.main.async {
                self.activityIndicatorResign!.stopAnimating()
                self.activityIndicatorResign!.isHidden = true
                self.presentingViewController!.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func buttonClickDraw(_ sender: Any) {
        self.activityIndicatorDraw.isHidden = false
        self.activityIndicatorDraw.startAnimating()
        
        self.buttonDraw.isHidden = true
        self.imageDraw.isHidden = true
        
        UpdateProp().execute(id: self.gameTschess!.id) { (result) in
            print("result: \(result)")
            DispatchQueue.main.async {
                self.activityIndicatorDraw.isHidden = true
                self.activityIndicatorDraw.stopAnimating()
                self.presentingViewController!.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    
}
