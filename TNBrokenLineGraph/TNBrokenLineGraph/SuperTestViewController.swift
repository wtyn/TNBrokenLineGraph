//
//  SuperTestViewController.swift
//  TNBrokenLineGraph
//
//  Created by wwy on 16/4/4.
//  Copyright © 2016年 wwy. All rights reserved.
//

import UIKit

class SuperTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        super.supportedInterfaceOrientations()
        return .LandscapeRight
    }
    
    override func shouldAutorotate() -> Bool {
        
        return true
    }
    

    
}
