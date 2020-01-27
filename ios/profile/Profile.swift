//
//  xProfile.swift
//  ios
//
//  Created by Matthew on 11/15/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit
//import PushNotifications

class Profile: UIViewController, UITabBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[.originalImage] as! UIImage
        let imageString = selectedImage.jpegData(compressionQuality: 0.1)!.base64EncodedString()
        
        let updatePhoto = ["id": self.player!.getId(), "avatar": imageString] as [String: Any]
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
        self.player!.setAvatar(avatar: imageString)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func changePhoto() {
        DispatchQueue.main.async() {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.main.async() {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    @IBOutlet weak var backButton: UIButton!
    

    
    
    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var player: Player?
    
    func setPlayer(player: Player){
        self.player = player
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarMenu.delegate = self
        
        let dataDecoded: Data = Data(base64Encoded: self.player!.getAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.avatarImageView.image = decodedimage
        
        self.rankLabel.text = self.player!.getRank()
        //self.tschxLabel.text = "₮\(self.player!.getTschx())"
        self.usernameLabel.text = self.player!.getUsername()
        
        self.activityIndicator.isHidden = true
        
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.onDidReceiveData(_:)),
        name: NSNotification.Name(rawValue: "OptionMenuSelection"),
        object: nil)
    }
    
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let menuSelectionIndex = notification.userInfo!["option_menu_selection"] as! Int
        
        switch menuSelectionIndex {
        case 0:
            self.changePhoto()
        default:
            self.signOut()
        }
    }
    
    func signOut() {
        //remove device from user profile on server...
        let device = UIDevice.current.identifierForVendor!.uuidString
        ClearDevice().execute(device: device) { (result) in
            //print("result: \(String(describing: result))")
            //try? PushNotifications.shared.clearDeviceInterests()
            //exit(0)
            StoryboardSelector().start()
        }
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        StoryboardSelector().home(player: self.player!)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        default:
            StoryboardSelector().home(player: self.player!)
        }
    }
    
}
