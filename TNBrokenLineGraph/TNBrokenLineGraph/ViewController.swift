//
//  ViewController.swift
//  TNBrokenLineGraph
//
//  Created by wwy on 16/3/30.
//  Copyright © 2016年 wwy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let chartView = TNBrokenLineGraphView(frame: CGRectMake(20, 50, 300, 200))
        self.view.addSubview(chartView)

      
        
        print("改了代码,你能看到吗")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

