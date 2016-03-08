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

class attendance{
    var date:String?
    var morning:String?
    var afternoon:String?
    var evening:String?
    
    init(date:String,morning:String,afternoon:String,evening:String){
        self.afternoon = afternoon
        self.date = date
        self.evening = evening
        self.morning = morning
    }
}

class reward{
    var content:String?
    var time:String?
    
    init(content:String,time:String){
        self.content = content
        self.time = time
    }
}

class teacher{
    var userName:String?
    var name:String?
    var type:String?
    var course:String?
    
    init(userName:String,name:String,type:String,course:String){
        self.course = course
        self.name = name
        self.type = type
        self.userName = userName
    }
}

class message{
    var title:String?
    var themeID:String?
    var date:String?
    var content:String?
    
    init(title:String,themeID:String,date:String,content:String){
        self.content = content
        self.date = date
        self.themeID = themeID
        self.title = title
    }
}

class detail{
    var author:String?
    var receiver:String?
    var time:String?
    var content:String?
    
    init(author:String,receiver:String,time:String,content:String){
        self.content = content
        self.author = author
        self.receiver = receiver
        self.time = time
    }
}

