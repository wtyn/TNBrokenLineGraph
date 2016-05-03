//
//  TNBrokenLineGraphModel.swift
//  TNBrokenLineGraph
//
//  Created by wwy on 16/3/30.
//  Copyright © 2016年 wwy. All rights reserved.
//

import UIKit


// 折线的属性模型
class TNMultiLineChartContentModel: NSObject {

    var titleStr: NSString? //该线的标题
    var lineColor: UIColor = UIColor.blackColor() // 线条的颜色
    var valueArr: NSArray? // 线的值数组,存储点:[(10,20),(20,19)]
    var width: CGFloat = 1.0 // 线宽
    
    deinit{
       
    }

  
}
