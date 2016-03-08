//
//  LoginViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/4.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var username:UITextField?
    @IBOutlet var password:UITextField?
    @IBOutlet var tip:UILabel?
    @IBOutlet var log:UIButton?
    
    var name:String?
    var pass:String?
    
    @IBAction func login(){
        name = username?.text
        pass = password?.text
        
        if name != nil && pass != nil {
            asynchronousPost(name!, pass: pass!)
        }
    
    }
    
    
    func asynchronousPost(name:String,pass:String) -> Bool{
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
                        self.tip?.text = "用户名或密码错误"
                        self.tip?.textColor = UIColor.redColor()
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
        self.log?.backgroundColor = UIColor(red: 4/255, green: 175/255, blue: 200/255, alpha: 1)
        // Do any additional setup after loading the view.
         UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.username?.resignFirstResponder()
        self.password?.resignFirstResponder()
        
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
