//
//  HomeMenuTable.swift
//  ios
//
//  Created by Matthew on 1/19/20.
//  Copyright © 2020 bahlsenwitz. All rights reserved.
//

import UIKit

class HomeMenuTable: UITableViewController {
    
    var activityIndicator: UIActivityIndicatorView?
    
    var leaderboardTableList: [Game] = [Game]()
    var player: Player?
    
    public var pageFromWhichContentLoads: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
    
    override open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("indexPath.row: \(indexPath.row)")
        if(indexPath.row < LeaderboardPageTask().PAGE_SIZE - 1){
            //print("indexPath.row: \(indexPath.row)")
            return
        }
        if indexPath.row == leaderboardTableList.count - 1 {
            //print("indexPath.row: \(indexPath.row)")
            self.fetchGameList()
        }
    }
    
    func fetchGameList() {
        DispatchQueue.main.async() {
            self.activityIndicator!.isHidden = false
            self.activityIndicator!.startAnimating()

        }
        //print("0 - self.activityIndicator!.isHidden: \(self.activityIndicator!.isHidden)")
        LeaderboardPageTask().execute(page: self.pageFromWhichContentLoads) { (result) in
            
            //print("1 - self.activityIndicator!.isHidden: \(self.activityIndicator!.isHidden)")
            
            DispatchQueue.main.async() {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.isHidden = true
            }
            
            //print("2 - self.activityIndicator!.isHidden: \(self.activityIndicator!.isHidden)")
            
            
            self.pageFromWhichContentLoads += 1
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
