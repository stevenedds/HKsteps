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
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
      avatarImageView?.layer.cornerRadius = (avatarImageView?.frame.size.width)! / 2
      avatarImageView?.clipsToBounds = true
      
  }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
