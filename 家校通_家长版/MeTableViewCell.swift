//
//  MeTableViewCell.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/24.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class MeTableViewCell: UITableViewCell {
    @IBOutlet var Me_Name:UILabel?
    @IBOutlet var Me_Detail:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
