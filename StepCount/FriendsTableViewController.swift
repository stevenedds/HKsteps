//
//  FriendsTableViewController.swift
//  StepCount
//
//  Created by ultraflex on 2/8/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

  let purple = UIColor(red: 78/255, green: 112/255, blue: 239/255, alpha: 1)
  let white = UIColor.whiteColor()
  let backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 253/255, alpha: 1)

  let friendCellID = "FriendCell"
  
  let friends = [
    Friend(name: "steve", steps: "8,240", avatarName: "steve.jpg"),
    Friend(name: "ryan", steps: "7,509", avatarName: "ryan.png"),
    Friend(name: "max", steps: "4,374", avatarName: "max.png")]

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = backgroundColor
      
      navigationController?.navigationBar.barTintColor = purple
      navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: white]


      tableView.registerNib(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: friendCellID)
    }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return friends.count
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 80
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier(friendCellID) as! FriendTableViewCell
    
    cell.avatarImageView?.image = UIImage(named: friends[indexPath.row].avatarName)
    cell.nameLabel.text = friends[indexPath.row].name
    cell.stepsLabel.text = friends[indexPath.row].steps
    
    return cell
  }

}
