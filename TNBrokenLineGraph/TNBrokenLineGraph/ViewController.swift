//
//  ViewController.swift
//  TNBrokenLineGraph
//
//  Created by wwy on 16/3/30.
//  Copyright © 2016年 wwy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet weak var multiLineChartView: TNMultiLineChartView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initChartView()
        
        
        
    }
    
    
   // 初始化折线视图
    func initChartView() {
        
        // 设置滚动区域大小
        self.multiLineChartView.contentSize = CGSize(width: 40 * 20, height: 0)
        
        //设置坐标系
        self.multiLineChartView.xValueCount = 20 // x轴的坐标个数
        self.multiLineChartView.xMaxValue = 200  // x轴的最大值
        self.multiLineChartView.yValueCount = 10 // y轴的坐标个数
        self.multiLineChartView.yMaxValue = 50 // y轴的最大值
        
        self.multiLineChartView.multiLineChartViewDelegate = nil
        
        
        // 设置x轴的单位
        self.multiLineChartView.xAxisUnit = "x的值"
        
    }
    
    
    
    

}

