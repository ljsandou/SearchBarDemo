//
//  UserTableViewCell.swift
//  SearchBarDemo
//
//  Created by 三斗 on 5/24/16.
//  Copyright © 2016 com.streamind. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var introLabel: UILabel!
  
  @IBOutlet weak var userHeadImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
