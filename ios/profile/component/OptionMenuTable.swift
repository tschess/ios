//
//  OptionMenuTable.swift
//  ios
//
//  Created by Matthew on 11/15/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class OptionMenuTable: UITableViewController {
    
    let options = ["fairy pieces", "game skins", "eth address", "sign out"]
    
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
            return UIImage(named: "fairy")
        case 1:
            return UIImage(named: "mask")
        case 2:
            return UIImage(named: "eth")
        default:
            return UIImage(named: "exit")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! OptionCell
        cell.optionLabel.text = options[indexPath.row]
        cell.optionImageView.image = self.generateIcon(value: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let optionSelectionDictionary = ["option_menu_selection": indexPath.row]
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "OptionMenuSelection"),
            object: nil,
            userInfo: optionSelectionDictionary)
    }
    
}

