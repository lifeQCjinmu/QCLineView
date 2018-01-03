# QCLineView
折线图，可控制填充色、轴线、渐变、xy轴坐标单位和数据

/**
 QCLineView 折线图创建

 @param frame 位置
 @param isKeepAxis 是否保留轴线
 @param xTitleList x轴坐标表
 @param yTitleList y轴坐标表
 @param points 点数组
 @param Xunit x轴单位
 @param Yunit y轴单位
 @param maxX x轴最大值
 @param maxY y轴最大值
 @param isFilled 是否填充颜色
 @param isShade 填充颜色是否渐变
 @return 返回 QCLineView
 */
+ (QCLineView *)qcLineViewWithFrame:(CGRect)frame IsKeepAxis:(BOOL)isKeepAxis 
                XTitleList:(NSArray *)xTitleList YTitleList:(NSArray *)yTitleList 
                Points:(NSArray <NSArray<NSString *>*>*)points  
                XUnit:(NSString *)Xunit YUnit:(NSString *)Yunit 
                maxXValue:(CGFloat)maxX maxYValue:(CGFloat)maxY 
                IsFilled:(BOOL)isFilled IsShade:(BOOL)isShade
