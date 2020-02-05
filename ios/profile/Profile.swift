//
//  Profile.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Profile: UIViewController, UITabBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
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
        self.usernameLabel.text = self.player!.getUsername()
        
        self.eloLabel.text = self.player!.getElo()
        self.displacementLabel.text = String(abs(Int(self.player!.getDisp())!))
        
        let disp: Int = Int(self.player!.getDisp())!
        
        if(disp >= 0){
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.up")!
                self.displacementImage.image = image
                self.displacementImage.tintColor = .green
            }
        }
        else {
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.down")!
                self.displacementImage.image = image
                self.displacementImage.tintColor = .red
            }
        }
        
        
        ///
        self.activityIndicator.isHidden = true
        ///
        
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
