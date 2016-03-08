//
//  Model.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/7.
//  Copyright © 2016年 stiller. All rights reserved.
//

import Foundation

class news{
    var url:String?
    var name:String?
    var brief:String?
    var time:String?
    
    init(url:String,name:String,brief:String,time:String){
        self.name = name
        self.brief = brief
        self.time = time
        self.url = url
    }

}