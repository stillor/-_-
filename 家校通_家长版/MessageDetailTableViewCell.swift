//
//  MessageDetailTableViewCell.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/2.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class MessageDetailTableViewCell: UITableViewCell {
    @IBOutlet var MessageDetail_name:UILabel?
    @IBOutlet var MessageDetail_detail:UILabel?
    @IBOutlet var MessageDetail_date:UILabel?



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
