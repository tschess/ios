//
//  GameTableViewController.swift
//  ios
//
//  Created by Matthew on 7/27/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class HistoricTable: UITableViewController {
    
    var label: UILabel?
    
    let DATE_TIME: DateTime = DateTime()
    
    var playerSelf: EntityPlayer?
    
    func setPlayerSelf(playerSelf: EntityPlayer){
        self.playerSelf = playerSelf
    }
    
    var gameMenuTableList: [EntityGame] = [EntityGame]()
    
    func getGameMenuTableList() -> [EntityGame] {
        return gameMenuTableList
    }
    
    public var pageFromWhichContentLoads: Int
    
    required init?(coder aDecoder: NSCoder) {
        self.pageFromWhichContentLoads = 0
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    var activityIndicator: UIActivityIndicatorView?
    
    public func setActivityIndicator(activityIndicator: UIActivityIndicatorView){
        self.activityIndicator = activityIndicator
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameMenuTableList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = gameMenuTableList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoricCell", for: indexPath) as! HistoricCell
        cell.terminalDateLabel.text = game.getLabelTextDate(update: true)
        cell.usernameLabel.text = game.getLabelTextUsernameOpponent(username: self.playerSelf!.username)
        cell.avatarImageView.image = game.getImageAvatarOpponent(username: self.playerSelf!.username)
        cell.displacementLabel.text = game.getLabelTextDisp(username: self.playerSelf!.username)
        cell.displacementImage.image = game.getImageDisp(username: self.playerSelf!.username)
        cell.oddsLabel.text = game.getOdds(username: self.playerSelf!.username)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let discoverSelectionDictionary: [String: Any] = ["historic_selection": indexPath.row]
        
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "HistoricSelection"),
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
    
    func fetchMenuTableList() {
        
        DispatchQueue.main.async() {
            self.activityIndicator!.isHidden = false
            self.activityIndicator!.startAnimating()
            
        }
        let REQUEST_PAGE_SIZE: Int = 9
        
        let requestPayload = [
            "id": self.playerSelf!.id,
            "index": self.pageFromWhichContentLoads,
            "size": REQUEST_PAGE_SIZE
            ] as [String: Any]
        RequestHistoric().execute(requestPayload: requestPayload) { (result) in
            DispatchQueue.main.async() {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
            }
            self.appendToLeaderboardTableList(additionalCellList: result!)
        }
    }
    
    private func renderShrug(){  // thiis can exist in practice...
        DispatchQueue.main.async() {
            let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5)
            self.label = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5, width: UIScreen.main.bounds.width, height: 40))
            self.label!.center = frameSize
            self.label!.textAlignment = .center
            self.label!.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
            self.label!.translatesAutoresizingMaskIntoConstraints = false
            let horizontalConstraint = NSLayoutConstraint(item: self.label!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            let verticalConstraint = NSLayoutConstraint(item: self.label!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            
            //self.activityIndicator!.stopAnimating()
            self.label!.text = "¯\\_( ͡° ͜ʖ ͡°)_/¯"
            self.view.addSubview(self.label!)
            self.view.addConstraints([horizontalConstraint, verticalConstraint])
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //        let gameTableMenuItem = gameMenuTableList[indexPath.row]
        //        if(!gameTableMenuItem.inbound!){
        //           return nil
        //        }
        let modifyAction = UIContextualAction(style: .normal, title:  "REMATCH", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            let gameModel = self.gameMenuTableList[indexPath.row]
            
            //            let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
            //            let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
            //            viewController.setPlayer(player: self.player!)
            //            viewController.setGameModel(gameModel: gameModel)
            //            UIApplication.shared.keyWindow?.rootViewController = viewController
            //            success(true)
        })
        if #available(iOS 13.0, *) { //xmark
            modifyAction.image = UIImage(systemName: "gamecontroller.fill")!
        }
        modifyAction.backgroundColor = .purple
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
}
