//
//  MessageDetailTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/2.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

let messageFontSize: CGFloat = 17
let toolBarMinHeight: CGFloat = 50

class MessageDetailTableViewController: UITableViewController,UITextViewDelegate {
    
    var theme:String?
    var content:String?
    var tit:String?
    var date:String?
    var teacher:String?
    var teacherID:String?
    
    var firstcell:MessageDetailTableViewCell?
    
    var toolBar: UIToolbar!
    var textView: UITextView!
    var sendButton: UIButton!
    var Message = [detail(author: "", receiver: "", time: "", content: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .Interactive
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        
        tableView.registerNib(UINib(nibName: "MessageDetailTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
        firstcell = tableView.dequeueReusableCellWithIdentifier("cell") as? MessageDetailTableViewCell

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        getMessage()
        
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl?.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func refreshData(){
        Message = [detail(author: "", receiver: "", time: "", content: "")]
        getMessage()
        self.refreshControl?.endRefreshing()
        
    }
    
    override func viewDidAppear(animated: Bool) {
         //getMessage()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        let userInfo = notification.userInfo as NSDictionary!
        let frameNew = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let insetNewBottom = tableView.convertRect(frameNew, fromView: nil).height
        let insetOld = tableView.contentInset
        let insetChange = insetNewBottom - insetOld.bottom
        let overflow = tableView.contentSize.height - (tableView.frame.height-insetOld.top-insetOld.bottom)
        
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animations: (() -> Void) = {
            if !(self.tableView.tracking || self.tableView.decelerating) {
                // 根据键盘位置调整Inset
                if overflow > 0 {
                    self.tableView.contentOffset.y += insetChange
                    if self.tableView.contentOffset.y < -insetOld.top {
                        self.tableView.contentOffset.y = -insetOld.top
                    }
                } else if insetChange > -overflow {
                    self.tableView.contentOffset.y += insetChange + overflow
                }
            }
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            UIView.animateWithDuration(duration, delay: 0, options: options, animations: animations, completion: nil)
        } else {
            animations()
        }
    }
    
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo = notification.userInfo as NSDictionary!
        let frameNew = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let insetNewBottom = tableView.convertRect(frameNew, fromView: nil).height
        
        //根据键盘高度设置Inset
        let contentOffsetY = tableView.contentOffset.y
        tableView.contentInset.bottom = insetNewBottom
        tableView.scrollIndicatorInsets.bottom = insetNewBottom
        // 优化，防止键盘消失后tableview有跳跃
        if self.tableView.tracking || self.tableView.decelerating {
            tableView.contentOffset.y = contentOffsetY
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var inputAccessoryView: UIView! {
        get {
            if toolBar == nil {
                
                toolBar = UIToolbar(frame: CGRectMake(0, 0, 0, toolBarMinHeight-0.5))
                
                textView = InputTextView(frame: CGRectZero)
                textView.backgroundColor = UIColor(white: 250/255, alpha: 1)
                textView.delegate = self
                textView.font = UIFont.systemFontOfSize(messageFontSize)
                textView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha:1).CGColor
                textView.layer.borderWidth = 0.5
                textView.layer.cornerRadius = 5
                //            textView.placeholder = "Message"
                textView.scrollsToTop = false
                textView.textContainerInset = UIEdgeInsetsMake(4, 3, 3, 3)
                toolBar.addSubview(textView)
                
                sendButton = UIButton(type: UIButtonType.Custom)
                sendButton.enabled = true
                sendButton.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
                sendButton.setTitle("发送", forState: .Normal)
                sendButton.setTitleColor(UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1), forState: .Disabled)
                sendButton.setTitleColor(UIColor(red: 0.05, green: 0.47, blue: 0.91, alpha: 1.0), forState: .Normal)
                sendButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                sendButton.addTarget(self, action: "sendAction", forControlEvents: UIControlEvents.TouchUpInside)
                toolBar.addSubview(sendButton)
                
                // Auto Layout allows `sendButton` to change width, e.g., for localization.
                textView.snp_makeConstraints{ (make) -> Void in
                    
                    make.left.equalTo(self.toolBar.snp_left).offset(8)
                    make.top.equalTo(self.toolBar.snp_top).offset(7.5)
                    make.right.equalTo(self.sendButton.snp_left).offset(-2)
                    make.bottom.equalTo(self.toolBar.snp_bottom).offset(-8)
                    
                    
                }
                sendButton.snp_makeConstraints{ (make) -> Void in
                    make.right.equalTo(self.toolBar.snp_right)
                    make.bottom.equalTo(self.toolBar.snp_bottom).offset(-4.5)
                    
                }
                
            }
            return toolBar
        }
    }
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    func sendAction(){
        sendMessage()
        self.textView.text = ""
        Message = [detail(author: "", receiver: "", time: "", content: "")]
        getMessage()
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1{
            return self.Message.count
        }else{
        return 1
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableFooterView=UIView()
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MessageDetailTableViewCell
        if indexPath.section == 0 {
        self.firstcell!.accessoryType=UITableViewCellAccessoryType.None
        firstcell!.MessageDetail_name?.text = self.tit
        firstcell!.MessageDetail_date?.text = self.date
        firstcell!.MessageDetail_detail?.text = self.content
        firstcell!.userInteractionEnabled = false
        return firstcell!
        }else{
            tableView.registerNib(UINib(nibName: "MessageResponseTableViewCell", bundle:nil),forCellReuseIdentifier: "cell1")
            let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! MessageResponseTableViewCell
            cell.accessoryType=UITableViewCellAccessoryType.None
            //let user = NSUserDefaults.standardUserDefaults().valueForKey("ParentUserName") as! String
            let name = NSUserDefaults.standardUserDefaults().valueForKey("ParentName") as! String
            
            if self.Message[indexPath.row].receiver != self.teacherID{
                cell.MessageResponse_name?.text = name
                let imagePosition = NSUserDefaults.standardUserDefaults().valueForKey("ImagePosition") as? String
                let g = Global()
                cell.MessageResponse_image!.kf_setImageWithURL(NSURL(string:"http://\(g.IP):8080\(imagePosition! as String)")!)
            }else{
             cell.MessageResponse_name?.text = self.teacher
            }
            cell.MessageResponse_date?.text = self.Message[indexPath.row].time
            cell.MessageResponse_info?.text = self.Message[indexPath.row].content
            
//            let fullPath = ((NSHomeDirectory() as NSString) .stringByAppendingPathComponent("Documents") as NSString).stringByAppendingPathComponent("myicon.png")
//            //可选绑定,若保存过用户头像则显示之
//            if let savedImage = UIImage(contentsOfFile: fullPath){
//                cell.MessageResponse_image!.image = savedImage
            //}
            cell.userInteractionEnabled = false
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
    
    func getMessage(){
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080/FSC/ParentServlet?AC=getMessageJSON", parameters: ["themeID":self.theme!])
            .response { request, response, data, error in
        if data != nil{
            do{
            let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
            let mess = json.objectForKey("message_detail")
                for var i = 0;i<mess?.count;i+=1{
                let a = mess?.objectAtIndex(i).objectForKey("authorUserName") as! String
                let r = mess?.objectAtIndex(i).objectForKey("receiverUserName") as! String
                let t = mess?.objectAtIndex(i).objectForKey("time") as! String
                let c = mess?.objectAtIndex(i).objectForKey("content") as! String
                let de = detail(author: a, receiver: r, time: t, content: c)
                    if i == 0{
                        self.Message[i] = de
                    }else{
                        self.Message.append(de)
                    }
                }
                
                
            }catch let erro{
            print("Something is worry with \(erro)")
                        
            }
        self.tableView.reloadData()
        }
        
      }

    }
    
    func sendMessage(){
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080/FSC/ParentServlet?AC=sendMessageJSON", parameters: ["themeID":self.theme!,"content":self.textView.text])
            .response { request, response, data, error in
                
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

class InputTextView: UITextView {
    
    
    
}
