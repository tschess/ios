//
//  Profile.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Profile: UIViewController, UITabBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    
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
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            }
        }
        let dataDecoded: Data = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        avatarImageView.image = decodedimage
        self.player!.avatar = imageString //now update it...
        
        dismiss(animated: true, completion: nil)
    }
    
    func changePhoto() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: {
            self.activityIndicator.isHidden = true
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.main.async() {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tabBarMenu: UITabBar!

    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    //
    func notification() {
        print("- NOTIFICATION -")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.id = self.player!.id
        
        
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
                    let storyboard: UIStoryboard = UIStoryboard(name: "PopNote", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "PopNote") as! PopDismiss
                    self.present(viewController, animated: true, completion: nil)
                }
            }
        }
        
        
      
        
        
        
    }
    
    public func renderHeader() {
        self.avatarImageView.image = self.player!.getImageAvatar()
        self.usernameLabel.text = self.player!.username
        self.eloLabel.text = self.player!.getLabelTextElo()
        self.rankLabel.text = self.player!.getLabelTextRank()
        self.displacementLabel.text = self.player!.getLabelTextDisp()
        self.displacementImage.image = self.player!.getImageDisp()!
        self.displacementImage.tintColor = self.player!.tintColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = true
        self.tabBarMenu.delegate = self
        self.renderHeader()
        
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
            self.signOut()
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
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.backButtonClick("")
    }
    
}
