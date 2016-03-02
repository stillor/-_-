//
//  MessageDetailTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/2.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class MessageDetailTableViewController: UITableViewController {
    var firstcell:MessageDetailTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "MessageDetailTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
        firstcell = tableView.dequeueReusableCellWithIdentifier("cell") as? MessageDetailTableViewCell
        firstcell?.MessageDetail_button?.addTarget(self, action: "Buttonpress", forControlEvents: UIControlEvents.TouchDown)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func Buttonpress(){
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MessageDetailIdentifier") as! MessageDetailViewController
        vc.navigationItem.title = "回复"
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableFooterView=UIView()
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MessageDetailTableViewCell
        if indexPath.section == 0 {
        self.firstcell!.accessoryType=UITableViewCellAccessoryType.None
        firstcell!.MessageDetail_name?.text = "西北大学附属中学三年级五班"
        firstcell!.MessageDetail_date?.text = "2016-02-21"
        firstcell!.MessageDetail_detail?.text = "啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        return firstcell!
        }else{
            tableView.registerNib(UINib(nibName: "MessageResponseTableViewCell", bundle:nil),forCellReuseIdentifier: "cell1")
            let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! MessageResponseTableViewCell
            cell.accessoryType=UITableViewCellAccessoryType.None
            cell.MessageResponse_name?.text = "霍勇博"
            cell.MessageResponse_date?.text = "2016-02-21"
            cell.MessageResponse_info?.text = "谢谢"
            let fullPath = ((NSHomeDirectory() as NSString) .stringByAppendingPathComponent("Documents") as NSString).stringByAppendingPathComponent("myicon.png")
            //可选绑定,若保存过用户头像则显示之
            if let savedImage = UIImage(contentsOfFile: fullPath){
                cell.MessageResponse_image!.image = savedImage
            }

            return cell
        }
            }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return  (firstcell?.frame.size.height)!
        }else{
            return 90
        }
     }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return " "
        }else{
            return ""
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
        print("dianjijiji")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
