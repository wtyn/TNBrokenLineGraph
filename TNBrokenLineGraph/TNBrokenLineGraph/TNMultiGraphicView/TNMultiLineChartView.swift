//
//  TNMultiGraphicView.swift
//  TNBrokenLineGraph
//
//  Created by wwy on 16/4/2.
//  Copyright © 2016年 wwy. All rights reserved.
//

// 该代理方法可以设置x轴的值
@objc protocol TNMultiLineChartViewDelegate: NSObjectProtocol {
    optional   func setXAxisValuesShow(view: TNMultiLineChartView) ->([NSString]) // 注意,数组个数比x轴的值个数多1
    optional   func setXValuePointShow(view: TNMultiLineChartView) ->([[NSString]])
}


import UIKit

class TNMultiLineChartView: UIScrollView {

    
    // x轴坐标的个数
    var xValueCount: Int = 3
    // y轴坐标的个数
    var yValueCount: Int = 10
    
    // x,y 最大坐标值
    var xMaxValue: CGFloat = 0.0
    var yMaxValue: CGFloat = 0.0
    
    // 单位
    var xAxisUnit: NSString?
    var yAxisUnit: NSString?
    

    

    
    // 绘制线的模型
    var brokenLineModelArr: NSArray = []
        
    
    // 代理
    weak var multiLineChartViewDelegate: TNMultiLineChartViewDelegate?
    
    // 动画显示时长,默认为1.5秒
    var annimationDuration: Double = 1.5
    
    // 是否显示值
    var showValues: Bool = false // 默认不显示
    
    
    var _brokenLineGraphView: TNMultiLineChartContentView!
    

    
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.addBrokenLineGraphView()
    }
    
    
    // 添加绘制的视图
    func addBrokenLineGraphView() -> Void {
       

        var contentWidth = self.contentSize.width - 10
        if contentWidth < 10 {
            contentWidth = self.bounds.size.width - 10
        }
        let brokenLineGraphViewFrame = CGRectMake(0, 0,contentWidth, self.bounds.size.height)
       
        if _brokenLineGraphView == nil {
            _brokenLineGraphView = TNMultiLineChartContentView(frame: brokenLineGraphViewFrame)
            self.addSubview(_brokenLineGraphView)
        }else{
            _brokenLineGraphView.frame = brokenLineGraphViewFrame
        }
        
        _brokenLineGraphView.xValueCount = self.xValueCount
        _brokenLineGraphView.xMaxValue = self.xMaxValue
        _brokenLineGraphView.yValueCount = self.yValueCount
        _brokenLineGraphView.yMaxValue = self.yMaxValue
        _brokenLineGraphView.xAxisUnit = self.xAxisUnit
        _brokenLineGraphView.yAxisUnit = self.yAxisUnit
        _brokenLineGraphView.showValues = self.showValues
        if self.multiLineChartViewDelegate != nil {
            if  self.multiLineChartViewDelegate!.respondsToSelector("setXAxisValuesShow:"){
                _brokenLineGraphView.xAxisValuesArr = self.multiLineChartViewDelegate!.setXAxisValuesShow!(self)
            }
            
           if  self.multiLineChartViewDelegate!.respondsToSelector("setXValuePointShow:"){
                _brokenLineGraphView.xValuePointShowArr = self.multiLineChartViewDelegate!.setXValuePointShow!(self)
            }
            
        }
        _brokenLineGraphView.annimationDuration = self.annimationDuration
        _brokenLineGraphView.brokenLineModelArr = self.brokenLineModelArr as! [TNMultiLineChartContentModel]
        
        
    }
    
    
    //MARK: - 刷新视图
    func refreshGraphicView() -> Void {
         self.addBrokenLineGraphView()
    }
    
    deinit{
        print("内存释放了1111")
    }
    
}
