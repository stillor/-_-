//
//  ViewController.swift
//  家校通_家长版
//
//  Created by stiller on 16/2/21.
//  Copyright © 2016年 stiller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var test:UILabel?
    @IBOutlet var seg:UISegmentedControl?
    
    func segmentChange(){
     
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        seg?.addTarget(self, action: "segmentChange", forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

