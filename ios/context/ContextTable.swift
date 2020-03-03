//
//  ContextTable.swift
//  ios
//
//  Created by Matthew on 3/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class ContextTable: UITableViewController {
    
    let options = ["menu", "config", "fairy", "challenge", "quick play", "recent", "profile"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
        
        tableView.rowHeight = UITableView.automaticDimension
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
            return UIImage(named: "game.grey")
        case 1:
            return UIImage(named: "setup.grey")
        case 2:
            return UIImage(named: "fg")
        case 3:
            return UIImage(named: "challenge_g")
        case 4:
            return UIImage(named: "quick.grey")
        case 5:
            return UIImage(named: "out_g")
        case 6:
            return UIImage(named: "eye_g")
        default:
            return UIImage(named: "sk")
        }
    }
    
    func generateText(value: Int) -> NSMutableAttributedString {
        let attributeTitle = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)]
        let attributeContent = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)]
        let attributedString = NSMutableAttributedString(string: "")
        
        switch value {
        case 0:
            //return UIImage(named: "game.grey")
            let title = NSAttributedString(string: "menu", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " contains your pending invitations, ongoing games, and historic endgame snapshots. when you have an unseen invitation, or your opponent makes a new move this menu icon will be colored ", attributes: attributeContent)
            attributedString.append(content)
            
            let attributeMagenta = [NSAttributedString.Key.foregroundColor: UIColor.magenta, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)]
            let magenta = NSAttributedString(string: "magenta", attributes: attributeMagenta)
            attributedString.append(magenta)
            
            let attention = NSAttributedString(string: " to draw your attention.", attributes: attributeContent)
            attributedString.append(attention)
            return attributedString
        case 1:
            //return UIImage(named: "setup.grey")
            return attributedString
        case 2:
            //return UIImage(named: "fg")
            return attributedString
        case 3:
            //return UIImage(named: "challenge_g")
            return attributedString
        case 4:
            //return UIImage(named: "quick.grey")
            return attributedString
        case 5:
            //return UIImage(named: "out_g")
            return attributedString
        case 6:
            //return UIImage(named: "eye_g")
            return attributedString
        default:
            //return UIImage(named: "sk")
            return attributedString
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContextCell", for: indexPath) as! ContextCell
        cell.textViewContent.attributedText = self.generateText(value: indexPath.row)
        cell.textViewContent.textContainer.lineBreakMode = .byCharWrapping
        cell.textViewContent.sizeToFit()
        
        cell.constraintTextViewHeight.constant = cell.textViewContent.contentSize.height
        
        cell.imageViewIcon.image = self.generateIcon(value: indexPath.row)
        
        //cell.
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

