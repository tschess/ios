//
//  OtherMenuTable.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class OtherTable: UITableViewController, SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let username: String = self.player!.username
        if(orientation == .right) {
            let rematch = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                let cell = self.tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                
                cell.hideSwipe(animated: false, completion: nil)
                
                let game: EntityGame = self.list[indexPath.row]
                
                DispatchQueue.main.async {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Snapshot", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Snapshot") as! Snapshot
                    viewController.game = game
                    viewController.player = self.player!
                    self.present(viewController, animated: false, completion: nil)
                }
            }
            rematch.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
            rematch.title = "Snapshot"
            let game: EntityGame = self.list[indexPath.row]
            if(game.condition == "DRAW"){
                rematch.textColor = .yellow
                rematch.image = UIImage(named: "challenge_yel")!
                return [rematch]
            }
            if(game.getWinner(username: username)){
                rematch.textColor = .green
                rematch.image = UIImage(named: "challenge_grn")!
                return [rematch]
            }
            rematch.textColor = .red
            rematch.image = UIImage(named: "challenge_red")!
            return [rematch]
        }
        return nil
    }
    
        
    var player: EntityPlayer?
    
    //func setPlayer(player: EntityPlayer){
        //self.player = player
    //}
    
    var activityIndicator: UIActivityIndicatorView?
    
    public func setActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        self.activityIndicator = activityIndicator
    }
    
    //let DATE_TIME: DateTime = DateTime()
    
    var list: [EntityGame] = [EntityGame]()
    
    var label: UILabel?
    
    public var pageCount: Int
    
    required init?(coder aDecoder: NSCoder) {
        self.pageCount = 0
        super.init(coder: aDecoder)
    }
    
    func getGameMenuTableList() -> [EntityGame] {
        return list
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherCell", for: indexPath) as! OtherCell
        //cell.terminalDateLabel.text = game.getLabelTextDate()
        cell.usernameLabel.text = game.getLabelTextUsernameOpponent(username: self.player!.username)
        cell.avatarImageView.image = game.getImageAvatarOpponent(username: self.player!.username)
        cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.size.width/2
        cell.avatarImageView.clipsToBounds = true
        
        cell.set(game: game, username: self.player!.username)
        
        cell.delegate = self
        
        //cell.oddsLabel.text = game.getOdds(username: self.player!.username)
        //cell.displacementImage.image = game.getImageDisp(username: self.player!.username)
        //cell.displacementImage.tintColor = game.getTint(username: self.player!.username)
        
        //let disp: String = game.getLabelTextDisp(username: self.player!.username)!
        //cell.displacementLabel.text = disp
        //if(disp == "0"){
            //cell.displacementImage.isHidden = true
            //cell.displacementLabel.isHidden = true
            //cell.dispImageView.isHidden = true
            //cell.dispLabelAdjacent.isHidden = true
        //}
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let discoverSelectionDictionary = ["other_menu_selection": indexPath.row]
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "OtherMenuTable"),
            object: nil,
            userInfo: discoverSelectionDictionary)
    }
    
     override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           let visibleRows = self.tableView.indexPathsForVisibleRows
           let lastRow = visibleRows?.last?.row
           if(lastRow == nil){
               return
           }
           let REQUEST_PAGE_SIZE: Int = 9
           
           let index = self.pageCount
           let size = REQUEST_PAGE_SIZE
           let indexFrom: Int =  index * size
           let indexTo: Int = indexFrom + REQUEST_PAGE_SIZE - 2
           
           if(lastRow! <= indexTo){
               return
           }
           if lastRow == indexTo {
               self.pageCount += 1
               self.fetchMenuTableList()
           }
       }
    
    func fetchMenuTableList() {

        //DispatchQueue.main.async() {
            //self.activityIndicator!.isHidden = false
            //self.activityIndicator!.startAnimating()
        //}
        
        let requestPayload = [
            "id": self.player!.id,
            "index": self.pageCount,
            "size": Const().PAGE_SIZE,
            "self": false
            ] as [String: Any]
        RequestActual().execute(requestPayload: requestPayload) { (result) in
            //DispatchQueue.main.async() {
                //self.activityIndicator!.stopAnimating()
                //self.activityIndicator!.isHidden = true
            //}
            self.appendToLeaderboardTableList(additionalCellList: result)
        }
    }
    
    func appendToLeaderboardTableList(additionalCellList: [EntityGame]) {
        let currentCount = self.list.count
        
        for game in additionalCellList {
            if(!self.list.contains(game)){
                self.list.append(game)
            }
        }
        if(currentCount != self.list.count){
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }
    }
    
}
