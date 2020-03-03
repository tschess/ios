//
//  ProfileTable.swift
//  ios
//
//  Created by Matthew on 2/5/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class ProfileTable: UITableViewController {
    
    let options = ["update photo", "game skins", "information", "logout"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func generateIcon(value: Int) -> UIImage? {
        switch value {
        case 0:
            return UIImage(named: "photo_g")
        case 1:
            return UIImage(named: "skins.grey")
        case 2:
            return UIImage(named: "q_g")
        default:
            return UIImage(named: "logout.grey")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.optionLabel.text = options[indexPath.row]
        cell.optionImageView.image = self.generateIcon(value: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let optionSelectionDictionary = ["profile_selection": indexPath.row]
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "ProfileMenuSelection"),
            object: nil,
            userInfo: optionSelectionDictionary)
    }
    
}
