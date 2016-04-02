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
    var brokenLineModelArr: [TNBrokenLineGraphModel] = []
    
    // x轴坐标的个数
    var xValueCount: Int = 3
    // y轴坐标的个数
    var yValueCount: Int = 10
    
    // x,y 最大坐标值
    var xMaxValue: CGFloat?
    var yMaxValue: CGFloat?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addBrokenLineGraphView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 添加绘制的视图
    func addBrokenLineGraphView() -> Void {
        
        let brokenLineGraphViewFrame = CGRectMake(0, 0,self.contentSize.width, self.bounds.size.height)
        print("滚动区域",brokenLineGraphViewFrame)
        let brokenLineGraphView = TNBrokenLineGraphView(frame: brokenLineGraphViewFrame)
        brokenLineGraphView.brokenLineModelArr = self.brokenLineModelArr
        brokenLineGraphView.xValueCount = xValueCount
        brokenLineGraphView.xMaxValue = xMaxValue
        brokenLineGraphView.yValueCount = yValueCount
        brokenLineGraphView.yMaxValue = yMaxValue
        self.addSubview(brokenLineGraphView)
    }
    
    override func layoutSubviews() {
        
    }
    
   
}
