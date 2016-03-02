//
//  PandectTableViewCell.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/26.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

import UIKit

class PandectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var header: UIView!
    @IBOutlet var info:UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}