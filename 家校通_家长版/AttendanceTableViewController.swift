//
//  AttendanceTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/23.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import Alamofire

class AttendanceTableViewController: UITableViewController {
    
    var Attendance = [attendance(date: "", morning: "", afternoon: "", evening: "")]
    override func viewDidLoad() {
        super.viewDidLoad()
        getAttendance()
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        //getAttendance()
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
        return Attendance.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableFooterView=UIView()
        tableView.registerNib(UINib(nibName: "AttendanceTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! AttendanceTableViewCell

            cell.Student_Attendance_Date?.text = self.Attendance[indexPath.row].date
            cell.Student_Attendance_Morning?.text = self.Attendance[indexPath.row].morning
            cell.Student_Attendance_Afternoon?.text = self.Attendance[indexPath.row].afternoon
            cell.Student_Attendance_Evening?.text = self.Attendance[indexPath.row].evening
        
        cell.userInteractionEnabled = false

        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func getAttendance(){
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080/FSC/ParentServlet?AC=getHistorySignJSON", parameters: nil)
            .response { request, response, data, error in
            if data != nil{
            do{
            let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)

            if let sign = json.objectForKey("history_sign"){
                for var i = 0; i < sign.count; i+=1{
                let d = sign.objectAtIndex(i).objectForKey("date") as! String
                let m = sign.objectAtIndex(i).objectForKey("morning") as! String
                let a = sign.objectAtIndex(i).objectForKey("afternoon") as! String
                let e = sign.objectAtIndex(i).objectForKey("evening") as! String
                let att = attendance(date: d, morning: m, afternoon: a, evening: e)
                    if i == 0{
                        self.Attendance[0] = att
                    }else{
                        self.Attendance.append(att)
                    }
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
