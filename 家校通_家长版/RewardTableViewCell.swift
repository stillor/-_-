//
//  RewardTableViewCell.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/8.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class RewardTableViewCell: UITableViewCell {
    @IBOutlet var content:UILabel?
    @IBOutlet var time:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
