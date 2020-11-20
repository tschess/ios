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
    var leaderboardList: [EntityPlayer]
    
    required init?(coder aDecoder: NSCoder) {
        self.REQUEST_PAGE_SIZE = 9
        self.requestPageIndex = 0
        self.leaderboardList = [EntityPlayer]()
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
            
            let playerOther = self.leaderboardList[indexPath.row]
                DispatchQueue.main.async {
                    let height: CGFloat = UIScreen.main.bounds.height
                    if(height.isLess(than: 750)){
                        let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeL", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeL") as! Challenge
                        viewController.setPlayerSelf(playerSelf: self.home!.playerSelf!)
                        viewController.setPlayerOther(playerOther: playerOther)
                        viewController.setSelection(selection: Int.random(in: 0...3))
                        viewController.BACK = "HOME"
                        self.navigationController?.pushViewController(viewController, animated: false)
                        return
                    }
                    let storyboard: UIStoryboard = UIStoryboard(name: "ChallengeP", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "ChallengeP") as! Challenge
                    viewController.setPlayerSelf(playerSelf: self.home!.playerSelf!)
                    viewController.setPlayerOther(playerOther: playerOther)
                    viewController.setSelection(selection: Int.random(in: 0...3))
                    viewController.BACK = "HOME"
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
        }
        //modifyAction.image = UIImage(named: "challenge_g")!
        modifyAction.image = UIImage(named: "challenge")!
        modifyAction.title = "challenge"
        modifyAction.textColor = UIColor.white
        //modifyAction.backgroundColor = .purple
        modifyAction.backgroundColor = UIColor(red: 39.0/255, green: 41.0/255, blue: 44.0/255, alpha: 1.0)
        
        return [modifyAction]
    }
    
    func getOther(index: Int) -> EntityPlayer {
        return self.leaderboardList[index]
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
        let requestPayload: [String: Any] = ["id_player": self.home!.playerSelf!.id,
                                             "size": REQUEST_PAGE_SIZE]
        RequestRefresh().execute(requestPayload: requestPayload) { (response) in
            if(response == nil){
                return
            }
            let playerSelf: EntityPlayer = response!.last!
            
            self.home!.playerSelf = playerSelf
            let list: [EntityPlayer] = response!.dropLast()
            
            DispatchQueue.main.async() {
                
                //self.home!.renderHeader()
                
                self.leaderboardList = [EntityPlayer]()
                self.tableView.reloadData()
                self.appendToLeaderboardTableList(additionalCellList: list)
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
        let player = self.leaderboardList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMenuCell", for: indexPath) as! HomeMenuCell
        cell.delegate = self
        cell.avatarImageView.image = player.getImageAvatar()
        //cell.rankLabel.text = player.getLabelTextRank()
        cell.usernameLabel.text = player.username
        cell.dateLabel.text = player.getLabelTextDate()
        
        let val: String = player.getLabelTextDisp()
        if(val == "0"){
            cell.dispLabel.isHidden = true
            cell.dispImage.isHidden = true
            cell.dispLabelAlign.isHidden = true
        } else {
            cell.dispLabel.isHidden = false
            cell.dispImage.isHidden = false
            cell.dispLabelAlign.isHidden = false
            cell.dispLabel.text = player.getLabelTextDisp()
            cell.dispImage.image = player.getImageDisp()!
            cell.dispImage.tintColor = player.tintColor
        }
        
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        cell.buttonSideSlide.addGestureRecognizer(pictureTap)
        cell.buttonSideSlide.isUserInteractionEnabled = true
        
        
        
        return cell
    }
    
    var swipeVisible: Bool = false
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        guard let cell = sender.view?.superview?.superview as? HomeMenuCell else {
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
        self.home!.setIndicator(on: true)
        
        let requestPayload = ["index": self.requestPageIndex,
                              "size": REQUEST_PAGE_SIZE] as [String: Int]
        RequestPage().execute(requestPayload: requestPayload) { (result) in
            self.home!.setIndicator(on: false)
            if(result == nil){
                return
            }
            self.appendToLeaderboardTableList(additionalCellList: result!)
        }
    }
    
    func appendToLeaderboardTableList(additionalCellList: [EntityPlayer]) {
        for game in additionalCellList {
            self.leaderboardList.append(game)
        }
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
}
