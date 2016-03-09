//
//  LaunchViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/4.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import Alamofire

class LaunchViewController: UIViewController {
    @IBOutlet var sign:UIButton?
    @IBOutlet var log:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        let login = NSUserDefaults.standardUserDefaults().valueForKey("username")
        if login == nil{
            self.sign?.hidden = false
            self.log?.hidden = false

        }else {
            self.sign?.hidden = true
            self.log?.hidden = true
            self.login()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        let login = NSUserDefaults.standardUserDefaults().valueForKey("username")
        if login == nil{
        }else {
         self.login()
        }
    }
    
    func login(){
        let name = NSUserDefaults.standardUserDefaults().valueForKey("username")
        let pass = NSUserDefaults.standardUserDefaults().valueForKey("password")
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080/FSC/PControllerServlet?AC=parentLoginJSON", parameters: ["userName":name!,"password":pass!])
            .response { request, response, data, error in
            self.performSegueWithIdentifier("YeslogIdentifier", sender: self)
        }
        
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
