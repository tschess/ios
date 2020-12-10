//
//  Leaderboard.swift
//  ios
//
//  Created by S. Matthew English on 12/3/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class Leaderboard: UIViewController, UITabBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //var table: HomeTable?
    
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
    
    let pickerSet = ["chess", "i'm feelin' lucky", "config. 0̸", "config. 1", "config. 2"]
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        label.text = pickerSet[row]
        return label
    }
    
    var menu: Home?
    var homeMenuTable: LeaderboardTable?
    
    //MARK: Header
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    var playerSelf: EntityPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Header
        let viewHeaderDynamic = Bundle.loadView(fromNib: "Header", withType: Header.self)
        self.headerView.addSubview(viewHeaderDynamic)
        viewHeaderDynamic.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: viewHeaderDynamic, attribute: $0, relatedBy: .equal, toItem: viewHeaderDynamic.superview, attribute: $0, multiplier: 1, constant: 0)
        })
        viewHeaderDynamic.set(player: self.playerSelf!)
       
        self.tabBarMenu.delegate = self
        self.homeMenuTable = children.first as? LeaderboardTable
        self.homeMenuTable!.home = self
        self.homeMenuTable!.fetchGameList()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onDidReceiveData(_:)),
            name: NSNotification.Name(rawValue: "LeaderboardSelection"),
            object: nil)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        _ = self.navigationController?.popViewController(animated: false)
        self.navigationController?.popViewController(animated: false)
    }
    
    
    var pickerView: UIPickerView?
    
    
    // TODO: IF SELF GO TO GAMES!!!!
    @objc func onDidReceiveData(_ notification: NSNotification) {
        let menuSelectionIndex = notification.userInfo!["leaderboard_selection"] as! Int
        
        let opponent: EntityPlayer = self.homeMenuTable!.getOther(index: menuSelectionIndex)
        DispatchQueue.main.async {
            //let storyboard: UIStoryboard = UIStoryboard(name: "Other", bundle: nil)
            //let viewController = storyboard.instantiateViewController(withIdentifier: "Other") as! Other
            //viewController.playerSelf = self.playerSelf!
            //viewController.playerOther = playerOther
            //self.navigationController?.pushViewController(viewController, animated: false)
//            let viewController = UIViewController()
//            viewController.preferredContentSize = CGSize(width: 250, height: 108) //108
//            self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
//            self.pickerView!.delegate = self
//            self.pickerView!.dataSource = self
//            self.pickerView!.backgroundColor = .black
//
//            self.pickerView!.layer.cornerRadius = 10
//            self.pickerView!.layer.masksToBounds = true
//
//            self.pickerView!.selectRow(1, inComponent: 0, animated: true)
//
//            viewController.view.addSubview(self.pickerView!)
//            let alert = UIAlertController(title: "🤜 \(opponent.username) 🤛", message: "", preferredStyle: UIAlertController.Style.alert)
//
//            alert.setValue(viewController, forKey: "contentViewController")
//
//            let option00 = UIAlertAction(title: "⚡ issue challenge ⚡", style: .default, handler:{ _ in
//                let value = self.pickerView?.selectedRow(inComponent: 0)
//
//                self.challenge(config: value!, id_other: opponent.id)
//            })
//            alert.addAction(option00)
//
//            let option01 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            option01.setValue(UIColor.lightGray, forKey: "titleTextColor")
//            alert.addAction(option01)
            
            //self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            //self.present(alert, animated: true)
            
            let storyboard: UIStoryboard = UIStoryboard(name: "PopInvite", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PopInvite") as! PopInvite
                
            viewController.player = self.playerSelf
            viewController.opponent = opponent

            //self.window?.rootViewController?.present(viewController, animated: true, completion: nil)
            self.present(viewController, animated: true)
            
        }
    }
    
    func challenge(config: Int, id_other: String) {
        print("\n\nYAYAYAYA: \(config) <-- config")
        print("\n\nYAYAYAYA: \(id_other) <-- id_other \n\n")
        
        let url = URL(string: "http://\(ServerAddress().IP):8080/game/challenge")!
        
        let payload: [String: Any] = [
            "id_self": self.playerSelf!.id,
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
            print(error.localizedDescription)
        }
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                //completion([["fail": "0"]])
                return
            }
            guard let data = data else {
                //completion([["fail": "1"]])
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] else {
                    //completion([["fail": "2"]])
                    return
                }
                //completion(json)
                
                //DispatchQueue.main.async {
                    //self.table!.tableView.reloadData()
                //}
                
            } catch _ {
                //completion([["fail": "3"]])
            }
        }).resume()
    }
    
    func setIndicator(on: Bool) {
//        if(on) {
//            DispatchQueue.main.async() {
//                if(self.activityIndicator!.isHidden){
//                    self.activityIndicator!.isHidden = false
//                }
//                if(!self.activityIndicator!.isAnimating){
//                    self.activityIndicator!.startAnimating()
//                }
//            }
//            return
//        }
//        DispatchQueue.main.async() {
//            self.activityIndicator!.isHidden = true
//            self.activityIndicator!.stopAnimating()
//            self.homeMenuTable!.tableView.reloadData()
//        }
    }
}
