//
//  HttpRequest.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/3.
//  Copyright © 2016年 stiller. All rights reserved.
//

import Foundation

class HttpRequest{
    var url:NSURL?
    var data:NSData?
    init(url:NSURL){
        self.url = url
    }
    
    func asynchronousPost() {
      let request:NSMutableURLRequest = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData,timeoutInterval: 10)
        request.HTTPMethod = "POST"
        NSURLConnection.sendAsynchronousRequest(request, queue:NSOperationQueue.mainQueue()){
            (response, data, error) -> Void in
            if data != nil{
                self.data = data
            }else{
            }
          }
    }
    

}


