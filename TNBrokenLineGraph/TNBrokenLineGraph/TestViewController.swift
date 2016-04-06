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
      
//        self.navigationController?.navigationBarHidden = true
        self.view.backgroundColor = UIColor.whiteColor()
        self.creatChartView()
        
        
        let btn = UIButton(type: .Custom)
        btn.frame = CGRectMake(50, 400, 80, 60)
        btn.backgroundColor = UIColor.redColor()
        btn.addTarget(self, action: #selector(ViewController.nextController(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)

        
    }

   
    func creatChartView() {
        
        print(self.view.bounds)
        
        chartView = TNMultiLineChartView(frame: CGRectMake(0,20,self.view.bounds.height , self.view.bounds.width -  20))
        chartView.contentSize = CGSizeMake(self.view.bounds.width * 3, 0)
        chartView.multiLineChartViewDelegate = self
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
        line1.valueArr = [NSValue(CGPoint: CGPointMake(0, 800)),NSValue(CGPoint: CGPointMake(2,560)),NSValue(CGPoint: CGPointMake(3, 400)),NSValue(CGPoint: CGPointMake(4,250)),NSValue(CGPoint: CGPointMake(5, 100)),NSValue(CGPoint: CGPointMake(6,500)),NSValue(CGPoint: CGPointMake(7, 690)),NSValue(CGPoint: CGPointMake(8,1000))]
        
//        
//        let line2 = TNMultiLineChartContentModel()
//        line2.lineColor = UIColor.redColor()
//        line2.width = 3
//        line2.titleStr = "技术工的工资"
//        line2.valueArr = [CGPointMake(1, 600),CGPointMake(2,360),CGPointMake(3, 400),CGPointMake(4,750),CGPointMake(5, 100),CGPointMake(6,500),CGPointMake(7, 690),CGPointMake(8,1000)]
        
        let lineArr = [line1]
        chartView.brokenLineModelArr = lineArr
        self.view.addSubview(chartView)
        
        
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        
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
    
    
    // 设置点的x值得显示
    func setXValuePointShow(view: TNMultiLineChartView) -> ([[NSString]]) {
    
        var arr: [[NSString]] = []
        for index in 0 ... view.brokenLineModelArr.count - 1{ // 折线的数量
            // 某一条折线的x轴的值
            var modelValueArr: [NSString] = []
            for i in 0 ... view.brokenLineModelArr[index].valueArr!!.count {
                let str = "12-\(i + 1)"
                modelValueArr.append(str)
            }
            arr.append(modelValueArr)
        }
        return arr
            
    }

    func nextController(sender: AnyObject) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    // 横屏和竖屏设置
//    // IOS6以后，屏幕旋转机制发生了重大改变，将原来各ViewController自己控制旋转改为了在RootVC中统一控制。如果你的RootVC是NavigationController，那就需要写个它的子类，你才能重写这三个旋转控制方法。在方法里，你都有办法知道当前旋转的是哪个Controller，然后做针对性的处理。
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        
//        return .LandscapeRight
//    }
//    
//    override func shouldAutorotate() -> Bool {
//        
//        return true
//    }
    
    
}
