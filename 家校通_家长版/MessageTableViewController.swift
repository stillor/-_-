//
//  MessageTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/2.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import Alamofire

class MessageTableViewController: UITableViewController {
    var Message = [message(title: "", themeID: "", date: "", content: "")]
    var user:String?
    var teacher:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        getMessage()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
       // getMessage()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Message.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView.tableFooterView=UIView()
        tableView.registerNib(UINib(nibName: "MessageTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MessageTableViewCell
        if Message[0].title == ""{
           cell.Message_date?.hidden = true
           cell.Message_info?.hidden = true
           cell.Message_name?.text = "无消息"
           cell.userInteractionEnabled = false
        }else{
            cell.Message_date?.hidden = false
            cell.Message_info?.hidden = false
             cell.userInteractionEnabled = true
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        cell.Message_name?.text = Message[indexPath.row].title
        cell.Message_info?.text = Message[indexPath.row].content
        cell.Message_info?.textColor = UIColor.grayColor()
        cell.Message_date?.text = Message[indexPath.row].date
        cell.Message_date?.textColor = UIColor.grayColor()
        }
        return cell
    }
    
     override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MessageTableIdentifier") as! MessageDetailTableViewController
        vc.navigationItem.title = "具体内容"
        vc.theme = self.Message[indexPath.row].themeID
        vc.content = self.Message[indexPath.row].content
        vc.tit = self.Message[indexPath.row].title
        vc.date = self.Message[indexPath.row].date
        vc.teacher = self.teacher
        vc.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func getMessage(){
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080/FSC/ParentServlet?AC=getThemeListJSON", parameters: ["userName":self.user!])
            .response { request, response, data, error in
        if data != nil{
        do{
            let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
            let mess = json.objectForKey("message")
            for var i = 0;i<mess?.count;i+=1{
             let t = mess?.objectAtIndex(i).objectForKey("title") as! String
             let th = mess?.objectAtIndex(i).objectForKey("themeID") as! String
            let d = mess?.objectAtIndex(i).objectForKey("date") as! String
            let c = mess?.objectAtIndex(i).objectForKey("content") as! String
            let me = message(title: t, themeID: th, date: d, content: c)
                if i == 0{
                    self.Message[0] = me
                }else{
                    self.Message.append(me)
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
