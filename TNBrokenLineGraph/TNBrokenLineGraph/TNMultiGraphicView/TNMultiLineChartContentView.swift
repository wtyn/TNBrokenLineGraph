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

class TNMultiLineChartContentView: UIView {

    // 绘制线的模型
    var _brokenLineModelArr: [TNMultiLineChartContentModel] = []
    var brokenLineModelArr: [TNMultiLineChartContentModel] {
        get{
            return _brokenLineModelArr
        }
        
        set {
            _brokenLineModelArr = newValue
            self.setNeedsDisplay()
        }
    }
    
    
    // 单位
    var xAxisUnit: NSString?
    var yAxisUnit: NSString?

    // x轴的坐标值间距
    var xValueSpace: CGFloat!
    
    // 自定义x坐标值的显示
    var xAxisValuesArr: [NSString]?
    
    // 自定义折线点的x显示的值
    var xValuePointShowArr: [[NSString]]?
    
    
    // x轴坐标的个数
    var xValueCount: Int!
    // y轴坐标的个数
    var yValueCount: Int!
    
    
    // x,y 最大坐标值
    var xMaxValue: CGFloat!
    var yMaxValue: CGFloat!
    
    
    // 是否显示值
    var showValues: Bool = false // 默认不显示
    
    
    // 动画显示时长
    var annimationDuration: Double!
    
    //原点坐标
    var _zeroPoint: CGPoint!
    // 多余长度
    let _excessLength: CGFloat = 20.0
    var _xUnitValueLength: CGFloat!
    var _yUnitValueLength: CGFloat!
    
    
    // 储存图层,重绘时删除
    var _allLayerArr: [CAShapeLayer] = []

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
        super.drawRect(rect)
        
        if xMaxValue == nil  {
            return
        }
        
        if yMaxValue == nil {
            return
        }
       

        // 绘制坐标系
        self.drawCoordinate()
        
        // 添加单位
        self.addXAxisUnit()
        
        // 绘制折线
        self.drawBrokenLine()
        
        // 绘制单位 和颜色线的标识
        self.addIdentificationShow()
        
