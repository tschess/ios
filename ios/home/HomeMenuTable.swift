//
//  HomeMenuTable.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class HomeMenuTable: UITableViewController {
    
    let REQUEST_PAGE_SIZE: Int = 9
    var requestPageIndex: Int = 0
    //??? ^when/where/how does this get reset by lifecycle???
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var activityIndicator: UIActivityIndicatorView?
    var leaderboardTableList: [Game] = [Game]()
    var player: Player?
    
    override func viewDidLoad() {
        self.fetchGameList()
    }
    
    public func setActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        self.activityIndicator = activityIndicator
    }
    
    public func setPlayer(player: Player) {
        self.player = player
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }
    
    func getLeaderboardTableList() -> [Game] {
        return leaderboardTableList
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardTableList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMenuCell", for: indexPath) as! HomeMenuCell
        let gameTableMenuItem = leaderboardTableList[indexPath.row]
        
        let dataDecoded: Data = Data(base64Encoded: gameTableMenuItem.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        cell.avatarImageView.image = decodedimage
        cell.rankLabel.text = gameTableMenuItem.getOpponentRank()
        cell.usernameLabel.text = gameTableMenuItem.getUsernameOpponent()
        
        let date = gameTableMenuItem.getOpponent().getDate()
        if(date == "TBD"){
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YY"
            var yayayaya = formatter.string(from: DateTime().currentDate())
            yayayaya.insert("'", at: yayayaya.index(yayayaya.endIndex, offsetBy: -2))
            cell.dateLabel.text = yayayaya
        } else {
            //date...
        }
        
        cell.dispLabel.text = String(abs(Int(gameTableMenuItem.getOpponent().getDisp())!))
        
        let disp: Int = Int(gameTableMenuItem.getOpponent().getDisp())!
        
        if(disp >= 0){
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.up")!
                cell.dispImage.image = image
                cell.dispImage.tintColor = .green
            }
        }
        else {
            if #available(iOS 13.0, *) {
                let image = UIImage(systemName: "arrow.down")!
                cell.dispImage.image = image
                cell.dispImage.tintColor = .red
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let discoverSelectionDictionary = ["discover_selection": indexPath.row]
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "DiscoverSelection"),
            object: nil,
            userInfo: discoverSelectionDictionary)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let visibleRows = self.tableView.indexPathsForVisibleRows
        let lastRow = visibleRows?.last?.row
        print("                         lastRow: \(lastRow)")
        
        if(lastRow == nil){
           return
        }
        
        let index = self.requestPageIndex
        print("                         index: \(index)")
        print("                         self.requestPageIndex: \(self.requestPageIndex)")
        let size = self.REQUEST_PAGE_SIZE
        print("                         size: \(size)")
        print("                         self.REQUEST_PAGE_SIZE: \(self.REQUEST_PAGE_SIZE)")
        let indexFrom: Int =  index * size
        print("                         indexFrom: \(indexFrom)")
        let indexTo: Int = indexFrom + REQUEST_PAGE_SIZE - 2
        
       
       print("                         indexTo: \(indexTo)")
        
        if lastRow == indexTo {
             self.requestPageIndex += 1
             self.fetchGameList()
        }
    }
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let intTotalrow = tableView.numberOfRows(inSection: indexPath.section) //first get total rows in that section by current indexPath.
//        //get last last row of tablview
//        if indexPath.row == intTotalrow - 1{
//
//            // call for last display
//            let gameTableMenuItem = leaderboardTableList[indexPath.row]
//            print("                                       indexPath.row: \(indexPath.row)")
//            print("                                            username: \(gameTableMenuItem.getOpponent().getUsername())")
//
//
//        }
//    }
    
//    override open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let indices = tableView.indexPathsForVisibleRows {
//            for index in indices {
//
//                print("                                       index.row: \(index.row)")
//                //print("(self.REQUEST_PAGE_SIZE * self.requestPageIndex): \((self.REQUEST_PAGE_SIZE * self.requestPageIndex))")
//                //print("                         (REQUEST_PAGE_SIZE - 2): \((REQUEST_PAGE_SIZE - 2))")
//                print("\n\n")
//
//                if index.row == (self.REQUEST_PAGE_SIZE * self.requestPageIndex) + (REQUEST_PAGE_SIZE - 2) {
//
//
//
//                    self.fetchGameList()
//                }
//            }
//        }
//    }
    
    func fetchGameList() {
        
        print("~ so fetch ~")
        print("self.REQUEST_PAGE_SIZE: \(self.REQUEST_PAGE_SIZE)")
        print("      requestPageIndex: \(self.requestPageIndex)")
        
        DispatchQueue.main.async() {
            self.activityIndicator!.isHidden = false
            self.activityIndicator!.startAnimating()
            
        }
        
        let requestPayload = [
            "index": self.requestPageIndex,
            "size": REQUEST_PAGE_SIZE
            ] as [String: Int]
        
        RequestPageTask().execute(requestPayload: requestPayload) { (result) in
            
            //print("1 - self.activityIndicator!.isHidden: \(self.activityIndicator!.isHidden)")
            
            DispatchQueue.main.async() {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
            }
            
            //print("2 - self.activityIndicator!.isHidden: \(self.activityIndicator!.isHidden)")
            
            
            
            if(result == nil){
                return
            }
            self.appendToLeaderboardTableList(additionalCellList: result!)
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //        let leaderboardItem = leaderboardTableList[indexPath.row]
        //        if(!gameTableMenuItem.inbound!){
        //           return nil
        //        }
        let modifyAction = UIContextualAction(style: .normal, title:  "CHALLENGE", handler: { (ac: UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            
            //let gameModel = Game(opponent: self.player!)
            let gameModel = self.leaderboardTableList[indexPath.row]
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Challenge") as! Challenge
            viewController.setPlayer(player: self.player!)
            viewController.setGameModel(gameModel: gameModel)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            success(true)
        })
        if #available(iOS 13.0, *) { //xmark
            modifyAction.image = UIImage(systemName: "gamecontroller.fill")!
        }
        modifyAction.backgroundColor = .purple
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
    func appendToLeaderboardTableList(additionalCellList: [Game]) {
        let leaderboardCount = leaderboardTableList.count
        for game in additionalCellList {
            if(!leaderboardTableList.contains(game)){
                leaderboardTableList.append(game)
            }
        }
        DispatchQueue.main.async() {
            if(leaderboardCount != self.leaderboardTableList.count){
                //self.leaderboardTableList = self.leaderboardTableList.sorted(by: {Int($0.getOpponentElo())! > Int($1.getOpponentElo())!})
                self.tableView.reloadData()
            }
        }
    }
}
