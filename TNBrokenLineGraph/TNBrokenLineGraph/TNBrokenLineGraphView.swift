//
//  TNBrokenLineGraphView.swift
//  TNBrokenLineGraph
//
//  Created by wwy on 16/3/30.
//  Copyright © 2016年 wwy. All rights reserved.
//

enum TNXCoordinateValueShowType: Int {
    case linearValue =  0 // x坐标值是均匀的
    case valuesShow // 根据数据,将值显示在x轴上
}


import UIKit

class TNBrokenLineGraphView: UIView {

    // 绘制线的模型
    var brokenLineModelArr: [TNBrokenLineGraphModel] = []
    
    // x轴的坐标值间距
    var xValueSpace: CGFloat = 40.0
    
    
    // x轴坐标的个数
    var xValueCount: Int = 3
    // y轴坐标的个数
    var yValueCount: Int = 10
    
    // x,y 最大坐标值
    var xMaxValue: CGFloat?
    var yMaxValue: CGFloat?
    
    
    
    // 储存图层,重绘时删除
    var allLayerArr: [CAShapeLayer] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.xMaxValue = 100
        self.yMaxValue = 10_000
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - 重绘
    override func drawRect(rect: CGRect) {
        if xMaxValue == nil  {
            return
        }
        
        if yMaxValue == nil {
            return
        }
        self.drawCoordinate()
       
        if allLayerArr.count > 0 {
            for anylayer in allLayerArr {
                anylayer.removeFromSuperlayer()
            }
        }

        

    }
    
    
    
    
    //MARK: - 绘制坐标系
    func drawCoordinate() {
        
        // 视图高度
        let height = self.bounds.size.height
        let width = self.bounds.size.width
        
        // 设置边距
        let blankSpace: CGFloat = 15.0
        let xSpace: CGFloat = 20.0
        var ySpace: CGFloat = 40.0 // 需要重新设置
        
        
        let markerLineFont = UIFont.systemFontOfSize(10)
        let markerLineAttr = [NSFontAttributeName: markerLineFont]
        
        let xValueFont = UIFont.systemFontOfSize(12)
        let xValueAttr = [NSFontAttributeName: xValueFont]
        
        // 防止y值显示不全,重新设置 ySpace
        let yMaxValueStr = NSString(format: "%.1f", yMaxValue!)
        let yMaxValueSize = yMaxValueStr.boundingRectWithSize(CGSize(width: CGFloat(MAXFLOAT) , height:  CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: xValueAttr, context: nil)
        ySpace = yMaxValueSize.width
        
        
        // 获得原点坐标
        let zeroPoint = CGPointMake(ySpace, height - xSpace)
        // 绘制x轴和y轴
        // x轴
        UIGraphicsGetCurrentContext()
        let context = UIGraphicsGetCurrentContext()
        let xAxisPath = UIBezierPath()
        xAxisPath.moveToPoint(zeroPoint)
        // x轴的终点坐标
        let xAxisMaxPoint = CGPointMake(width, height - xSpace)
        xAxisPath.addLineToPoint(xAxisMaxPoint)
        CGContextAddPath(context, xAxisPath.CGPath)
        
        
        // 绘制x箭头
        let arrowAngle = CGFloat(M_PI / 6.0)
        let arrowLong: CGFloat = 10.0
        let xArrowPath = UIBezierPath()
        xArrowPath.moveToPoint(CGPointMake(xAxisMaxPoint.x - cos(arrowAngle) * arrowLong, xAxisMaxPoint.y - sin(arrowAngle) * arrowLong))
        xArrowPath.addLineToPoint(xAxisMaxPoint)
        xArrowPath.addLineToPoint(CGPointMake(xAxisMaxPoint.x - cos(arrowAngle) * arrowLong, xAxisMaxPoint.y + sin(arrowAngle) * arrowLong))
        CGContextAddPath(context, xArrowPath.CGPath)
        
        
        // 绘制x分割线
        let xMarkerLine: NSString = "|"
        let xValueSpace: CGFloat = (width - blankSpace - ySpace) / CGFloat(xValueCount)
        
        for index in 0 ... xValueCount {
            // 分割线
            if index != 0 {
                xMarkerLine.drawAtPoint(CGPointMake(CGFloat(index) * xValueSpace + ySpace, height - blankSpace - 20), withAttributes: markerLineAttr)
            }
            
            // 值
            let xValueStr = NSString(format: "%.1f", ( xMaxValue! / CGFloat(xValueCount)) * CGFloat(index))
            let xValueSize = xValueStr.boundingRectWithSize(CGSize(width: CGFloat(MAXFLOAT) , height:  CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: xValueAttr, context: nil)
            xValueStr.drawAtPoint(CGPoint(x: CGFloat(index) * xValueSpace + ySpace - xValueSize.width / 2.0,y: height - xSpace + 2), withAttributes: xValueAttr)
            
        }
        
        
        // y轴
        let yAxisPath = UIBezierPath()
        yAxisPath.moveToPoint(zeroPoint)
        //y轴的终点坐标
        let yAxisMaxPoint = CGPointMake(ySpace, 0)
        yAxisPath.addLineToPoint(yAxisMaxPoint)
        CGContextAddPath(context, yAxisPath.CGPath)
        
        // y箭头
        let yArrowPath = UIBezierPath()
        yArrowPath.moveToPoint(CGPointMake(ySpace - sin(arrowAngle) * arrowLong, cos(arrowAngle) * arrowLong))
        yArrowPath.addLineToPoint(CGPointMake(ySpace, 0))
        yArrowPath.addLineToPoint(CGPointMake(ySpace + sin(arrowAngle) * arrowLong, cos(arrowAngle) * arrowLong))
        CGContextAddPath(context, yArrowPath.CGPath)
        
        CGContextSetLineWidth(context, 1.0)
        CGContextStrokePath(context)
        
        // y分割线
        let yMarkLine: NSString = "-"
        let yValueSpace = (height - xSpace - blankSpace) / CGFloat(yValueCount)
        for index in 0 ... yValueCount  {
            // 分割线
            if index != 0 {
                yMarkLine.drawAtPoint(CGPointMake(ySpace + 2 , height - xSpace - CGFloat(index) * yValueSpace ), withAttributes: markerLineAttr)
                
                // 值
                let yValueStr = NSString(format: "%.1f", ( yMaxValue! / CGFloat(yValueCount)) * CGFloat(index))
                let yValueSize = yValueStr.boundingRectWithSize(CGSize(width: CGFloat(MAXFLOAT) , height:  CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: xValueAttr, context: nil)
                yValueStr.drawAtPoint(CGPoint(x: ySpace - yValueSize.width - 2,y: height - xSpace - CGFloat(index) * yValueSpace ), withAttributes: xValueAttr)
                
            }
            
        }
        
        
        
        
    }
    
    
    

}