        print(self.bounds)
        print(_zeroPoint)

    }
    
    
    
    
    //MARK: - 绘制坐标系
    func drawCoordinate() {
        
        // 视图高度
        let height = self.bounds.size.height
        let width = self.bounds.size.width
        
        // 设置边距
        let xSpace: CGFloat = 20.0
        var ySpace: CGFloat = 40.0 // 需要重新设置
        
        
        let markerLineFont = UIFont.systemFontOfSize(10)
        let markerLineAttr = [NSFontAttributeName: markerLineFont]
        
        let xValueFont = UIFont.systemFontOfSize(12)
        let xValueAttr = [NSFontAttributeName: xValueFont]
        
        // 防止y值显示不全,重新设置 ySpace
        let yMaxValueStr = NSString(format: "%.1f", yMaxValue!)
        let yMaxValueSize = yMaxValueStr.boundingRectWithSize(CGSize(width: CGFloat(MAXFLOAT) , height:  CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: xValueAttr, context: nil)
        ySpace = yMaxValueSize.width + 10
        
        
        // 获得原点坐标
        // 最后一个值离端点为: 20
        _zeroPoint = CGPointMake(ySpace, height - xSpace - 20)
      
        // 绘制x轴和y轴
        // x轴
        UIGraphicsGetCurrentContext()
        let context = UIGraphicsGetCurrentContext()
        let xAxisPath = UIBezierPath()
        xAxisPath.moveToPoint(_zeroPoint)
        // x轴的终点坐标
        let xAxisMaxPoint = CGPointMake(width, _zeroPoint.y)
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
        _xUnitValueLength = (width - _excessLength - _zeroPoint.x) / CGFloat(xMaxValue!) // 单位长度
        
        for index in 0 ... xValueCount {
            // 分割线
            // 值
            let value = ( xMaxValue! / CGFloat(xValueCount)) * CGFloat(index)
            // 坐标
            let x = _zeroPoint.x + _xUnitValueLength * value
            
            if index != 0 {
                xMarkerLine.drawAtPoint(CGPointMake(x - 1.5, _zeroPoint.y - 13), withAttributes: markerLineAttr)
            }
            let xValueStr: NSString
            if self.xAxisValuesArr != nil {
                xValueStr = self.xAxisValuesArr![index]
            }else{
               xValueStr = NSString(format: "%.1f", value)
            }
            
            let xValueSize = xValueStr.boundingRectWithSize(CGSize(width: CGFloat(MAXFLOAT) , height:  CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: xValueAttr, context: nil)
            xValueStr.drawAtPoint(CGPoint(x: x - xValueSize.width / 2.0,y: _zeroPoint.y + 2), withAttributes: xValueAttr)
            
        }
        
        
        // y轴
        let yAxisPath = UIBezierPath()
        yAxisPath.moveToPoint(_zeroPoint)
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
        let yMarkLine: NSString = "—"
        _yUnitValueLength = (_zeroPoint.y - _excessLength) / yMaxValue!
        for index in 0 ... yValueCount  {
            // 分割线
            if index != 0 {
                
                let value = ( yMaxValue! / CGFloat(yValueCount)) * CGFloat(index)
                let y = _zeroPoint.y - _yUnitValueLength * value
               print(y)
               
                // 值
                let yValueStr = NSString(format: "%.1f",value)
                let yValueSize = yValueStr.boundingRectWithSize(CGSize(width: CGFloat(MAXFLOAT) , height:  CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: xValueAttr, context: nil)
                yValueStr.drawAtPoint(CGPoint(x: ySpace - yValueSize.width - 2,y: y - yValueSize.height / 2.0), withAttributes: xValueAttr)
                
                 yMarkLine.drawAtPoint(CGPointMake(ySpace + 3 ,y - yValueSize.height / 2.0), withAttributes: markerLineAttr)
                
            }
            
        }
        
    }
    
    
    // 单位
    func addXAxisUnit() {
        if self.xAxisUnit != nil {
            let font = UIFont.systemFontOfSize(14)
            let attr = [NSFontAttributeName: font]
            let xAxisUnitWidth = self.xAxisUnit!.boundingRectWithSize(CGSize(width: CGFloat(MAXFLOAT) , height:  CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr, context: nil).width
            self.xAxisUnit!.drawAtPoint(CGPointMake(self.bounds.size.width - xAxisUnitWidth - 5, _zeroPoint.y - 30), withAttributes: attr)
            
        }
        
    }
    
    
    
    // 折线
    func drawBrokenLine() {
        
        
        // 移除以前的折线
        if _allLayerArr.count > 0 {
            for anylayer in _allLayerArr {
                anylayer.removeFromSuperlayer()
            }
        }
        
        
        //MARK: - 绘制折线
        var modelIndex: Int = 0
        for lineModel in self.brokenLineModelArr {
            
            // 
            let valueFont = UIFont.systemFontOfSize(12.0)
            let valueAttr = [NSFontAttributeName: valueFont]
            let totalWid = self.bounds.width
            
            // 获得路径
            let funcLinePath = UIBezierPath()
            let firstPoint = self.getPointFromeValues(lineModel.valueArr![0])
            funcLinePath.moveToPoint(firstPoint)
            funcLinePath.lineCapStyle = .Round
            funcLinePath.lineJoinStyle = .Round
            
            var index: Int = 0
            var prevousValueY: CGFloat = 0.0
            
            for pointValue in lineModel.valueArr! {
                
                let point = self.getPointFromeValues(pointValue)
                if index != 0 {
                    funcLinePath.addLineToPoint(point)
                    funcLinePath.moveToPoint(point)
//                    funcLinePath.stroke()
                }
                
                // 绘制文字
                if self.showValues {
                    
                    // 绘制值
                    let valuePointStr: NSString
                    if self.xValuePointShowArr != nil {
                        valuePointStr = NSString(format: "(%@,%.1f)", self.xValuePointShowArr![modelIndex][index],pointValue.y)
                    }else{
                        valuePointStr = NSString(format: "(%.1f,%.1f)", pointValue.x,pointValue.y)
                    }
                    let valuePointStrSize = valuePointStr.boundingRectWithSize(CGSizeMake(CGFloat(MAXFLOAT), CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: valueAttr, context: nil)
                    let valuePointStrWid = valuePointStrSize.width
                
                    
                    // 判断值显示在折线的下面还是上面
                    var ySpace: CGFloat
                    if prevousValueY <=  pointValue.y {
                        ySpace = -15.0
                    }else{
                        ySpace = 0.0
                    }
                    
                    if (point.x + (valuePointStrWid / 2.0)) < totalWid - 5  {
                        valuePointStr.drawAtPoint(CGPointMake(point.x - (valuePointStrWid / 2.0), point.y + ySpace), withAttributes: valueAttr)
                    }else{
                        valuePointStr.drawAtPoint(CGPointMake(totalWid - valuePointStrWid - 5, point.y + ySpace), withAttributes: valueAttr)
                    }
                    
                    
                    // 绘制点
                    let onePoint: NSString  = "●"
                    let onePointColor = lineModel.lineColor
                    let onePointAtt: Dictionary<String,AnyObject> = [NSFontAttributeName: valueFont, NSForegroundColorAttributeName: onePointColor]
                    onePoint.drawAtPoint(CGPointMake(point.x - 4, point.y - 7 ), withAttributes: onePointAtt)
                    
                }
                prevousValueY = pointValue.y
                index =  index + 1
                
            }
            
           
            
            
    
            
            //创建CAShapLayer
            let lineLayer = self.setUpLineLayer(lineModel.lineColor, width: CGFloat(lineModel.width))
            lineLayer.path = funcLinePath.CGPath
            
            let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = self.annimationDuration
            pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            pathAnimation.fromValue = 0.0
            pathAnimation.toValue = 1.0
            pathAnimation.autoreverses = false
            lineLayer.addAnimation(pathAnimation, forKey: "lineLayerAnimation-\(index)")
            lineLayer.strokeEnd = 1.0
            self.layer.addSublayer(lineLayer)
            _allLayerArr.append(lineLayer)
            
            modelIndex = modelIndex + 1
            
        }
        
        
        

    }
    
    
    
    
    func setUpLineLayer(color: UIColor,width: CGFloat) ->CAShapeLayer{
        
        let lineLayer = CAShapeLayer()
        lineLayer.lineCap = kCALineCapRound
        lineLayer.lineJoin = kCALineJoinBevel // 斜角
        lineLayer.strokeEnd = 1
        lineLayer.strokeColor = color.CGColor
        lineLayer.lineWidth = width
        return lineLayer
        
    }
    
    
    
    // 线的标题显示
    func addIdentificationShow(){
        
        var maxTitleWidth: CGFloat = 0.0
        let titleFont = UIFont.systemFontOfSize(11)
        let attr = [NSFontAttributeName: titleFont]
        for lineModel in _brokenLineModelArr { // 获得标题的最大宽度
            
             if _brokenLineModelArr.count > 1 {
                
                if lineModel.titleStr != nil {
                    var titleStr: NSString
                    if self.yAxisUnit == nil {
                        titleStr = lineModel.titleStr!
                        
                    }else{
                        titleStr = NSString.init(format: "%@(%@)",lineModel.titleStr!,self.yAxisUnit!)
                    }

                    let titleSize = titleStr.boundingRectWithSize(CGSizeMake(CGFloat(MAXFLOAT), CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr, context: nil)
                    if titleSize.width > maxTitleWidth {
                        maxTitleWidth = titleSize.width
                    }
                    
                }

             }else{// 如果是一条线的话,只显示字体和单位
                var titleStr: NSString
                if self.yAxisUnit == nil { //没有单位
                    if lineModel.titleStr != nil { // 有标题
                        titleStr = lineModel.titleStr!
                        titleStr.drawAtPoint( CGPointMake(_zeroPoint.x + 15.0, 5 ) , withAttributes: attr)
                        return
                    }
                    
                }else  { // 有单位
                    if lineModel.titleStr != nil { // 有标题
                        titleStr = NSString.init(format: "%@(%@)",lineModel.titleStr!,self.yAxisUnit!)
                        titleStr.drawAtPoint( CGPointMake(_zeroPoint.x + 15.0, 5 ) , withAttributes: attr)
                        return
                    }else{ // 没有标题
                        self.yAxisUnit!.drawAtPoint( CGPointMake(_zeroPoint.x + 15.0, 5 ) , withAttributes: attr)
                        return
                    }
                    
              }
                
               
           }
            
        }
        // 添加标题和线
        let lineStr: NSString = "———"
        let lineFont = UIFont.boldSystemFontOfSize(17)
        var index = 0
        for lineModel in _brokenLineModelArr {
            
            if lineModel.titleStr != nil {
                var titleStr: NSString
                if self.yAxisUnit == nil {
                    titleStr = lineModel.titleStr!
                }else{
                    titleStr = NSString.init(format: "%@(%@)",lineModel.titleStr!,self.yAxisUnit!)
                }

                titleStr.drawAtPoint( CGPointMake(_zeroPoint.x + 15.0, 5 + CGFloat(index * 15)) , withAttributes: attr)
                
                let lineAttr: Dictionary<String,AnyObject> = [NSForegroundColorAttributeName: lineModel.lineColor , NSFontAttributeName: lineFont]
                lineStr.drawAtPoint(CGPointMake(maxTitleWidth + _zeroPoint.x + 20,  CGFloat(index * 15)), withAttributes: lineAttr)
            }
            index = index + 1
            
        }
   
    
        
    }
    
    
    //MARK: - 根据值,获得坐标
    func getPointFromeValues(xyValue: CGPoint) -> CGPoint {
        let x = xyValue.x * _xUnitValueLength + _zeroPoint.x
        let y = _zeroPoint.y - (xyValue.y * _yUnitValueLength)
        let point = CGPoint(x: x, y: y)
       
        return point
    }
    

    
    deinit{
        print("内存释放了2222")
    }

    
    

}
