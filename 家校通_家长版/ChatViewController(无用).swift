//
//  ChatViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/3/1.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import PNChartSwift

class ChatViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.frame.size.height = 1800.0
       // showChat()
//        let ChartLabel:UILabel = UILabel(frame: CGRectMake(0, 90, 320.0, 30))
//        ChartLabel.textColor = PNGreenColor
//        ChartLabel.font = UIFont(name: "Avenir-Medium", size:18.0)
//        ChartLabel.textAlignment = NSTextAlignment.Center
//        ChartLabel.text = "语文成绩"
//        let lineChart:PNLineChart = PNLineChart(frame: CGRectMake(0, 135.0, 320, 200.0))
//        lineChart.yLabelFormat = "%1.1f"
//        lineChart.showLabel = true
//        lineChart.backgroundColor = UIColor.clearColor()
//        lineChart.xLabels = ["考试1","考试2","考试3","考试4","考试5","考试6","考试7"]
//        lineChart.showCoordinateAxis = true
////        lineChart.delegate = self
//        // Line Chart Nr.1
//        var data01Array: [CGFloat] = [80, 74, 90, 100, 99, 89, 100]
//        let data01:PNLineChartData = PNLineChartData()
//        data01.color = PNGreenColor
//        data01.itemCount = data01Array.count
//        data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
//        data01.getData = ({(index: Int) -> PNLineChartDataItem in
//            let yValue:CGFloat = data01Array[index]
//            let item = PNLineChartDataItem(y: yValue)
//            return item
//        })
//        
//        lineChart.chartData = [data01]
//        lineChart.strokeChart()
//        self.view.addSubview(lineChart)
//        self.view.addSubview(ChartLabel)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showChat(){
        let ChineseLabel:UILabel = UILabel(frame: CGRectMake(0, 90, 320.0, 30))
        ChineseLabel.textColor = PNGreenColor
        ChineseLabel.font = UIFont(name: "Avenir-Medium", size:18.0)
        ChineseLabel.textAlignment = NSTextAlignment.Center
        ChineseLabel.text = "语文成绩"
        let ChineseChart:PNLineChart = PNLineChart(frame: CGRectMake(0, 135.0, 320, 200.0))
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
        self.view.addSubview(ChineseChart)
        self.view.addSubview(ChineseLabel)
        
        
        let MathLabel:UILabel = UILabel(frame: CGRectMake(0, 390, 320.0, 30))
        MathLabel.textColor = PNGreenColor
        MathLabel.font = UIFont(name: "Avenir-Medium", size:18.0)
        MathLabel.textAlignment = NSTextAlignment.Center
        MathLabel.text = "数学成绩"
        let MathChart:PNLineChart = PNLineChart(frame: CGRectMake(0, 435.0, 320, 600.0))
        MathChart.yLabelFormat = "%1.1f"
        MathChart.showLabel = true
        MathChart.backgroundColor = UIColor.clearColor()
        MathChart.xLabels = ["考试1","考试2","考试3","考试4","考试5","考试6","考试7"]
        MathChart.showCoordinateAxis = true
        //        lineChart.delegate = self
        // Line Chart Nr.1
        var MathArray: [CGFloat] = [90, 84, 95, 99, 92, 89, 100]
        let Mathdata01:PNLineChartData = PNLineChartData()
        Mathdata01.color = PNGreenColor
        Mathdata01.itemCount = MathArray.count
        Mathdata01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
        Mathdata01.getData = ({(index: Int) -> PNLineChartDataItem in
            let yValue:CGFloat = MathArray[index]
            let item = PNLineChartDataItem(y: yValue)
            return item
        })
        
        MathChart.chartData = [Mathdata01]
        MathChart.strokeChart()
        self.view.addSubview(MathChart)
        self.view.addSubview(MathLabel)

    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AllIdentifier", forIndexPath: indexPath)
        
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
