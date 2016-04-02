//
//  ViewController.swift
//  TNBrokenLineGraph
//
//  Created by wwy on 16/3/30.
//  Copyright © 2016年 wwy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var chartView: TNBrokenLineGraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.creatChartView()
      
    }
    
    
    func creatChartView() {
        
        chartView = TNBrokenLineGraphView(frame: CGRectMake(0, 50, self.view.bounds.width, 200))
        self.view.addSubview(chartView)
        
        chartView.xMaxValue = 8
        chartView.xValueCount = 16
        chartView.yMaxValue = 3
        chartView.yValueCount = 9
        
        let wid = 1
        // 三条线
        let line1 = TNBrokenLineGraphModel()
        line1.lineColor = UIColor.greenColor()
        line1.width = wid
        line1.valueArr = [CGPointMake(1, 0),CGPointMake(1,3)]
        
        
        let line2 = TNBrokenLineGraphModel()
        line2.lineColor = UIColor.redColor()
        line2.width = wid
        line2.valueArr = [CGPointMake(3, 0),CGPointMake(3, 3)]
        
        let line3 = TNBrokenLineGraphModel()
        line3.lineColor = UIColor.yellowColor()
        line3.width = wid
        line3.valueArr = [CGPointMake(5, 0),CGPointMake(5, 2)]
        
        let line4 = TNBrokenLineGraphModel()
        line4.lineColor = UIColor.orangeColor()
        line4.width = wid
        line4.valueArr = [CGPointMake(8, 0),CGPointMake(8, 3)]
        
        let lineArr = [line1,line2,line3,line4]
        chartView.brokenLineModelArr = lineArr

        
       let graphicView = TNMultiGraphicView(frame: CGRectMake(0, 64, 200, 200))
        graphicView.xMaxValue = 100
        graphicView.xValueCount = 10
        graphicView


        
    }

    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if chartView != nil {
            chartView.removeFromSuperview()
        }
        self.creatChartView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

