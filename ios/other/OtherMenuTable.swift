//
//  OtherMenuTable.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class OtherMenuTable: UITableViewController {
        
    var player: EntityPlayer?
    
    func setPlayer(player: EntityPlayer){
        self.player = player
    }
    
    var activityIndicator: UIActivityIndicatorView?
    
    public func setActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        self.activityIndicator = activityIndicator
    }
    
    let DATE_TIME: DateTime = DateTime()
    
    var gameMenuTableList: [EntityGame] = [EntityGame]()
    
    var label: UILabel?
    
    public var pageCount: Int
    
    required init?(coder aDecoder: NSCoder) {
        self.pageCount = 0
        super.init(coder: aDecoder)
    }
    
    func getGameMenuTableList() -> [EntityGame] {
        return gameMenuTableList
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameMenuTableList.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = gameMenuTableList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherMenuCell", for: indexPath) as! OtherMenuCell
        //cell.terminalDateLabel.text = game.getLabelTextDate()
        cell.usernameLabel.text = game.getLabelTextUsernameOpponent(username: self.player!.username)
        cell.avatarImageView.image = game.getImageAvatarOpponent(username: self.player!.username)
        
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

        DispatchQueue.main.async() {
            self.activityIndicator!.isHidden = false
            self.activityIndicator!.startAnimating()
            
        }
        
        let requestPayload = [
            "id": self.player!.id,
            "index": self.pageCount,
            "size": Const().PAGE_SIZE,
            "self": false
            ] as [String: Any]
        RequestActual().execute(requestPayload: requestPayload) { (result) in
            DispatchQueue.main.async() {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
            }
            self.appendToLeaderboardTableList(additionalCellList: result)
        }
    }
    
    func appendToLeaderboardTableList(additionalCellList: [EntityGame]) {
        let currentCount = self.gameMenuTableList.count
        
        for game in additionalCellList {
            if(!self.gameMenuTableList.contains(game)){
                self.gameMenuTableList.append(game)
            }
        }
        if(currentCount != self.gameMenuTableList.count){
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }
    }
    
}
