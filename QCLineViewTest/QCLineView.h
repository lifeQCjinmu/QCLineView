//
//  QCLineView.h
//  QCLineViewTest
//
//  Created by mac on 2018/1/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kYLineColor [UIColor blackColor]
#define kXlineColor [UIColor blackColor]
#define kYlineWith 1.0
#define kXlineWith 1.0
#define kLabelTextColor [UIColor grayColor]

#define KbackColor [UIColor whiteColor]

#define kLineColor [UIColor blueColor]
#define kFillColor [UIColor redColor]  //不需要填充色 改为clearColor即可
#define kLineWith 1.0
@interface QCLineView : UIView

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
+ (QCLineView *)qcLineViewWithFrame:(CGRect)frame IsKeepAxis:(BOOL)isKeepAxis XTitleList:(NSArray *)xTitleList YTitleList:(NSArray *)yTitleList Points:(NSArray <NSArray<NSString *>*>*)points  XUnit:(NSString *)Xunit YUnit:(NSString *)Yunit maxXValue:(CGFloat)maxX maxYValue:(CGFloat)maxY IsFilled:(BOOL)isFilled IsShade:(BOOL)isShade;
@end
