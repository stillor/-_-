//
//  StudentTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/22.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import Alamofire

class StudentTableViewController: UITableViewController {
    
    //@IBOutlet var seg:UISegmentedControl?
    let it = ["到勤","作业","成绩","奖罚"]
    var score = [""]
    var homework_chinese = ""
    var homework_math = ""
    var homework_english = ""
    var attendance = ["","",""]
    var reward = [""]
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
        
        self.navigationController?.navigationBar.barTintColor=UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navigationTitleAttribute: NSDictionary = NSDictionary(object: UIColor.whiteColor(), forKey: NSForegroundColorAttributeName)
        
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
        let customFont = UIFont(name: "heiti SC", size: 13.0)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        getScore()
        getOthers()
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        //getScore()
        //getOthers()
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
            return score.count
            }else{
            return 1
            }
        }else if segment?.selectedSegmentIndex == 3 && section == 0{
            return reward.count
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
             cell.Student_info?.text = " "
             cell.Student_detail?.text = self.attendance[indexPath.row]
            cell.userInteractionEnabled = false
             cell.Student_detail?.hidden = false
            cell.accessoryType = UITableViewCellAccessoryType.None
            }else{
             cell.Student_detail?.hidden = true
             cell.Student_detail?.hidden = true
             cell.Student_info?.text = "历史到勤"
             cell.userInteractionEnabled = true
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
            if score[0] == ""{
              cell.userInteractionEnabled = false
            }else{
            cell.Student_center?.hidden = true
            cell.Student_detail?.hidden = true
            cell.Student_info?.hidden = false
            if indexPath.section == 0{
            cell.Student_info?.text = score[indexPath.row]
            }else{
            cell.Student_info?.text = "历史成绩图示"
            }
            cell.userInteractionEnabled = true
            }
            
        }else{
            cell.Student_center?.hidden = true
            cell.Student_detail?.hidden = true
            cell.Student_info?.hidden = false
            cell.userInteractionEnabled = true
            switch indexPath.section{
            case 0:
                if reward[0] == ""{
                    cell.userInteractionEnabled = false
                }else{
                cell.Student_info?.text = reward[indexPath.row]
                cell.userInteractionEnabled = false
                cell.accessoryType = UITableViewCellAccessoryType.None
                }
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
            if homework_chinese == ""{
                homework_chinese = "今日无作业"
            }else if homework_math == ""{
                homework_math = "今日无作业"
            }else if homework_english == ""{
                homework_math = "今日无作业"
            }
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
                vc.exam = score[indexPath.row]
                vc.navigationItem.title = score[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            }else {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("ChatIdentifier") as! ChatTableViewController
                vc.navigationItem.title = "历史成绩图示"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case 3:
            if indexPath.section == 1{
            let vc = storyboard?.instantiateViewControllerWithIdentifier("RewardIdentifier") as! RewardTableViewController
            vc.navigationItem.title = "历史奖罚情况"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        default:
            break
        }
//        let vc =       storyboard?.instantiateViewControllerWithIdentifier("DetailIdentifier") as! DetailTableViewController
        
    
    }
    
    func getScore(){
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080/FSC/ParentServlet?AC=getScoreTypeJSON", parameters: nil)
            .response { request, response, data, error in
            if data != nil{
            do{
            let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
            if let scoreType = json.objectForKey("scoreType"){
            for var i = 0; i < scoreType.count; i+=1 {
                if i == 0{
                self.score[0] = scoreType.objectAtIndex(i).objectForKey("type") as! String
                }else{
                self.score.append(scoreType.objectAtIndex(i).objectForKey("type") as! String)
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
    
    func getOthers(){
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080/FSC/ParentServlet?AC=getSign_eward_homeworkJSON", parameters: nil)
            .response { request, response, data, error in
            if data != nil{
            do{
            let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
            if let sign = json.objectForKey("sign"){
            self.attendance[0] = sign.objectAtIndex(0).objectForKey("moring") as! String
            self.attendance[1] = sign.objectAtIndex(0).objectForKey("afternoon") as! String

            self.attendance[2] = sign.objectAtIndex(0).objectForKey("evening")as! String
            }
            if let reward = json.objectForKey("reward"){
                for var i = 0;i < reward.count; i+=1{
                    if i == 0 {
                        self.reward[i] = reward.objectAtIndex(i).objectForKey("reward") as! String
                    }else{
                      self.reward.append(reward.objectAtIndex(i).objectForKey("reward") as! String)
                    }
                }
                }
            if let homework = json.objectForKey("homework"){
            self.homework_chinese = homework.objectAtIndex(0).objectForKey("content") as! String
             self.homework_math = homework.objectAtIndex(1).objectForKey("content") as! String
             self.homework_english = homework.objectAtIndex(2).objectForKey("content") as! String
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
