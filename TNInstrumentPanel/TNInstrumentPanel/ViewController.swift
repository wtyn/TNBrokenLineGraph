//
//  ViewController.swift
//  TNInstrumentPanel
//
//  Created by wwy on 16/5/3.
//  Copyright © 2016年 wwy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let panelView = TNInstrumentPanelView()
        panelView.frame = CGRectMake(50, 50, 250, 250)
        panelView.backgroundColor = UIColor.blackColor()
        self.view.addSubview(panelView)
        panelView.maxValue = 123
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

