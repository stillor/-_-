//
//  PandectTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/26.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
//import MCMHeaderAnimated

class PandectTableViewController: UITableViewController {
    
    private let transitionManager = MCMHeaderAnimated()
    
    private var elements: NSArray! = []
    private var lastSelected: NSIndexPath! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: 200/255, green:  200/255, blue:  200/255, alpha: 1)
        self.elements = [
            ["color": UIColor(red: 25/255.0, green: 181/255.0, blue: 254/255.0, alpha: 1.0)],
            ["color": UIColor(red: 54/255.0, green: 215/255.0, blue: 183/255.0, alpha: 1.0)],
            ["color": UIColor(red: 210/255.0, green: 77/255.0, blue: 87/255.0, alpha: 1.0)],
            ["color": UIColor(red: 236/255.0, green: 236/255.0, blue: 236/255.0, alpha: 1.0)]
        ]
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
        return self.elements.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
         let cell = tableView.dequeueReusableCellWithIdentifier("Button_cell", forIndexPath: indexPath) as! Pandect_ButtonTableViewCell
            cell.backgroundColor = UIColor(red: 200/255, green:  200/255, blue:  200/255, alpha: 1)

        return cell
        }else {
        let cell = tableView.dequeueReusableCellWithIdentifier("Pandect_cell", forIndexPath: indexPath) as! PandectTableViewCell
        cell.info?.text = "我是通知，我是通知，我是通知"
        cell.background.layer.cornerRadius = 10;
        cell.background.clipsToBounds = true
        cell.header.backgroundColor = self.elements.objectAtIndex(indexPath.row).objectForKey("color") as? UIColor
        cell.backgroundColor = UIColor(red: 200/255, green:  200/255, blue:  200/255, alpha: 1)
        return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 50
        }else{
        return 120.0
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PandectIdentifier" {
            self.lastSelected = self.tableView.indexPathForSelectedRow
            let element = self.elements.objectAtIndex(self.tableView.indexPathForSelectedRow!.row)
            
            let destination = segue.destinationViewController as! PandectViewController
            destination.element = element as! NSDictionary
            destination.transitioningDelegate = self.transitionManager
            
            self.transitionManager.destinationViewController = destination
        }
    }
    
}

extension PandectTableViewController: MCMHeaderAnimatedDelegate {
    
    func headerView() -> UIView {
        // Selected cell
        let cell = self.tableView.cellForRowAtIndexPath(self.lastSelected) as! PandectTableViewCell
        return cell.header
    }
    
    func headerCopy(subview: UIView) -> UIView {
        let cell = tableView.cellForRowAtIndexPath(self.lastSelected) as! PandectTableViewCell
        let header = UIView(frame: cell.header.frame)
        header.backgroundColor = self.elements.objectAtIndex(self.lastSelected.row).objectForKey("color") as? UIColor
        return header
    }
    
}

