//
//  ScoreTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/23.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import Alamofire

class ScoreTableViewController: UITableViewController {
    
    var person = ["**"," "]
    var score = ["0","0","0"]
    var rank = ["0","0"]
    
    let person_name = ["姓名：","学号："]
    let score_name = ["语文：","数学：","英语："]
    let rank_name = ["班级排名：","年级排名："]
    var exam:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getScore()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        //self.getScore()
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
        if section == 0{
            return 2
        }else if section == 1{
            return 3
        }else{
            return 2
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableFooterView=UIView()
        tableView.registerNib(UINib(nibName: "ScoreTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ScoreTableViewCell
        cell.userInteractionEnabled = false
        switch indexPath.section {
        case 0:
            cell.Student_Score_Name?.text = person_name[indexPath.row]
            cell.Student_Score_Detail?.text = person[indexPath.row]
            break
        case 1:
            cell.Student_Score_Name?.text = score_name[indexPath.row]
            cell.Student_Score_Detail?.text = score[indexPath.row]
            break
        case 2:
            cell.Student_Score_Name?.text = rank_name[indexPath.row]
            cell.Student_Score_Detail?.text = rank[indexPath.row]
            break
        default:
            break
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "学生信息"
        case 1:
            return "科目成绩"
        case 2:
            return "排名"
        default:
            break
        }
        return ""
    }
    
    
    func getScore(){
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080/FSC/ParentServlet?AC=getScoreJSON", parameters: ["type":self.exam!])
            .response { request, response, data, error in
        if data != nil{
          do{
            let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
            self.person[0] = json.objectForKey("name") as! String
            self.person[1] = json.objectForKey("stu_num") as! String
            self.score[0] = json.objectForKey("Chinese") as! String
            self.score[1] = json.objectForKey("math") as! String
            self.score[2] = json.objectForKey("English") as! String
            self.rank[0] = json.objectForKey("class_rank") as! String
            self.rank[1] = json.objectForKey("grade_rank") as! String
            
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
