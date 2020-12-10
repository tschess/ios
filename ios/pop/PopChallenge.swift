//
//  PopChallenge.swift
//  ios
//
//  Created by S. Matthew English on 12/9/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class PopChallenge: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var labelOk: UILabel!
    @IBOutlet weak var buttonOk: UIButton!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelChallenge: UILabel!
    
    @IBOutlet weak var labelCancel: UILabel!
    @IBOutlet weak var labelDirection: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var buttonChallenge: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    
    var transitioner: Transitioner?
    private let transDelegate: TransDelegate = TransDelegate(width: 271, height: 301)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
        
        
    }
    
    var player: EntityPlayer?
    var opponent: EntityPlayer?
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = transDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelTitle.text = "🤜 vs. \(self.opponent!.username) 🤛"
        
        self.pickerView!.delegate = self
        self.pickerView!.dataSource = self
        self.pickerView!.selectRow(1, inComponent: 0, animated: true)
        
        self.labelOk!.isHidden = true
        self.buttonOk.isHidden = true
        self.buttonOk.isEnabled = false
        
        self.indicatorActivity.isHidden = true
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerSet.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerSet[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    let pickerSet = ["\tChess", "\tI'm Feelin' Lucky", "\tConfig. 0̸", "\tConfig. 1", "\tConfig. 2"]
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        label.text = pickerSet[row]
        return label
    }
    
    
    @IBAction func selectChallenge(_ sender: Any) {
        
        self.labelTitle.isHidden = true
        
        self.labelDirection.isHidden = true
        
        self.pickerView.isHidden = true
        
        self.labelChallenge.isHidden = true
        self.buttonChallenge.isHidden = true
        self.buttonChallenge.isEnabled = false
        
        self.labelCancel.isHidden = true
        self.buttonCancel.isHidden = true
        self.buttonCancel.isEnabled = false
        
        
        self.indicatorActivity.isHidden = false
        self.indicatorActivity.startAnimating()
        
        
        
        
        
        let value = self.pickerView?.selectedRow(inComponent: 0)
        
        self.challenge(config: value!, id_other: opponent!.id)
        
        
        
        
        
        
        
        
        
    }
    
    
    @IBAction func selectCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectOk(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func challenge(config: Int, id_other: String) {
        print("\n\nYAYAYAYA: \(config) <-- config")
        print("\n\nYAYAYAYA: \(id_other) <-- id_other \n\n")
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/challenge")!
        
        let payload: [String: Any] = [
            "id_self": self.player!.id,
            "id_other": id_other,
            "config": config
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
        } catch let error {
            
            print("0")
            
            print(error.localizedDescription)
        }
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                
                print("1")
                
                self.error()
                return
            }
            guard let data = data else {
                
                print("2")
                
                self.error()
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    
                    print("3")
                    
                    self.error()
                    return
                }
                
                DispatchQueue.main.async() {
                    self.indicatorActivity.isHidden = true
                    self.indicatorActivity.stopAnimating()
                    
                    self.labelTitle.isHidden = false
                    self.labelTitle.text = "✅ Success ✅"
                    
                    self.labelDirection.isHidden = false
                    self.labelDirection.text = "Invite has been sent. 👍"
                    
                    self.labelOk.isHidden = false
                    self.buttonOk.isHidden = false
                    self.buttonOk.isEnabled = true
                }
                
                print("4")
                
                print(json)
            } catch _ {
                
                print("5")
                
                self.error()
            }
        }).resume()
    }
    
    func error() {
        DispatchQueue.main.async() {
            self.indicatorActivity.isHidden = true
            self.indicatorActivity.stopAnimating()
            
            self.labelTitle.isHidden = false
            self.labelTitle.text = "❌ Error ❌"
            
            self.labelDirection.isHidden = false
            self.labelDirection.text = "Invite has not been sent. 🤖"
            
            self.labelOk.isHidden = false
            self.buttonOk.isHidden = false
            self.buttonOk.isEnabled = true
        }
    }
}
