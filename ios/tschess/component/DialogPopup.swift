//
//  DialogPopup.swift
//  ios
//
//  Created by S. Matthew English on 8/25/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class DialogPopup: UIViewController {
    
    var playerSelf: EntityPlayer?
    
    @IBOutlet weak var buttonAccept: UIButton!
    
    
    private var transitionStart = TransInvalid()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = transitionStart
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonClickAccept(_ sender: Any) {
        DispatchQueue.main.async {
            
            self.presentingViewController!.dismiss(animated: false, completion: nil)
            self.notification()
        }
    }
    
    func notification() {
        print("- NOTIFICATION -")
        //DispatchQueue.main.async() {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.id = self.playerSelf!.id
            
            
            _ = UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                switch settings.authorizationStatus {
                case .notDetermined:
                    UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) {
                        
                        (granted, error) in
                        //print("- granted: \(granted)")
                        //print("- error: \(error)")
                        
                        if error == nil{
                            DispatchQueue.main.async(execute: {
                                UIApplication.shared.registerForRemoteNotifications()
                            })
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                        let storyboard: UIStoryboard = UIStoryboard(name: "Note", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "Note") as! CompNote
                        self.present(viewController, animated: true, completion: nil)
                        
                        
                    }
                }
            }
            
            
            
            
        //}
        
    }
    
}
