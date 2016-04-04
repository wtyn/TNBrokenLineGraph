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

        
        self.view.backgroundColor = UIColor.whiteColor()
        let btn = UIButton(type: .Custom)
        btn.frame = CGRectMake(50, 100, 80, 60)
        btn.backgroundColor = UIColor.redColor()
        btn.addTarget(self, action: #selector(ViewController.nextController(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
    }
    
    
   

     func nextController(sender: AnyObject) {
//        self.navigationController?.pushViewController(TestViewController(), animated: true)
        self.presentViewController(TestViewController(), animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        super.supportedInterfaceOrientations()
        return .LandscapeRight
    }
    
    override func shouldAutorotate() -> Bool {
        
        return true
    }
    

}

