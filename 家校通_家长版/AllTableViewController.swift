//
//  AllTableViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/29.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import Alamofire

class AllTableViewController: UITableViewController,CarouselBannerViewDelegate{
    
    var bannerView = CarouselBannerView()
    var imageSource = NSArray()
    var g = Global()
    //let imagePosition = NSUserDefaults.standardUserDefaults().valueForKey("ImagePosition") as? String
    
    var News:[news] = [news(url: "", name: "", brief: "", time: "")]
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.getStart()
        self.getNews()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let customFont = UIFont(name: "heiti SC", size: 13.0)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
         UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
         //self.getNews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
        return 1
        }else{
            return News.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableFooterView=UIView()
        if indexPath.section == 0{
            tableView.registerNib(UINib(nibName: "AllTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! AllTableViewCell
            self.bannerView = CarouselBannerView.init(frame: CGRectMake(0, 0, 390, 200))
            cell.addSubview(self.bannerView)
            self.bannerView.bannerDelegate = self
            imageSource = NSArray.init(object: "")
            self.performSelector(Selector("fetchData"), withObject:nil, afterDelay: 0)
            return cell
        }else{
            tableView.registerNib(UINib(nibName: "NewsTableViewCell", bundle:nil),forCellReuseIdentifier: "cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! NewsTableViewCell
           // cell.News_image?.backgroundColor = UIColor.grayColor()
        if self.News[0].name == ""{
            cell.News_name?.text = "无通知"
            cell.News_info?.hidden = true
            cell.News_image?.hidden = true
            cell.News_date?.hidden = true
            cell.userInteractionEnabled = false
        }else{
            cell.News_info?.hidden = false
            cell.News_image?.hidden = false
            cell.News_date?.hidden = false
        cell.News_image?.kf_setImageWithURL(NSURL(string:"http://\(self.g.IP):8080\(self.News[indexPath.row].url! as String)")!)
            cell.News_name?.text = self.News[indexPath.row].name
            cell.News_info?.text = self.News[indexPath.row].brief
            cell.News_info?.textColor = UIColor.grayColor()
            cell.News_date?.text = self.News[indexPath.row].time
            cell.News_date?.textColor = UIColor.grayColor()
            cell.userInteractionEnabled = true
            }
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 200
        }else{
            return 80
        }
        }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return  " "
        }
       return ""
    }
//    (NSURL(string:"http://\(g.IP):8080\(imagePosition! as String)")!)
    func fetchData(){ //获取图片信息
        imageSource = NSArray.init(objects: "http://\(g.IP):8080/FSC/data/1.jpg","http://\(g.IP):8080/FSC/data/2.jpg","http://\(g.IP):8080/FSC/data/3.jpg","http://\(g.IP):8080/FSC/data/4.jpg")
        
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

    func getNews(){
        let global = Global()
        Alamofire.request(.POST, "http://\(global.IP):8080/FSC/ParentServlet?AC=getNoticeListJSON", parameters: nil)
            .response { request, response, data, error in
                if data != nil{
                    do{
                        
                let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
                let briefnotice = json.objectForKey("briefnotice")
                for var i = 0; i < briefnotice?.count; i+=1 {
                
                let u = briefnotice!.objectAtIndex(i).objectForKey("url") as! String
                 
                let n = briefnotice!.objectAtIndex(i).objectForKey("notice_name") as! String
                 print(i+i+i)
                let b = briefnotice!.objectAtIndex(i).objectForKey("brief") as! String
                
                let t = briefnotice!.objectAtIndex(i).objectForKey("time") as! String
             
                let new = news(url: u, name: n, brief: b, time: t)
             
                    if i == 0{
                        self.News[0] = new
                    }else{
                        self.News.append(new)
                    }
                 }

                    }catch let erro{
                        
                        print("Something is worry with \(erro)")
                        
                    }
                    
                }
             self.tableView.reloadData()
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = storyboard?.instantiateViewControllerWithIdentifier("NewsIdentifier") as! NewsViewController
        vc.navigationItem.title = self.News[indexPath.row].name
        vc.tit = self.News[indexPath.row].name
        self.navigationController?.pushViewController(vc, animated: true)
        
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
