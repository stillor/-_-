//
//  AttendanceTableViewCell.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/23.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class AttendanceTableViewCell: UITableViewCell {
    @IBOutlet var Student_Attendance_Date:UILabel?
    @IBOutlet var Student_Attendance_Morning:UILabel?
    @IBOutlet var Student_Attendance_Afternoon:UILabel?
    @IBOutlet var Student_Attendance_Evening:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
