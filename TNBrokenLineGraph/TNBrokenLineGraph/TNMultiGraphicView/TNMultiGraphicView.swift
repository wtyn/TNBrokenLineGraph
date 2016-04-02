//
//  TNMultiGraphicView.swift
//  TNBrokenLineGraph
//
//  Created by wwy on 16/4/2.
//  Copyright © 2016年 wwy. All rights reserved.
//

import UIKit

class TNMultiGraphicView: UIScrollView {

    
    // 绘制线的模型
    var _brokenLineModelArr: [TNBrokenLineGraphModel] = []
    var brokenLineModelArr: [TNBrokenLineGraphModel] {
        get{
            return _brokenLineModelArr
        }
        
        set {
            _brokenLineModelArr = newValue
            if _brokenLineGraphView != nil {
                
                self.addBrokenLineGraphView()
            }
            
        }
    }
    
    // 动画显示时长,默认为1.5秒
    var annimationDuration: Double?
    
    // 单位
    var xAxisUnit: NSString?
    var yAxisUnit: NSString?


    // x轴坐标的个数
    var xValueCount: Int = 3
    // y轴坐标的个数
    var yValueCount: Int = 10
    
    // x,y 最大坐标值
    var xMaxValue: CGFloat?
    var yMaxValue: CGFloat?
    
    
    var _brokenLineGraphView: TNBrokenLineGraphView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
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
            _brokenLineGraphView = TNBrokenLineGraphView(frame: brokenLineGraphViewFrame)
            self.addSubview(_brokenLineGraphView)
        }else{
            _brokenLineGraphView.frame = brokenLineGraphViewFrame
        }
        _brokenLineGraphView.brokenLineModelArr = self.brokenLineModelArr
        _brokenLineGraphView.xValueCount = self.xValueCount
        _brokenLineGraphView.xMaxValue = self.xMaxValue
        _brokenLineGraphView.yValueCount = self.yValueCount
        _brokenLineGraphView.yMaxValue = self.yMaxValue
        _brokenLineGraphView.xAxisUnit = self.xAxisUnit
        _brokenLineGraphView.yAxisUnit = self.yAxisUnit
        if self.annimationDuration != nil {
            _brokenLineGraphView.annimationDuration = self.annimationDuration
        }else{
             _brokenLineGraphView.annimationDuration = 1.5
        }
        _brokenLineGraphView.brokenLineModelArr = self.brokenLineModelArr
        
        
    }
    
    
    
}
