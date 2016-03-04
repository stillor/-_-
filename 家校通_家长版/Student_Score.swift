//
//  Student_Score.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/4.
//  Copyright © 2016年 stiller. All rights reserved.
//

import Foundation

class Score{
    var name:String?
    var number:String?
    var Chinese:String?
    var math:String?
    var English:String?
    var physics:String?
    var chemistry:String?
    var biology:String?
    var class_rank:String?
    var grade_rank:String?
    
    init(name:String,number:String,Chinese:String,math:String,English:String,physics:String,chemistry:String,biology:String,class_rank:String,grade_rank:String){
        
        self.biology = biology
        self.chemistry = chemistry
        self.Chinese = Chinese
        self.class_rank = class_rank
        self.English = English
        self.grade_rank = grade_rank
        self.math = math
        self.name = name
        self.number = number
        self.physics = physics
        
    }
}

