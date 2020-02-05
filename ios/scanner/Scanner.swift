//
//  Scanner.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import AVFoundation

class Scanner: UIViewController, UITabBarDelegate, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    @IBOutlet weak var displacementImage: UIImageView!
    @IBOutlet weak var displacementLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var player: EntityPlayer?
    
    public func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    public func renderHeader() {
        self.avatarImageView.image = self.player!.getImageAvatar()
        self.usernameLabel.text = self.player!.username
        self.eloLabel.text = self.player!.getLabelTextElo()
        self.rankLabel.text = self.player!.getLabelTextRank()
        self.displacementLabel.text = self.player!.getLabelTextDisp()
        self.displacementImage.image = self.player!.getImageDisp()!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.renderHeader()
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
        
        self.activityIndicator.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarMenu.delegate = self
        
        containerView.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = containerView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        containerView.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        let homeStoryboard: UIStoryboard = UIStoryboard(name: "Eth", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Eth") as! Eth
        homeViewController.setPlayer(player: self.player!)
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        let homeStoryboard: UIStoryboard = UIStoryboard(name: "Eth", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Eth") as! Eth
        homeViewController.setPlayer(player: self.player!)
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }
    
    func found(code: String) {
        //self.player!.setAddress(address: code)
        print(code)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
            //           case 0:
            //               StoryboardSelector().profile(player: self.player!)
            //           case 1:
        //               StoryboardSelector().eth(player: self.player!)
        default:
            let homeStoryboard: UIStoryboard = UIStoryboard(name: "Eth", bundle: nil)
            let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Eth") as! Eth
            homeViewController.setPlayer(player: self.player!)
            UIApplication.shared.keyWindow?.rootViewController = homeViewController
        }
    }
    
}
