//
//  GameTableViewController.swift
//  ios
//
//  Created by Matthew on 7/27/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit

class ActualTable: UITableViewController {
    
    var gameMenuTableList: [Game] = [Game]()
    var player: Player?
    var label: UILabel?
    
    public var pageFromWhichContentLoads: Int
    
    required init?(coder aDecoder: NSCoder) {
        self.pageFromWhichContentLoads = 0
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.tableFooterView = UIView()
        
        self.fetchMenuTableList(id: self.player!.getId())
    }
    
    func getGameMenuTableList() -> [Game] {
        return gameMenuTableList
    }
    
    public func setPlayer(player: Player) {
        self.player = player
    }
    
    var activityIndicator: UIActivityIndicatorView?
    
    public func setIndicator(indicator: UIActivityIndicatorView){
        self.activityIndicator = indicator
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameMenuTableList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActualCell", for: indexPath) as! ActualCell
        
        let gameTableMenuItem = gameMenuTableList[indexPath.row]
        
        cell.usernameLabel.text = gameTableMenuItem.getOpponentName()
        //cell.eloLabel.text = gameTableMenuItem.getOpponentElo()
        let dataDecoded: Data = Data(base64Encoded: gameTableMenuItem.getOpponentAvatar(), options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        cell.avatarImageView.image = decodedimage
        
        let status = gameTableMenuItem.getGameStatus()
        
        if(status == "ONGOING"){
            if(gameTableMenuItem.usernameTurn == self.player!.getName()){
                //cell.actionLabel.text = "my move"
                //cell.actionLabel.textColor = Colour().getRed()
                return cell
            }
            //cell.actionLabel.text = "opponent's move"
            //cell.actionLabel.textColor = UIColor.black
            return cell
        }
        // 'PROPOSED'...
        if(gameTableMenuItem.inbound!){
            //cell.actionLabel.text = "review"
            cell.backgroundColor = Colour().getInbound()
            
            let label = cell.viewWithTag(1)! as! UILabel
            label.textColor = UIColor.black
            cell.usernameLabel.textColor = UIColor.black
            //cell.actionLabel.textColor = UIColor.black
            return cell
        }
        //cell.actionLabel.text = "rescind"
        cell.backgroundColor = Colour().getOutbound()
        
        let label = cell.viewWithTag(1)! as! UILabel
        label.textColor = UIColor.white
        
        cell.usernameLabel.textColor = UIColor.white
        //cell.actionLabel.textColor = UIColor.white
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var discoverSelectionDictionary: [String: Any] = ["actual_selection": indexPath.row]
        
        let cell = tableView.cellForRow(at: indexPath) as! ActualCell
        
        discoverSelectionDictionary["action"] = cell.actionLabel!.text!
        
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "ActualSelection"),
            object: nil,
            userInfo: discoverSelectionDictionary)
    }
    
    override open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(tableView.selectionCount < 13 && self.pageFromWhichContentLoads > 0){
            return
        }
        if indexPath.row == self.gameMenuTableList.count - 1 {
            self.pageFromWhichContentLoads += 1
            self.fetchMenuTableList(id: self.player!.getId())
        }
    }
    
    func appendToTableList(additionalCellList: [Game]) {
        let currentCount = self.gameMenuTableList.count
        for game in additionalCellList {
            if(!self.gameMenuTableList.contains(game)){
                self.gameMenuTableList.append(game)
            }
        }
        if(currentCount != self.gameMenuTableList.count){
            self.gameMenuTableList = self.gameMenuTableList.sorted(by: { $0.inbound! && !$1.inbound! })
            self.gameMenuTableList = self.gameMenuTableList.sorted(by: { $0.gameStatus < $1.gameStatus })
            DispatchQueue.main.async() {
                //self.activityIndicator!.stopAnimating()
                //self.activityIndicator!.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchMenuTableList(id: String) {
        PageList().execute(player: self.player!, page: self.pageFromWhichContentLoads){ (result) in
            if(result == nil){
                return
            }
            let resultList: [Game] = result!
            if(resultList.count == 0) {
                self.renderShrug()
                return
            }
            if(self.label != nil) {
                self.label!.removeFromSuperview()
            }
            self.appendToTableList(additionalCellList: resultList)
        }
    }
    
    private func renderShrug(){
//        DispatchQueue.main.async() {
//            self.activityIndicator!.stopAnimating()
//            self.activityIndicator!.isHidden = true
//            let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5)
//            self.label = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5, width: UIScreen.main.bounds.width, height: 40))
//            self.label!.center = frameSize
//            self.label!.textAlignment = .center
//            self.label!.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
//            self.label!.translatesAutoresizingMaskIntoConstraints = false
//            let horizontalConstraint = NSLayoutConstraint(item: self.label!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
//            let verticalConstraint = NSLayoutConstraint(item: self.label!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
//            self.label!.text = "¯\\_( ͡° ͜ʖ ͡°)_/¯"
//            self.view.addSubview(self.label!)
//            self.view.addConstraints([horizontalConstraint, verticalConstraint])
//        }
    }
}

extension UITableView {

    var selectionCount: Int {
        let sections = self.numberOfSections
        var rows = 0
        for i in 0...sections - 1 {
            rows += self.numberOfRows(inSection: i)
        }
        return rows
    }
}
