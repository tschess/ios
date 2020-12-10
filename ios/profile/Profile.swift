//
//  Profile.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Profile: UIViewController, UITabBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    var header: Header?
    @IBOutlet weak var viewHeader: UIView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let selectedImage = info[.originalImage] as! UIImage
        let imageString = selectedImage.jpegData(compressionQuality: 0.09)!.base64EncodedString()
        
        let updatePhoto = ["id": self.player!.id, "avatar": imageString] as [String: Any]
        
        UpdatePhoto().execute(requestPayload: updatePhoto) { (error) in
            if error != nil {
                print("error: \(error!.localizedDescription)")
            }
            else {
                DispatchQueue.main.async() {
                    self.header!.indicatorActivity!.stopAnimating()
                    self.header!.indicatorActivity.isHidden = true
                }
            }
        }
        let dataDecoded: Data = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.header!.imageAvatar.image = decodedimage
        self.player!.avatar = imageString //now update it...
        
        dismiss(animated: true, completion: nil)
    }
    
    func changePhoto() {
        self.header!.indicatorActivity!.isHidden = false
        self.header!.indicatorActivity!.startAnimating()
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: {
            self.header!.indicatorActivity!.isHidden = true
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.main.async() {
            self.header!.indicatorActivity!.stopAnimating()
            self.header!.indicatorActivity!.isHidden = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    //@IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!

    //@IBOutlet weak var displacementImage: UIImageView!
    //@IBOutlet weak var displacementLabel: UILabel!
    //@IBOutlet weak var eloLabel: UILabel!
    //@IBOutlet weak var rankLabel: UILabel!
    //@IBOutlet weak var usernameLabel: UILabel!
    //@IBOutlet weak var avatarImageView: UIImageView!
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    //
    func notification() {
        print("- NOTIFICATION -")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.id = self.player!.id
        
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
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
                    //let storyboard: UIStoryboard = UIStoryboard(name: "PopNote", bundle: nil)
                    //let viewController = storyboard.instantiateViewController(withIdentifier: "PopNote") as! PopDismiss
                    //self.present(viewController, animated: true, completion: nil)
                    let alert = UIAlertController(title: "🔔 Move notifications 🚦", message: "\nEnable/disable notifications in device settings.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    action.setValue(UIColor.lightGray, forKey: "titleTextColor")
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            }
        }
        
        
      
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.activityIndicator.isHidden = true
        self.tabBarMenu.delegate = self
        //self.renderHeader()
        
        //TODO: Header
        self.header = Bundle.loadView(fromNib: "Header", withType: Header.self)
        self.viewHeader.addSubview(self.header!)
        self.header!.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: self.header!, attribute: $0, relatedBy: .equal, toItem: self.header!.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        self.header!.set(player: self.player!)
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "ProfileMenuSelection"),
            object: nil)
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let menuSelectionIndex = notification.userInfo!["profile_selection"] as! Int
        
        switch menuSelectionIndex {
        case 0://photo
            self.changePhoto()
        case 1://notification
            self.notification()
        default:
            //self.signOut()
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "🚪 Sign out from device? 📲", message: "\nConfirm to clear automatic login credentials from the server.", preferredStyle: .alert)
                let action0 = UIAlertAction(title: "Sign out", style: .destructive, handler: {_ in
                    self.signOut()
                })
                action0.setValue(UIColor.lightGray, forKey: "titleTextColor")
                alert.addAction(action0)
                
                let action1 = UIAlertAction(title: "Back", style: .cancel, handler: nil)
                action1.setValue(UIColor.lightGray, forKey: "titleTextColor")
                alert.addAction(action1)
                
                self.present(alert, animated: true)
            }
        }
    }
    
    func signOut() {
        //remove device from user profile on server...
        let device = UIDevice.current.identifierForVendor!.uuidString
        UpdateDevice().execute(device: device) { (result) in
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Start", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "Start") as! Start
                self.navigationController?.viewControllers = [viewController]
            }
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
