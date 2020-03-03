//
//  ContextTable.swift
//  ios
//
//  Created by Matthew on 3/2/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class ContextTable: UITableViewController {
    
    let options = [
        "menu",
        "config",
        "fairy",
        "challenge",
        "quick play",
        "outbound",
        "rescind",
        "inbound",
        "turn on",
        "turn off",
        "accept",
        "reject",
        "recent",
        "up",
        "down",
        "profile"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
        //tableView.rowHeight = UITableView.automaticDimension
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
            return UIImage(named: "close_g") //rescind
        case 7:
            return UIImage(named: "inb_g") //inib
        case 8:
            return UIImage(named: "turn_on_g") //turn on
        case 9:
            return UIImage(named: "turn_off_g") //turn off
        case 10:
            return UIImage(named: "tu_g") //accept
        case 11:
            return UIImage(named: "td_g") //reject
        case 12://recent
            return UIImage(named: "eye_g")
        case 13:
            return UIImage(named: "dwn_g") //down arrow
            //return attributedString
        case 14:
            return UIImage(named: "up_g") //up arrow
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
            let title = NSAttributedString(string: "config", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " create your opening position, organizing pieces on the back two ranks however you see fit. with the caveat that the total points on the board is less than or equal to 39 - equivalent to that of the standard opening configuration in world federation chess.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 2:
            //return UIImage(named: "fg") fairy
            let title = NSAttributedString(string: "fairy", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " unorthodox chess piece not used in conventional chess.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 3:
            //return UIImage(named: "challenge_g")
            let title = NSAttributedString(string: "challenge", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " invite an opponent to a new game. you select your configuration, they can accept your invitation and intiate a new game with their own opening configuration.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 4:
            //return UIImage(named: "quick.grey")
            let title = NSAttributedString(string: "quick play", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " randomly select oone player from the leaderboard with whom to initiate a new game, you play white with an opening configuration of your choice, they play black with the standard configuration.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 5:
            //return UIImage(named: "out_g")
            let title = NSAttributedString(string: "outbound", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " represents a challenge that you've issued to an opponent. the reciever of the invite plays as white.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 6:
            //return UIImage(named: "eye_g") //rescind
            let title = NSAttributedString(string: "rescind", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " cancel an outbound invitation.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 7:
            //return UIImage(named: "eye_g") //inib
            let title = NSAttributedString(string: "inbound", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " an invitation issued to you by an opponent. you play as white.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 8:
            //return UIImage(named: "eye_g") //turn on
            let title = NSAttributedString(string: "turn on", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " of an ongoing game, your move.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 9:
            //return UIImage(named: "eye_g") //turn off
            let title = NSAttributedString(string: "turn off", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " of an ongoing game, your opponent's move.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 10:
            //return UIImage(named: "eye_g") //accept
            let title = NSAttributedString(string: "accept", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " of an inbound invite, game on.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 11:
            //return UIImage(named: "eye_g") //reject
            let title = NSAttributedString(string: "reject", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " refuse an inbound invite.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 12:
            //return UIImage(named: "eye_g") //recent
            let title = NSAttributedString(string: "recent", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " view endgame snapshot of last played game.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 13:
            //return UIImage(named: "eye_g") //down arrow
            let title = NSAttributedString(string: "down", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " elo-based leaderboard rank has been readjusted down by the corresponding ammount.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        case 14:
            //return UIImage(named: "eye_g") //up arrow
            let title = NSAttributedString(string: "up", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " elo-based leaderboard rank has been readjusted up by the corresponding ammount.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        default:
            //return UIImage(named: "sk")
            let title = NSAttributedString(string: "profile", attributes: attributeTitle)
            attributedString.append(title)
            let content = NSAttributedString(string: " voilà.", attributes: attributeContent)
            attributedString.append(content)
            return attributedString
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContextCell", for: indexPath) as! ContextCell
        cell.imageViewIcon.image = self.generateIcon(value: indexPath.row)
        
        cell.textViewContent.textContainer.lineBreakMode = .byCharWrapping
        cell.textViewContent.attributedText = self.generateText(value: indexPath.row)
        cell.textViewContent.sizeToFit()
        cell.constraintTextViewHeight.constant = cell.textViewContent.contentSize.height
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

