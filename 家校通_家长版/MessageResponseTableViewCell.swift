//
//  MessageResponseTableViewCell.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/2.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class MessageResponseTableViewCell: UITableViewCell {
    @IBOutlet var MessageResponse_name:UILabel?
    @IBOutlet var MessageResponse_date:UILabel?
    @IBOutlet var MessageResponse_info:UILabel?
    @IBOutlet var MessageResponse_image:UIImageView?
    override func awakeFromNib() {
        super.awakeFromNib()
        MessageResponse_image?.layer.cornerRadius = (MessageResponse_image?.frame.width)!/2
        MessageResponse_image?.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
