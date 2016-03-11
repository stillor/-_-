//
//  CommunicationTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/22.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import Alamofire

class CommunicationTableViewController: UITableViewController {
    var Contacts = [teacher(userName: "", name: "", type: "", course: "")]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor=UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navigationTitleAttribute: NSDictionary = NSDictionary(object: UIColor.whiteColor(), forKey: NSForegroundColorAttributeName)
        
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
         let customFont = UIFont(name: "heiti SC", size: 13.0)
         UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)
         UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
         getTeacher()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
         //getTeacher()
    }
    
    func segmentChange(){
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Contacts.count
        }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableFooterView=UIView()
        tableView.registerNib(UINib(nibName: "CommunicationTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CommunicationTableViewCell
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        cell.Communication_name?.text = Contacts[indexPath.row].name
        if Contacts[indexPath.row].type == "0"{
            if Contacts[indexPath.row].course == "0"{
                cell.Communication_info?.text = "班主任(语文)"
            }else if Contacts[indexPath.row].course == "1"{
                cell.Communication_info?.text = "班主任(数学)"
            }else{
                cell.Communication_info?.text = "班主任(英语)"
            }
        }else{
            if Contacts[indexPath.row].course == "1"{
                cell.Communication_info?.text = "语文老师"
            }else if Contacts[indexPath.row].course == "1"{
                cell.Communication_info?.text = "数学老师"
            }else{
                cell.Communication_info?.text = "英语老师"
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "主要联系人："
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MessageIdentifier") as! MessageTableViewController
        vc.navigationItem.title = Contacts[indexPath.row].name
        vc.user = Contacts[indexPath.row].name
        if Contacts[indexPath.row].type == "0"{
            if Contacts[indexPath.row].course == "0"{
                vc.teacher = "班主任(语文)"
            }else if Contacts[indexPath.row].course == "1"{
                vc.teacher = "班主任(数学)"
            }else{
                vc.teacher = "班主任(英语)"
            }
        }else{
            if Contacts[indexPath.row].course == "1"{
                vc.teacher = "语文老师"
            }else if Contacts[indexPath.row].course == "1"{
                vc.teacher = "数学老师"
            }else{
                vc.teacher = "英语老师"
            }
        }
        vc.teacherID = self.Contacts[indexPath.row].userName

        self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
    
    func getTeacher(){
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080/FSC/ParentServlet?AC=getTeacherList", parameters: nil)
            .response { request, response, data, error in
                if data != nil{
            do{
                let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
                let teacherList = json.objectForKey("teacherList")
                for var i = 0; i<teacherList?.count;i+=1{
                    let um = teacherList?.objectAtIndex(i).objectForKey("userName") as! String
                    let n = teacherList?.objectAtIndex(i).objectForKey("name") as! String
                    let t = teacherList?.objectAtIndex(i).objectForKey("type") as! String
                    let c = teacherList?.objectAtIndex(i).objectForKey("course") as! String
                    let tea = teacher(userName: um, name: n, type: t, course: c)
                    if i == 0{
                        self.Contacts[0] = tea
                    }else{
                        self.Contacts.append(tea)
                    }
                }
                        
                    }catch let erro{
                        print("Something is worry with \(erro)")
                        
                    }
                    
                }
                self.tableView.reloadData()
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
