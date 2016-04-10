# TNBrokenLineGraphView

折线图的使用说明:

一: 三个文件,但只需要使用两个类. 

  TNBrokenLineGraphView 和 TNMultiLineChartContentModel

二: TNBrokenLineGraphView的属性说明 

   属性说明:
 
   // 坐标系的设置
 
   (1) xValueCount x轴坐标的个数
 
   (2) yValueCount y轴坐标的个数
 
   (3) xMaxValue x轴的最大值
 
   (4) yMaxValue y轴的最大值
 
   (5) xAxisUnit x轴的单位
 
   (6) yAxisUnit y轴的单位
 
   // 内容属性
 
   (7) brokenLineModelArr 绘制线的模型数组,想绘制几条线,就需要几个模型.
 
   (8) multiLineChartViewDelegate 代理,实现,x轴显示的自定义和显示值得自定义
 
   (9) annimationDuration 动画显示折线的绘制时间
 
   (10) showValues 是否显示绘制点的值
 
 
 
三: TNMultiLineChartContentModel 绘制线模型说明
 
   属性说明:
  
   (1) titleStr 线的标题,将会显示在视图的左上方
  
   (2) lineColor 线的颜色
  
   (3) width 线宽
  
   (4) valueArr 线的值数组,是NSValue类型,需要先将x,y值转换成CGPonit,然后再转为NSValue类型
  

