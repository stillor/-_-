//
//  PandectViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/26.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit
import MCMHeaderAnimated

class PandectViewController: UIViewController{
    
    var element: NSDictionary! = nil
    
    @IBOutlet weak var header: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.backgroundColor = self.element.objectForKey("color") as? UIColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension PandectViewController: MCMHeaderAnimatedDelegate {
    
    func headerView() -> UIView {
        // Selected cell
        return self.header
    }
    
    func headerCopy(subview: UIView) -> UIView {
        let headerN = UIView()
        headerN.backgroundColor = self.element.objectForKey("color") as? UIColor
        return headerN
    }
    
}
