//
//  FriendTableViewCell.swift
//  StepCount
//
//  Created by ultraflex on 2/8/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var stepsLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
  
  let green = UIColor(red: 62/255, green: 213/255, blue: 171/255, alpha: 1)
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
      avatarImageView?.layer.cornerRadius = (avatarImageView?.frame.size.width)! / 2
      avatarImageView?.clipsToBounds = true
      
      stepsLabel.textColor = green
      
  }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
