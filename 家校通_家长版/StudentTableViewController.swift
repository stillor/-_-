//
//  StudentTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/22.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {
    
    //@IBOutlet var seg:UISegmentedControl?
    let it = ["到勤","作业","成绩","奖罚"]
    let score = ["第一学期期中考试","第一学期期末考试","第二学期期中考试","第二学期期末考试","历史成绩图示"]
    let homework_chinese = "阅读课后文章，第128页习题5，6，7题，日记"
    let homework_math = "第135页综合练习题1，2，3，4题"
    let homework_english = "英语作文，抄写第四单元单词"
    var segment:UISegmentedControl?
    override func viewDidLoad() {
        super.viewDidLoad()
        segment = UISegmentedControl(items: it)
        segment?.setWidth(70, forSegmentAtIndex: 0)
        segment?.setWidth(70, forSegmentAtIndex: 1)
        segment?.setWidth(70, forSegmentAtIndex: 2)
        segment?.setWidth(70, forSegmentAtIndex: 3)
        segment?.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment
        segment!.addTarget(self, action: "segmentChange", forControlEvents: UIControlEvents.ValueChanged)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: nil, action:nil)
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
        if segment?.selectedSegmentIndex == 0{
            return 4
        }else if segment?.selectedSegmentIndex == 1{
            return 3
        }else if segment?.selectedSegmentIndex == 2{
            return 2
        }else if segment?.selectedSegmentIndex == 3{
            return 2
        }
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if segment?.selectedSegmentIndex == 2{
            if section == 0{
            return 4
            }else{
            return 1
            }
        }else if segment?.selectedSegmentIndex == 3 && section == 0{
            return 4
        }
        
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableFooterView=UIView()
        tableView.registerNib(UINib(nibName: "StudentTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! StudentTableViewCell
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        if segment?.selectedSegmentIndex == 0 {
            cell.Student_center?.hidden = true
            cell.Student_info?.hidden = false
            cell.Student_detail?.hidden = false
            if indexPath.section != 3{
             cell.Student_info?.text = "霍勇博"
             cell.Student_detail?.text = "已到"
            cell.userInteractionEnabled = false
             cell.Student_detail?.hidden = false
            cell.accessoryType = UITableViewCellAccessoryType.None
            }else{
             cell.Student_detail?.hidden = true
             cell.Student_info?.text = "历史到勤"
            }
       // cell.userInteractionEnabled = false

         return cell
        }else if segment?.selectedSegmentIndex == 1{
            cell.userInteractionEnabled = true
            cell.Student_detail?.hidden = true
            cell.Student_info?.hidden = true
            cell.Student_center?.hidden = false
            cell.accessoryType = UITableViewCellAccessoryType.None
            switch indexPath.section{
            case 0:
                cell.Student_center?.text = "语文"
                break
            case 1:
                cell.Student_center?.text = "数学"
                break
            case 2:
                cell.Student_center?.text = "英语"
                break
            default:
                break
            }
            //cell.userInteractionEnabled = false

   
        }else if segment?.selectedSegmentIndex == 2{
            cell.Student_center?.hidden = true
            cell.Student_detail?.hidden = true
            cell.Student_info?.hidden = false
            if indexPath.section == 0{
            cell.Student_info?.text = score[indexPath.row]
            }else{
            cell.Student_info?.text = "历史成绩图示"
            }
            cell.userInteractionEnabled = true
            
        }else{
            cell.Student_center?.hidden = true
            cell.Student_detail?.hidden = true
            cell.Student_info?.hidden = false
            cell.userInteractionEnabled = true
            switch indexPath.section{
            case 0:
                cell.Student_info?.text = "上课说话，迟到"
                cell.userInteractionEnabled = false
                 cell.accessoryType = UITableViewCellAccessoryType.None
                break
            case 1:
                cell.Student_info?.text = "历史奖罚"
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                break
            default:
                break
                
            }
            //cell.userInteractionEnabled = false
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if segment?.selectedSegmentIndex == 1{
            if section == 0{
                return "科目："
            }
        }else if segment?.selectedSegmentIndex == 2{
            if section == 0{
                return "考试："
            }
        }else if segment?.selectedSegmentIndex == 0{
            switch section{
            case 0:
                return "早上："
            case 1:
                return "中午："
            case 2:
                return "晚上："
            default:
                break
            }
        }else if segment?.selectedSegmentIndex == 3{
            switch section{
            case 0:
                return "今日奖罚："
            default:
                break
            }
        }
        return " "
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let index = (segment?.selectedSegmentIndex)! as Int
        switch index{
        case 0:
            let vc = storyboard?.instantiateViewControllerWithIdentifier("AttendanceIdentifier") as! AttendanceTableViewController
                vc.navigationItem.title = "历史到勤"
            self.navigationController?.pushViewController(vc, animated: true)
           
            break
        case 1:
            //let vc = storyboard?.instantiateViewControllerWithIdentifier("HomeworkIdentifier") as! HomeworkTableViewController
            if indexPath.section == 0{
            //vc.navigationItem.title = "语文作业"
            SCLAlertView().showInfo("语文作业", subTitle: homework_chinese)
            }else if indexPath.section == 1{
            //vc.navigationItem.title = "数学作业"
             SCLAlertView().showInfo("数学作业", subTitle: homework_math)
            }else{
            //vc.navigationItem.title = "英语作业"
             SCLAlertView().showInfo("英语作业", subTitle: homework_english)
            }
            //self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            if indexPath.section == 0{
            let vc = storyboard?.instantiateViewControllerWithIdentifier("ScoreIdentifier") as! ScoreTableViewController
                vc.navigationItem.title = score[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            }else {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("ChatIdentifier") as! ChatTableViewController
                vc.navigationItem.title = "历史成绩图示"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        default:
            break
        }
//        let vc =       storyboard?.instantiateViewControllerWithIdentifier("DetailIdentifier") as! DetailTableViewController
        
    
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
