//
//  StudentTableViewCell.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/23.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
    @IBOutlet var Student_info:UILabel?
    @IBOutlet var Student_detail:UILabel?
    @IBOutlet var Student_center:UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
