//
//  MeTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/24.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class MeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 2
        default:
            break
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableFooterView=UIView()
        if indexPath.section == 0{
        tableView.registerNib(UINib(nibName: "MyInformationTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MyInformationTableViewCell
            cell.Me_Info?.text = "家长姓名"
            cell.Me_Username?.text = "用户名：*******"
            let fullPath = ((NSHomeDirectory() as NSString) .stringByAppendingPathComponent("Documents") as NSString).stringByAppendingPathComponent("myicon.png")
            //可选绑定,若保存过用户头像则显示之
            if let savedImage = UIImage(contentsOfFile: fullPath){
                cell.Me_image!.image = savedImage
            }
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        
        }else if indexPath.section == 1{
            tableView.registerNib(UINib(nibName: "MeTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MeTableViewCell
            cell.Me_Name?.text = "学生信息"
            cell.Me_Detail?.hidden = true
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        }else{
           tableView.registerNib(UINib(nibName: "ButtonTableViewCell", bundle:nil),forCellReuseIdentifier: "cell1")
           let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! ButtonTableViewCell
            if indexPath.row == 1{
            cell.Button_Info?.text = "退出登录"
            cell.Button_Info?.textColor = UIColor.redColor()
            }else{
            cell.Button_Info?.text = "清除缓存"
            cell.Button_Info?.textColor = UIColor.greenColor()
            }
            cell.userInteractionEnabled = true
            cell.accessoryType=UITableViewCellAccessoryType.None
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return ""
        case 1:
            return " "
        case 2:
            return " "
        default:
            return ""
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0{
            let vc = storyboard?.instantiateViewControllerWithIdentifier("ImageIdentifier") as! ImageSelectViewController
            vc.navigationItem.title = "头像选择"
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.section == 2 && indexPath.row == 0{
//            let cache = Shared.imageCache
//            cache.removeAll()
//            let cache1 = Shared.dataCache
//            cache1.removeAll()
//            let cache2 = Shared.JSONCache
//            cache2.removeAll()
//            let cache3 = Shared.stringCache
//            cache3.removeAll()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 80
        }else{
            return 40
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
