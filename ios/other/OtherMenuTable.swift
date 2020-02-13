//
//  OtherMenuTable.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class OtherMenuTable: UITableViewController {
    
    var recent1: Bool?
    
    func setRecent1(recent1: Bool) {
        self.recent1 = recent1
    }
    
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
    
    public var pageFromWhichContentLoads: Int
    
    required init?(coder aDecoder: NSCoder) {
        self.pageFromWhichContentLoads = 0
        super.init(coder: aDecoder)
    }
    
    func getGameMenuTableList() -> [EntityGame] {
        return gameMenuTableList
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //recent1
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if(self.recent1 != nil){
//            return
//        }
        
        //if(self.recent1!){
            //if(gameMenuTableList.count > 0){
               
            //}
        //}
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
        cell.terminalDateLabel.text = game.getLabelTextDate(update: true)
        cell.usernameLabel.text = game.getLabelTextUsernameOpponent(username: self.player!.username)
        cell.avatarImageView.image = game.getImageAvatarOpponent(username: self.player!.username)
        cell.displacementLabel.text = game.getLabelTextDisp(username: self.player!.username)
        cell.oddsLabel.text = game.getOdds(username: self.player!.username)
        cell.displacementImage.image = game.getImageDisp(username: self.player!.username)
        cell.displacementImage.tintColor = game.getTint(username: self.player!.username)
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
           
           let index = self.pageFromWhichContentLoads
           let size = REQUEST_PAGE_SIZE
           let indexFrom: Int =  index * size
           let indexTo: Int = indexFrom + REQUEST_PAGE_SIZE - 2
           
           if(lastRow! <= indexTo){
               return
           }
           if lastRow == indexTo {
               self.pageFromWhichContentLoads += 1
               self.fetchMenuTableList()
           }
       }
    
    func fetchMenuTableList() {

        DispatchQueue.main.async() {
            self.activityIndicator!.isHidden = false
            self.activityIndicator!.startAnimating()
            
        }
        let REQUEST_PAGE_SIZE: Int = 9
        
        let requestPayload = [
            "id": self.player!.id,
            "index": self.pageFromWhichContentLoads,
            "size": REQUEST_PAGE_SIZE
            ] as [String: Any]
        RequestHistoric().execute(requestPayload: requestPayload) { (result) in
            DispatchQueue.main.async() {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
            }
            if(result == nil){
                return
            }
            self.appendToLeaderboardTableList(additionalCellList: result!)
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
                
                let game = self.gameMenuTableList.last!
                               
                               let storyboard: UIStoryboard = UIStoryboard(name: "Snapshot", bundle: nil)
                               let viewController = storyboard.instantiateViewController(withIdentifier: "Snapshot") as! Snapshot
                               viewController.setGame(game: game)
                               viewController.setPlayer(player: self.player!)
                               self.present(viewController, animated: false, completion: nil)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title:  "CHALLENGE", handler: { (ac: UIContextualAction, view: UIView, success:(Bool) -> Void) in
            
            let gameModel = self.gameMenuTableList[indexPath.row]
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
            viewController.setPlayerSelf(playerSelf: self.player!)
            viewController.setPlayerOther(playerOther: gameModel.getPlayerOther(username: self.player!.username))
            UIApplication.shared.keyWindow?.rootViewController = viewController
            
            success(true)
        })
        if #available(iOS 13.0, *) {
            modifyAction.image = UIImage(systemName: "gamecontroller.fill")!
        }
        modifyAction.backgroundColor = .purple
        
        
        let config = UISwipeActionsConfiguration(actions: [modifyAction])
        config.performsFirstActionWithFullSwipe = false
       
        
        return config
    }
    
    private func renderShrug(){  // this can exist in practice...
        DispatchQueue.main.async() {
            let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5)
            let label = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5, width: UIScreen.main.bounds.width, height: 40))
            label.textColor = UIColor.white
            label.center = frameSize
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
            label.translatesAutoresizingMaskIntoConstraints = false
            let horizontalConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            let verticalConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            label.text = "¯\\_( ͡° ͜ʖ ͡°)_/¯"
            self.view.addSubview(label)
            self.view.addConstraints([horizontalConstraint, verticalConstraint])
        }
    }
}
