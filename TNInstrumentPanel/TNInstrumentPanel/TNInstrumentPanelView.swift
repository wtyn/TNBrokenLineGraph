//
//  TNInstrumentPanel.swift
//  TNInstrumentPanel
//
//  Created by wwy on 16/5/3.
//  Copyright © 2016年 wwy. All rights reserved.
//

import UIKit

class TNInstrumentPanelView: UIView {

    // 最大值
    var maxValue: CGFloat = 0.0
    
    
    // 半径
    var radius: CGFloat = 0.0
    let pieceAngle: CGFloat = CGFloat(M_PI * 2 / 5)
    
    
    override func drawRect(rect: CGRect) {
        radius = (self.bounds.size.width - 20) / 2.0
        self.drawPanelWithSize(rect.size)
        
        
    }
    
    // 绘制表盘
    func drawPanelWithSize(size: CGSize) {
        
        let ctx = UIGraphicsGetCurrentContext()
        
        // 四段,总共分为5段,只取其中的4端
        for index in 0 ..< 4{
            let path = self.drawArcWith(index)
             CGContextAddPath(ctx, path.CGPath)
             self.arcColorWith(index).set()
             CGContextSetLineWidth(ctx, 5.0)
             CGContextStrokePath(ctx)
            
            // 绘制刻度 和值
            self.drawScaleWith(index)
            
            
        }
       
        
        
    
        
        
    }
    
    
    // 绘制四段
    func drawArcWith(index: Int) ->UIBezierPath {
        // 每一块的弧度
        let startAngle = CGFloat((M_PI * 7) / 10 ) + pieceAngle * CGFloat(index)
        let endAngle = startAngle + pieceAngle
        let path = UIBezierPath.init(arcCenter:CGPointMake(radius + 10.0, radius + 10.0) , radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        return path
    }
    
    // 弧线的颜色
    func arcColorWith(index: Int) -> UIColor {
        switch index {
        case 0:
            return UIColor.init(red: 111 / 255.0, green: 199 / 255.0, blue: 79 / 255.0, alpha: 1)
        case 1,2:
            return UIColor.init(red: 52 / 255.0, green: 145 / 255.0, blue: 162 / 255.0, alpha: 1)
        case 3:
            return UIColor.init(red: 244 / 255.0, green: 26 / 255.0, blue: 59 / 255.0, alpha: 1)
            
        default:
            return UIColor.blackColor()
        }
    }
    
    // 绘制刻度
    // index 为第几模块
    func drawScaleWith(index: Int) {
        // 将每一块平分为5个刻度
        for i in 0 ..< 5 {
            self.drawOneScaleWith(index, one: i)
            if index == 3 { // 在末尾再添加个刻度
                self.drawOneScaleWith(index, one: 5)
            }
        }
        
        
    }
    
    // 画出某个部分的某个刻度
    func drawOneScaleWith(index: Int, one: Int) {
        
        let ctx = UIGraphicsGetCurrentContext()
        // 刻度的长度
        let scaleLong: CGFloat = 10.0
        // 修改开始刻度半径和颜色
        var radius2 = radius
        if one == 0 || one == 5 { // 修改刻度和颜色
            radius2 = radius + 2
            UIColor.whiteColor().set()
            CGContextSetLineWidth(ctx, 4.0)
        }else{
            self.arcColorWith(index).set()
            CGContextSetLineWidth(ctx, 2.0)
        }
        
        // 开始角度
        let startAngle =  CGFloat((M_PI * 7) / 10 ) + pieceAngle * CGFloat(index)
        // 每个刻度的角度
        let oneScaleAngle = startAngle + pieceAngle / 5.0 * CGFloat(one)
        // 绘制刻度
        let startPoint = CGPointMake(10 + radius + cos(oneScaleAngle) * radius2, 10 + radius + sin(oneScaleAngle) * radius2)
        let endPoint = CGPointMake(10 + radius + cos(oneScaleAngle) * (radius - scaleLong), 10 + radius + sin(oneScaleAngle) *  (radius - scaleLong))
    
        let path = UIBezierPath()
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        CGContextAddPath(ctx, path.CGPath)
        CGContextStrokePath(ctx)
        
        // 显示刻度的值
        if maxValue >= 0.0 {
            if one == 0 || one == 5 {
                
                let value = (maxValue / 20.0) * CGFloat(index * 5 + one)
                let valueStr: NSString = NSString.init(format: "%0.2f", value)
                let attr = [NSFontAttributeName: UIFont.systemFontOfSize(15.0), NSForegroundColorAttributeName: UIColor.whiteColor()]
                var drawPoint: CGPoint = endPoint
                
                switch index {
                case 0:
                    drawPoint = CGPointMake(endPoint.x - 10 , endPoint.y - 17.0)
                    
                case 1:
                    drawPoint = CGPointMake(endPoint.x , endPoint.y - 5.0)
                    
                case 2:
                    let size = valueStr.sizeWithAttributes(attr)
                    drawPoint = CGPointMake(endPoint.x - size.width / 2.0, endPoint.y)
                    
                case 3:
                    let size = valueStr.sizeWithAttributes(attr)
                    if one == 5 { // 最后一个刻度
                        drawPoint = CGPointMake(endPoint.x - size.width + 15, endPoint.y - 17.0)
                    }else{
                    
                        drawPoint = CGPointMake(endPoint.x - size.width, endPoint.y - 5.0)
                    }
                    

                default:
                    drawPoint = CGPointMake(0, 0)
                    
                }
                
                valueStr.drawAtPoint(drawPoint, withAttributes: attr)
            }
            
        }
       

    }
    
   

}
