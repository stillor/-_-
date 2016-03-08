//
//  ImageSelectViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/28.
//  Copyright © 2016年 stiller. All rights reserved.
//
import UIKit
import Alamofire

class ImageSelectViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet var icon:UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置头像圆角
        icon!.layer.cornerRadius = icon!.frame.width/2
        //设置遮盖额外部分,下面两句的意义及实现是相同的
        //icon.clipsToBounds = true
        icon!.layer.masksToBounds = true
        
        //为头像添加点击事件
        icon!.userInteractionEnabled=true
        let userIconActionGR = UITapGestureRecognizer()
        userIconActionGR.addTarget(self, action: Selector("selectIcon"))
        icon!.addGestureRecognizer(userIconActionGR)
        
        //从文件读取用户头像
        let fullPath = ((NSHomeDirectory() as NSString) .stringByAppendingPathComponent("Documents") as NSString).stringByAppendingPathComponent("myicon.png")
        //可选绑定,若保存过用户头像则显示之
        let g = Global()
        let imagePosition = NSUserDefaults.standardUserDefaults().valueForKey("ImagePosition") as? String
        self.icon?.kf_setImageWithURL(NSURL(string:"http://\(g.IP):8080\(imagePosition! as String)")!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectIcon(){
        let userIconAlert = UIAlertController(title: "请选择操作", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let chooseFromPhotoAlbum = UIAlertAction(title: "从相册选择", style: UIAlertActionStyle.Default, handler: funcChooseFromPhotoAlbum)
        userIconAlert.addAction(chooseFromPhotoAlbum)
        
        let chooseFromCamera = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default,handler:funcChooseFromCamera)
        userIconAlert.addAction(chooseFromCamera)
        
        let canelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel,handler: nil)
        userIconAlert.addAction(canelAction)
        
        self.presentViewController(userIconAlert, animated: true, completion: nil)
    }
    
    func funcChooseFromPhotoAlbum(avc:UIAlertAction) -> Void{
        let imagePicker = UIImagePickerController()
        //设置代理
        imagePicker.delegate = self
        //允许编辑
        imagePicker.allowsEditing = true
        //设置图片源
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        //模态弹出IamgePickerView
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func funcChooseFromCamera(avc:UIAlertAction) -> Void{
        let imagePicker = UIImagePickerController()
        //设置代理
        imagePicker.delegate = self
        //允许编辑
        imagePicker.allowsEditing=true
        //设置图片源
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        //模态弹出IamgePickerView
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
         //获得编辑后的图片
        let image = (info as NSDictionary).objectForKey(UIImagePickerControllerEditedImage)
        icon?.image = image as? UIImage

        self.saveImage(image as! UIImage, imageName: "myicon.png")
        let fullPath = ((NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents") as NSString).stringByAppendingPathComponent("myicon.png")
        //存储后拿出更新头像
        let savedImage = UIImage(contentsOfFile: fullPath)
        self.icon!.image=savedImage
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.upload(savedImage!)
    }
    func saveImage(currentImage:UIImage,imageName:String){
        var imageData = NSData()
        imageData = UIImageJPEGRepresentation(currentImage, 0.5)!
        // 获取沙盒目录
        let fullPath = ((NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents") as NSString).stringByAppendingPathComponent(imageName)
        // 将图片写入文件
        imageData.writeToFile(fullPath, atomically: false)
    }
    
    func upload(image:UIImage){
        let g = Global()
//        let fullPath = ((NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents") as NSString).stringByAppendingPathComponent("myicon.png")
//        var fileURL = NSURL(fileURLWithPath: fullPath)
////        let fileURL = NSBundle.mainBundle().URLForResource(, withExtension: "png")
//        Alamofire.upload(.POST, "http://\(g.IP):8080/FSC/ParentServlet?AC=imageUpload", file: fileURL)
        let data:NSData = UIImagePNGRepresentation(image)!
        let url:NSURL = NSURL(string: "http://\(g.IP):8080/FSC/ParentServlet?AC=imageUpload")!;
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url);
        request.HTTPMethod = "POST"
        let boundary = "=-------------="
        let contentType:String="multipart/form-data;boundary="+boundary
        request.addValue(contentType, forHTTPHeaderField:"Content-Type")
        let body=NSMutableData()
        body.appendData(NSString(format:"\r\n(boundary)\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Disposition:form-data;name=\"file1\";filename=\"myicon.png\"\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Type:application/octet-stream\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(data)
        body.appendData(NSString(format:"\r\n(boundary)").dataUsingEncoding(NSUTF8StringEncoding)!)
        request.HTTPBody = body
        let que=NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: que, completionHandler: {
            (response, data, error) ->Void in
            if (error != nil){
                print(error)
            }else{
                //Handle data in NSData type
                let tr:String=NSString(data:data!,encoding:NSUTF8StringEncoding)! as String
                print(tr)
                //在主线程中更新UI风火轮才停止
                dispatch_sync(dispatch_get_main_queue(), {
                    print("jahajahj")
                    //self.av.stopAnimating()
                    //self.lb.hidden=true
                    
                })
                
            }
        })
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
