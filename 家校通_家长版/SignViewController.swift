//
//  SignViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/7.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {
    
    @IBOutlet var username:UITextField?
    @IBOutlet var password:UITextField?
    @IBOutlet var password2:UITextField?
    @IBOutlet var name:UITextField?
    @IBOutlet var phone:UITextField?
    @IBOutlet var studentID:UITextField?
    @IBOutlet var identify:UITextField?
    @IBOutlet var identifyImage:UIImageView?
    
    @IBOutlet var tip_password:UILabel?
    @IBOutlet var tip_identify:UILabel?
    
    @IBAction func sign(){
        let username = self.username?.text
        let password = self.password?.text
        let password2 = self.password2?.text
        let name = self.name?.text
        let phone = self.phone?.text
        let studentID = self.studentID?.text
        let identify = self.identify?.text
        if password == password2{
            self.asynchronousPost(username!, pass: password!, name: name!, phone: phone!, studentID: studentID!, identify: identify!)
        }else{
            self.tip_password?.text = "两次密码不一致"
        }
        
    }
    
    @IBAction func sure(){
        
    }
    
    func asynchronousPost(username:String,pass:String,name:String,phone:String,studentID:String,identify:String) -> Bool{
        let global = Global()
        let url:NSURL! = NSURL(string: "http://\(global.IP):8080/FSC/PControllerServlet?AC=parentLoginJSON&userName=\(name)&password=\(pass)")
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData,timeoutInterval: 10)
        var flag:Bool = false
        request.HTTPMethod = "POST"
        
        NSURLConnection.sendAsynchronousRequest(request, queue:NSOperationQueue.mainQueue()){
            (response, data, error) -> Void in
            if data != nil{
                do{
                    
                    let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
                    //解析JSON字符串
                    
                    let error = json.objectForKey("Error")
                    
                    if error == nil{
                        let ParentUserName = json.objectForKey("ParentUserName") as! String
                        let ParentName = json.objectForKey("ParentName") as! String
                        let ImagePosition = json.objectForKey("ImagePosition") as! String
                        NSUserDefaults.standardUserDefaults().setObject(name, forKey: "username")
                        NSUserDefaults.standardUserDefaults().setObject(pass, forKey: "password")
                        NSUserDefaults.standardUserDefaults().setObject(ParentUserName, forKey: "ParentUserName")
                        NSUserDefaults.standardUserDefaults().setObject(ParentName, forKey: "ParentName")
                        NSUserDefaults.standardUserDefaults().setObject(ImagePosition, forKey: "ImagePosition")
                        NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "login")
                        self.performSegueWithIdentifier("LoginIdentifier", sender: self)
                        flag = true
                    }else{
                        self.tip_password?.text = ""
                        self.tip_password?.textColor = UIColor.redColor()
                    }
                }catch let erro{
                    
                    print("Something is worry with \(erro)")
                    
                }
                
                
            }
        }
        return flag
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        let g = Global()
        identifyImage?.kf_setImageWithURL(NSURL(string:"http://\(g.IP):8080/FSC/idCode.jsp")!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
