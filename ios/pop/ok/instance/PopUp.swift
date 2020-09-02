//
//  DialogPopup.swift
//  ios
//
//  Created by S. Matthew English on 8/25/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PopUp: UIViewController {
    
    private let transDelegate: TransDelegate = TransDelegate(width: 242, height: 158)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    func configure() {
        self.modalPresentationStyle = .custom
        self.modalTransitionStyle = .crossDissolve
        self.transitioningDelegate = self.transDelegate
    }
    
    var playerSelf: EntityPlayer?
    
    @IBOutlet weak var buttonAccept: UIButton!
    
    @IBAction func buttonClickAccept(_ sender: Any) {
        DispatchQueue.main.async {
            self.presentingViewController!.dismiss(animated: false, completion: nil)
            self.notification()
        }
    }
    
    func notification() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.id = self.playerSelf!.id
        _ = UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) {
                    (granted, error) in
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
    }
    
}
