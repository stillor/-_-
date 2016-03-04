//
//  AllTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/29.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class AllTableViewController: UITableViewController,CarouselBannerViewDelegate{
    
    var bannerView = CarouselBannerView()
    var imageSource = NSArray()
    var g = Global()
    let imagePosition = NSUserDefaults.standardUserDefaults().valueForKey("ImagePosition") as? String
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableFooterView=UIView()
//        tableView.registerNib(UINib(nibName: "AllTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! AllTableViewCell
        if indexPath.section == 0{
            tableView.registerNib(UINib(nibName: "AllTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! AllTableViewCell
            self.bannerView = CarouselBannerView.init(frame: CGRectMake(0, 0, 320, 160))
            cell.addSubview(self.bannerView)
            self.bannerView.bannerDelegate = self
            imageSource = NSArray.init(object: "")
            self.performSelector(Selector("fetchData"), withObject:nil, afterDelay: 0)
            return cell
        }else if indexPath.section == 1 {
            tableView.registerNib(UINib(nibName: "AllTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! AllTableViewCell
            cell.All_info?.text = "  "
            cell.All_info?.textColor = UIColor.blueColor()
            cell.userInteractionEnabled = false
            return cell
        }else{
            tableView.registerNib(UINib(nibName: "NewsTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! NewsTableViewCell
            cell.News_image?.backgroundColor = UIColor.grayColor()
            cell.News_name?.text = "EDG战队训练室探秘"
            cell.News_info?.text = "横看成岭侧成峰"
            cell.News_info?.textColor = UIColor.grayColor()
            cell.News_date?.text = "2016-2-21"
            cell.News_date?.textColor = UIColor.grayColor()
            cell.userInteractionEnabled = true
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 160
        }else if indexPath.section == 1 {
            return 30
        }else{
            return 65
        }
        }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 || section == 2{
            return  ""
        }
       return " "
    }
//    (NSURL(string:"http://\(g.IP):8080\(imagePosition! as String)")!)
    func fetchData(){ //获取图片信息
        imageSource = NSArray.init(objects: "http://\(g.IP):8080\(imagePosition! as String)","http://static.dmcdn.cn/cfs/2016/1/86cb20f1-ec19-451a-975c-9123a92b1b16.jpg","http://static.dmcdn.cn/cfs/2015/12/f1f88dd4-493f-43d0-9f67-a62c4ce70d54.jpg","http://pimg.damai.cn/perform/damai/NewIndexManagement/201601/e0cbde39ecc94a4986e9ed8f6b2767e8.jpg")
        //         imageSource = NSArray.init(object: "http://static.damai.cn/cfs/2015/12/1ab03ad9-fcab-4806-b2a9-56e111bcde1f.jpg")
        
        self.bannerView .reloadData()
    }
    func scrollView(toScrollView scrollView: CarouselBannerView, andImageAtIndex index: NSInteger, forImageView imageView: UIImageView) {
        
        imageView.kf_setImageWithURL(NSURL(string: imageSource.objectAtIndex(index) as! String)!, placeholderImage: UIImage.init(named: "banner_bgImage"))
    }
    
    func numberOfImageInScrollView(toScrollView scrollView: CarouselBannerView) -> Int {
        return imageSource.count
        
    }
    func  scrollView ( toScrollView scrollView : CarouselBannerView, didTappedImageAtIndex  index : NSInteger){
        print("点击\(index)")
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

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

//    
//    // Override to support rearranging the table view.
//    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//       
//
//    }
//    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
