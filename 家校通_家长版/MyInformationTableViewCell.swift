//
//  MyInformationTableViewCell.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/28.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class MyInformationTableViewCell: UITableViewCell {
    @IBOutlet var Me_Info:UILabel?
    @IBOutlet var Me_Username:UILabel?
    @IBOutlet var Me_image:UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        Me_image?.layer.cornerRadius = (Me_image?.frame.width)!/2
        Me_image?.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
