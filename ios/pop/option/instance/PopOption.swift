//
//  DrawResign.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PopOption: UIViewController  {
    
    @IBOutlet weak var imageDismiss: UIImageView!
    @IBOutlet weak var imageResign: UIImageView!
    
    @IBOutlet weak var buttonResign: UIButton!
    @IBOutlet weak var activityIndicatorResign: UIActivityIndicatorView!
    
    @IBOutlet weak var buttonDraw: UIButton!
    @IBOutlet weak var imageDraw: UIImageView!
    @IBOutlet weak var activityIndicatorDraw: UIActivityIndicatorView!
    
    //private var customTransitioningDelegate = TransDraw()
    private let transDelegate: TransDelegate = TransDelegate(width: 242, height: 176)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configure()
    }
    
    var game: EntityGame?
    
    public func setGame(game: EntityGame) {
        self.game = game
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
        transitioningDelegate = transDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorResign!.isHidden = true
        self.activityIndicatorDraw!.isHidden = true
        
        let dismiss = UITapGestureRecognizer(target: self, action: #selector(self.dismiss(gesture:)))
        self.imageDismiss.addGestureRecognizer(dismiss)
        self.imageDismiss.isUserInteractionEnabled = true
        
        if(self.game!.isResolved()){
            self.decativateDraw()
            self.buttonResign.titleLabel!.alpha = 0.5
            self.buttonResign.isUserInteractionEnabled = false
            self.imageResign.alpha = 0.5
            return
        }
        let resign = UITapGestureRecognizer(target: self, action: #selector(self.resign))
        self.imageResign.addGestureRecognizer(resign)
        self.imageResign.isUserInteractionEnabled = true
        
        let username: String = self.playerSelf!.username
        let turn: Bool = self.game!.getTurnFlag(username: username)
        if(!turn){
            self.decativateDraw()
            return
        }
        let draw = UITapGestureRecognizer(target: self, action: #selector(self.draw))
        self.imageDraw.addGestureRecognizer(draw)
        self.imageDraw.isUserInteractionEnabled = true
    }
    
    private func decativateDraw() {
        self.buttonDraw.titleLabel!.alpha = 0.5
        self.buttonDraw.isUserInteractionEnabled = false
        self.imageDraw.alpha = 0.5
    }
    
    @objc func draw(gesture: UIGestureRecognizer) {
        self.buttonClickDraw("~")
    }
    
    @objc func resign(gesture: UIGestureRecognizer) {
        self.buttonClickResign("~")
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
            "id_game": self.game!.id,
            "id_self": self.playerSelf!.id,
            "white": self.game!.getWhite(username: self.playerSelf!.username)] as [String: Any]
        
        UpdateResign().execute(requestPayload: requestPayload) { (result) in
            //print("result: \(result)")
            
           
            DispatchQueue.main.async {
                if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                    let viewControllers = navigationController.viewControllers
                    for vc in viewControllers {
                        if vc.isKind(of: Menu.classForCoder()) {
                            //print("It is in stack")
                            let menu: Menu = vc as! Menu
                            menu.menuTable!.refresh(refreshControl: nil)
                        }
                    }
                    
                }
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
        
        UpdateProp().execute(id: self.game!.id) { (result) in
            DispatchQueue.main.async {
                self.activityIndicatorDraw.isHidden = true
                self.activityIndicatorDraw.stopAnimating()
                self.presentingViewController!.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    
}
