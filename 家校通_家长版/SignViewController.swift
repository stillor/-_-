//
//  SignViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/7.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import Alamofire

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
        if self.OK {
            if password == password2{
                self.asynchronousPost(username!, pass: password!, pass2: password2!,name: name!, phone: phone!, studentID: studentID!, identify: identify!)
            }else{
                self.tip_password?.text = "两次密码不一致"
            }
        }else{
            self.tip_password?.text = "用户名未经检测"
            self.tip_password?.textColor = UIColor.redColor()
        }
       
        
    }
    
    var OK:Bool = false
    
    @IBAction func sure(){
        makesure()
    }
    
    //var req = NSMutableURLRequest.init()
    
    func makesure(){
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080/FSC/UtilServlet?AC=isUserNameValid", parameters: ["userName":(self.username?.text)!])
            .response { request, response, data, error in
            if data != nil{
                do{
                    
                   let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
                   let result = json.objectForKey("Result") as! String
                    print(result)
                    if result == "false" {
                        self.tip_password?.text = "用户名不可用"
                        self.tip_password?.textColor = UIColor.redColor()
                        self.OK = false
                    }else{
                        self.tip_password?.text = "用户名可用"
                        self.tip_password?.textColor = UIColor.greenColor()
                        self.OK = true
                    }
                    
                }catch let erro{
                    
                    print("Something is worry with \(erro)")
                    
                }
                
            }
        }

    }
    
    func asynchronousPost(username:String,pass:String,pass2:String,name:String,phone:String,studentID:String,identify:String) {
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080//FSC/PControllerServlet?AC=parentReg", parameters: ["userName":username,"password":pass,"password_again":pass2,"name":name,"phone":phone,"studentID":studentID,"identify":identify])
            .response { request, response, data, error in
            if data != nil{
                do{
                    
                    let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
                    print(json)
                    let Error = json.objectForKey("Error") as! String
                    print(Error)
                    if Error != "" {
                        self.getIdentify()
                    }else{
                        self.performSegueWithIdentifier("returnIdentifier", sender: self)
                    }
                }catch let erro{
                    
                    print("Something is worry with \(erro)")
                    
                }

                
            }
        }
    }
    
    func getIdentify(){
        let g = Global()
        //let url:NSURL! = NSURL(string:"http://\(g.IP):8080/FSC/idCode.jsp")
        Alamofire.request(.POST, "http://\(g.IP):8080/FSC/idCode.jsp", parameters: nil)
            .response { request, response, data, error in
                if data != nil{
                 let newImage = UIImage(data: data!)
                self.identifyImage?.image = newImage
            }
        }

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.getIdentify()
        self.view.backgroundColor = UIColor(colorLiteralRed: 250/255, green: 250/255, blue:  250/255, alpha: 1)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        self.username?.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.username?.resignFirstResponder()
//        self.password?.resignFirstResponder()
//        self.password2?.resignFirstResponder()
//        self.phone?.resignFirstResponder()
//        self.name?.resignFirstResponder()
//        self.studentID?.resignFirstResponder()
//        self.identify?.resignFirstResponder()
//        
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
