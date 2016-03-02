//
//  ChatTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/1.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import PNChartSwift

class ChatTableViewController: UITableViewController {
    
    let course = ["语文成绩","数学成绩","英语成绩"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Chat_cell", forIndexPath: indexPath)
        
        let ChineseLabel:UILabel = UILabel(frame: CGRectMake(0, 0, 320.0, 30))
        ChineseLabel.textColor = PNGreenColor
        ChineseLabel.font = UIFont(name: "Avenir-Medium", size:18.0)
        ChineseLabel.textAlignment = NSTextAlignment.Center
        ChineseLabel.text = course[indexPath.section]
        let ChineseChart:PNLineChart = PNLineChart(frame: CGRectMake(0, 35.0, 320, 200.0))
        ChineseChart.yLabelFormat = "%1.1f"
        ChineseChart.showLabel = true
        ChineseChart.backgroundColor = UIColor.clearColor()
        ChineseChart.xLabels = ["考试1","考试2","考试3","考试4","考试5","考试6","考试7"]
        ChineseChart.showCoordinateAxis = true
        //        lineChart.delegate = self
        // Line Chart Nr.1
        var ChineseArray: [CGFloat] = [80, 74, 90, 100, 99, 89, 100]
        let Chinesedata01:PNLineChartData = PNLineChartData()
        Chinesedata01.color = PNGreenColor
        Chinesedata01.itemCount = ChineseArray.count
        Chinesedata01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
        Chinesedata01.getData = ({(index: Int) -> PNLineChartDataItem in
            let yValue:CGFloat = ChineseArray[index]
            let item = PNLineChartDataItem(y: yValue)
            return item
        })
        
        ChineseChart.chartData = [Chinesedata01]
        ChineseChart.strokeChart()
        
        cell.addSubview(ChineseChart)
        cell.addSubview(ChineseLabel)
        return cell
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
