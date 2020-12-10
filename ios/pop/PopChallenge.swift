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
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = transDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        
        self.pickerView.isHidden = true
        
        self.indicatorActivity.isHidden = false
        self.indicatorActivity.startAnimating()
        
        self.buttonOk.isHidden = false
        self.buttonOk.isEnabled = true
        
        self.buttonChallenge.isHidden = true
        self.buttonChallenge.isEnabled = false
        
        self.buttonCancel.isHidden = true
        self.buttonCancel.isEnabled = false
        
        self.labelOk.isHidden = false
        
        //self.labelTitle.text = "✅ Success ✅"
        self.labelChallenge.isHidden = true
        
        self.labelCancel.isHidden = true
        
        self.labelDirection.isHidden = true

    }
    

    @IBAction func selectCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func selectOk(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
