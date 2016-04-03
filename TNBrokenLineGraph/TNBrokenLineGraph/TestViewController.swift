//
//  TestViewController.swift
//  TNBrokenLineGraph
//
//  Created by wwy on 16/4/3.
//  Copyright © 2016年 wwy. All rights reserved.
//

import UIKit

class TestViewController: UIViewController,TNMultiLineChartViewDelegate {

    var chartView: TNMultiLineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationController?.navigationBarHidden = true
        self.view.backgroundColor = UIColor.whiteColor()
        self.creatChartView()
        
        
        let btn = UIButton(type: .Custom)
        btn.frame = CGRectMake(50, 400, 80, 60)
        btn.backgroundColor = UIColor.redColor()
        btn.addTarget(self, action: #selector(ViewController.nextController(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)

        
    }

   
    func creatChartView() {
        
        
        chartView = TNMultiLineChartView(frame: CGRectMake(0, 64, self.view.bounds.width, 200))
        chartView.contentSize = CGSizeMake(self.view.bounds.width * 3, 0)
        chartView.setXAxisValuesDelegate = self
        chartView.xMaxValue = 8
        chartView.xValueCount = 8
        chartView.yMaxValue = 1000
        chartView.yValueCount = 10
        chartView.yAxisUnit = "元"
        chartView.xAxisUnit = "h/小时"
        chartView.annimationDuration = 4
        chartView.showValues = true
        
        // 三条线
        let line1 = TNMultiLineChartContentModel()
//        line1.lineColor = UIColor.greenColor()
        line1.width = 5
        line1.titleStr = "领导的工资"
        line1.valueArr = [CGPointMake(0, 800),CGPointMake(2,560),CGPointMake(3, 400),CGPointMake(4,250),CGPointMake(5, 100),CGPointMake(6,500),CGPointMake(7, 690),CGPointMake(8,1000)]
        
//        
//        let line2 = TNMultiLineChartContentModel()
//        line2.lineColor = UIColor.redColor()
//        line2.width = 3
//        line2.titleStr = "技术工的工资"
//        line2.valueArr = [CGPointMake(1, 600),CGPointMake(2,360),CGPointMake(3, 400),CGPointMake(4,750),CGPointMake(5, 100),CGPointMake(6,500),CGPointMake(7, 690),CGPointMake(8,1000)]
        
        let line3 = TNMultiLineChartContentModel()
        line3.lineColor = UIColor.purpleColor()
//        line3.width = 2
        line3.titleStr = "销售人员的工资"
        line3.valueArr = [CGPointMake(1, 1000),CGPointMake(2,160),CGPointMake(3, 800),CGPointMake(4,50),CGPointMake(5, 500),CGPointMake(6,100),CGPointMake(7, 800),CGPointMake(8,1000)]
        
        let line4 = TNMultiLineChartContentModel()
        line4.lineColor = UIColor.orangeColor()
        line4.width = 5
        line4.titleStr = "普通员工的工资"
        line4.valueArr = [CGPointMake(1, 200),CGPointMake(2,260),CGPointMake(3, 300),CGPointMake(4,250),CGPointMake(5, 180),CGPointMake(6,160),CGPointMake(7, 300),CGPointMake(8,250)]
        
        let lineArr = [line1,line3,line4]
        chartView.brokenLineModelArr = lineArr
        self.view.addSubview(chartView)
        
        
        
    }

    // 设置x轴显示的代理方法
    func setXAxisValuesShow(view: TNMultiLineChartView) -> ([NSString]) {
        var arr: [NSString] = []
        for i in 0 ... view.xValueCount {
            let str = "12-\(i + 1)"
            arr.append(str)
        }
        return arr
        
    }
    
    
//    // 设置点的x值得显示
//    func setXValuePointShow(view: TNMultiLineChartView) -> ([[NSString]]) {
//    
//        var arr: [[NSString]] = []
//        for index in 0 ... view.brokenLineModelArr.count - 1{ // 折线的数量
//            // 某一条折线的x轴的值
//            var modelValueArr: [NSString] = []
//            for i in 0 ... view.brokenLineModelArr[index].valueArr!.count {
//                let str = "12-\(i + 1)"
//                modelValueArr.append(str)
//            }
//            arr.append(modelValueArr)
//        }
//        return arr
//            
//    }

    func nextController(sender: AnyObject) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    
    
    
}
