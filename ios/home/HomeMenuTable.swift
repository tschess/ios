//
//  HomeMenuTable.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit
import SwipeCellKit

class HomeMenuTable: UITableViewController, SwipeTableViewCellDelegate {
    
    var home: Home?
    
    let REQUEST_PAGE_SIZE: Int
    var requestPageIndex: Int
    var leaderboardList: [EntityGame]
    
    required init?(coder aDecoder: NSCoder) {
        self.REQUEST_PAGE_SIZE = 9
        self.requestPageIndex = 0
        self.leaderboardList = [EntityGame]()
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        if(orientation == .left) {
            let modifyAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                
                let cell = tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
                cell.hideSwipe(animated: false, completion: nil)
                
                self.home!.setIndicator(on: true)
                
                let playerOther = self.leaderboardList[indexPath.row]
                
                RequestRecent().execute(id: playerOther.id) { (result) in
                    self.home!.setIndicator(on: false)
                    
                    if(result["fail"] != nil) {
                        DispatchQueue.main.async {
                            let storyboard: UIStoryboard = UIStoryboard(name: "PopNoop", bundle: nil)
                            let viewController = storyboard.instantiateViewController(withIdentifier: "PopNoop") as! PopDismiss
                            self.present(viewController, animated: true, completion: nil)
                        }
                        return
                    }
                    let game: EntityGame = ParseGame().execute(json: result)
                    DispatchQueue.main.async() {
                        SelectSnapshot().snapshot(playerSelf: self.home!.playerSelf!, game: game, presentor: self)
                    }
                }
            }
            modifyAction.image = UIImage(named: "eyeye")!
            //modifyAction.image = UIImage(named: "eye_g")!
            //modifyAction.backgroundColor = .orange
            modifyAction.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
            
            modifyAction.title = "recent"
            //modifyAction.textColor = UIColor.lightGray
            modifyAction.textColor = UIColor.white
            return [modifyAction]
        }
        let modifyAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            
            let cell = tableView.cellForRow(at: indexPath) as! SwipeTableViewCell
            cell.hideSwipe(animated: false, completion: nil)
            
            
            
        }
        
        let game = self.leaderboardList[indexPath.row]
        let winner: Bool = game.getWinner(username: self.home!.playerSelf!.username)
       
        if(winner){
            modifyAction.image = UIImage(named: "challenge_grn")!
            modifyAction.textColor = UIColor.green
            //self.imageSlide.image = UIImage(named: "more_vert_grn")
            //return
        } else {
            modifyAction.image = UIImage(named: "challenge_red")!
            //self.imageSlide.image = UIImage(named: "more_vert_red")
            modifyAction.textColor = UIColor.red
        }
        if(game.condition == "DRAW"){
            modifyAction.image = UIImage(named: "challenge_yel")!
            
            modifyAction.textColor = UIColor.yellow
            //self.imageSlide.image = UIImage(named: "more_vert_yel")
            //return
        }
        
        
        
        modifyAction.title = "snapshot"
     
        
        modifyAction.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
        
        return [modifyAction]
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let discoverSelectionDictionary: [String: Any] = ["home_menu_selection": indexPath.row]
        
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "HomeMenuSelection"),
            object: nil,
            userInfo: discoverSelectionDictionary)
    }
    
    override func viewDidLoad() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.white
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        self.requestPageIndex = 0
        let requestPayload: [String: Any] = ["id": home!.playerSelf!.id,
                                             "id_player": self.home!.playerSelf!.id,
                                             "size": REQUEST_PAGE_SIZE]
        RequestActual().execute(requestPayload: requestPayload) { (response) in
            //if(response == nil){
                //return
            //}
            //let playerSelf: EntityPlayer = response!.last!
            
            //self.home!.playerSelf = playerSelf
            //let list: [EntityGame] = response!.dropLast()
            
            DispatchQueue.main.async() {
                
                //self.home!.renderHeader()
                
                self.leaderboardList = [EntityGame]()
                self.tableView.reloadData()
                self.appendToLeaderboardTableList(additionalCellList: response)
                refreshControl.endRefreshing()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardList.count
    }
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let index: Int = indexPath.row
        let game: EntityGame = self.leaderboardList[index]
        let username: String = self.home!.playerSelf!.username
        let usernameOther: String = game.getLabelTextUsernameOpponent(username: username)
        let avatarImageOther: UIImage = game.getImageAvatarOpponent(username: username)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellHome", for: indexPath) as! MenuCellHome
        cell.delegate = self
        
        cell.setContent(usernameSelf: username, usernameOther: usernameOther, game: game, avatarImageOther: avatarImageOther)
        
        
        return cell
    }
    
    var swipeVisible: Bool = false
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        guard let cell = sender.view?.superview?.superview as? MenuCellHome else {
            return
        }
        if(!self.swipeVisible){
            cell.showSwipe(orientation: .right, animated: true)
            self.swipeVisible = true
            return
        }
        cell.hideSwipe(animated: true, completion: nil)
        self.swipeVisible = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let visibleRows = self.tableView.indexPathsForVisibleRows
        let lastRow = visibleRows?.last?.row
        if(lastRow == nil){
            return
        }
        let index = self.requestPageIndex
        let size = self.REQUEST_PAGE_SIZE
        let indexFrom: Int =  index * size
        let indexTo: Int = indexFrom + REQUEST_PAGE_SIZE - 2
        if lastRow == indexTo {
            self.requestPageIndex += 1
            self.fetchGameList()
        }
    }
    
    func fetchGameList() {
        //RequestActual {
        
        //"id":"", "page":0, "size":13
        self.home!.setIndicator(on: true)
        
        let requestPayload = ["id": self.home!.playerSelf!.id,
                              "index": self.requestPageIndex,
                              "size": REQUEST_PAGE_SIZE] as [String: Any]
        RequestActual().execute(requestPayload: requestPayload) { (result) in
            self.home!.setIndicator(on: false)
            self.appendToLeaderboardTableList(additionalCellList: result)
        }
    }
    
    func appendToLeaderboardTableList(additionalCellList: [EntityGame]) {
        for game in additionalCellList {
            self.leaderboardList.append(game)
        }
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
}
