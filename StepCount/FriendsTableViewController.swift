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
  
  let names = ["steve", "ryan", "max"]
  let steps = ["8,295", "7,565", "4,200"]
  let avatars = ["steve.jpg", "ryan.png", "max.png"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = backgroundColor
      
      navigationController?.navigationBar.barTintColor = purple
      navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: white]


      tableView.registerNib(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: friendCellID)
    }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 80
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier(friendCellID) as! FriendTableViewCell
    
    cell.avatarImageView?.image = UIImage(named: avatars[indexPath.row])
    cell.nameLabel.text = names[indexPath.row]
    cell.stepsLabel.text = steps[indexPath.row]
    
    return cell
  }

}
