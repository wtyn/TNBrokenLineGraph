//
//  ViewController.swift
//  TNBrokenLineGraph
//
//  Created by wwy on 16/3/30.
//  Copyright © 2016年 wwy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var chartView: TNMultiGraphicView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.creatChartView()
      
    }
    
    
    func creatChartView() {
        
        
        chartView = TNMultiGraphicView(frame: CGRectMake(0, 50, self.view.bounds.width, 200))
        chartView.contentSize = CGSizeMake(self.view.bounds.width * 3, 0)
        self.view.addSubview(chartView)
        
        
        chartView.xMaxValue = 8
        chartView.xValueCount = 8
        chartView.yMaxValue = 1000
        chartView.yValueCount = 10
        chartView.yAxisUnit = "元"
        chartView.xAxisUnit = "h/小时"
        chartView.annimationDuration = 4
        
        let wid = 1
        // 三条线
        let line1 = TNBrokenLineGraphModel()
        line1.lineColor = UIColor.greenColor()
        line1.width = 5
        line1.titleStr = "领导的工资"
        line1.valueArr = [CGPointMake(1, 800),CGPointMake(2,560),CGPointMake(3, 400),CGPointMake(4,250),CGPointMake(5, 100),CGPointMake(6,500),CGPointMake(7, 690),CGPointMake(8,1000)]
        
        
        let line2 = TNBrokenLineGraphModel()
        line2.lineColor = UIColor.redColor()
        line2.width = 3
        line2.titleStr = "技术工的工资"
        line2.valueArr = [CGPointMake(1, 600),CGPointMake(2,360),CGPointMake(3, 400),CGPointMake(4,750),CGPointMake(5, 100),CGPointMake(6,500),CGPointMake(7, 690),CGPointMake(8,1000)]
        
        let line3 = TNBrokenLineGraphModel()
        line3.lineColor = UIColor.purpleColor()
        line3.width = 2
        line3.titleStr = "销售人员的工资"
        line3.valueArr = [CGPointMake(1, 1000),CGPointMake(2,160),CGPointMake(3, 800),CGPointMake(4,50),CGPointMake(5, 500),CGPointMake(6,100),CGPointMake(7, 800),CGPointMake(8,1000)]
        
        let line4 = TNBrokenLineGraphModel()
        line4.lineColor = UIColor.orangeColor()
        line4.width = 1
        line4.titleStr = "普通员工的工资"
        line4.valueArr = [CGPointMake(1, 200),CGPointMake(2,260),CGPointMake(3, 300),CGPointMake(4,250),CGPointMake(5, 180),CGPointMake(6,160),CGPointMake(7, 300),CGPointMake(8,250)]
        
        let lineArr = [line1,line2,line3,line4]
        chartView.brokenLineModelArr = lineArr
        self.view.addSubview(chartView)

        
    }


    
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//        chartView.xMaxValue = 100
//        chartView.xValueCount = 10
//        chartView.yMaxValue = 3
//        chartView.yValueCount = 10
//        
//        chartView.yAxisUnit = "y轴的单位"
//        chartView.xAxisUnit = "x轴的单位"
//        chartView.annimationDuration = 4
//        let wid = 3
//        // 三条线
//        let line1 = TNBrokenLineGraphModel()
//        line1.lineColor = UIColor.greenColor()
//        line1.width = wid
//        line1.valueArr = [CGPointMake(1, 0),CGPointMake(3,3)]
//        
//        
////        let line2 = TNBrokenLineGraphModel()
////        line2.lineColor = UIColor.redColor()
////        line2.width = wid
////        line2.valueArr = [CGPointMake(3, 0),CGPointMake(6, 3)]
////        
////        let line3 = TNBrokenLineGraphModel()
////        line3.lineColor = UIColor.yellowColor()
////        line3.width = wid
////        line3.valueArr = [CGPointMake(5, 0),CGPointMake(8, 2)]
//        
//        let lineArr = [line1]
//        chartView.brokenLineModelArr = lineArr
//
//        
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

