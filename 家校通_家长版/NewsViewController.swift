//
//  NewsViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/7.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import Alamofire

class NewsViewController: UIViewController {
    
    @IBOutlet var content:UILabel?
    @IBOutlet var time:UILabel?
    
    var tit:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getContent()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContent(){
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080/FSC/ParentServlet?AC=getNoticeDetailJSON", parameters: ["title":tit!])
            .response { request, response, data, error in
                if data != nil{
                    do{
                        let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
                    let t = json.objectForKey("title") as! String
                    let c = json.objectForKey("content") as! String
                    let ti = json.objectForKey("time") as! String
                        
                    self.content?.text = c
                    self.time?.text = ti
                        
                    }catch let erro{
                        
                        print("Something is worry with \(erro)")
                        
                    }
                    
                }
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
