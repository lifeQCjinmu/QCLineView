//
//  QCLineView.m
//  QCLineViewTest
//
//  Created by mac on 2018/1/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "QCLineView.h"
@interface QCLineView()

@property (nonatomic, strong)UIBezierPath *path;//!<
@property (nonatomic, strong)CAShapeLayer *shapelayer;//!<

@property (nonatomic, assign)CGFloat Xscale;//!<
@property (nonatomic, assign)CGFloat Yscale;//!<

//控制渐变色的属性
@property (nonatomic, assign)CGMutablePathRef mupath;//!<
@property (nonatomic, assign)CGContextRef gc;//!<


@end

static NSInteger YlabelWidth = 30;
static NSInteger YlabelHeight = 8;
static NSInteger YlabelLineSpace = 2;
static NSInteger XlabelLineSpace = 4;

@implementation QCLineView
+ (QCLineView *)qcLineViewWithFrame:(CGRect)frame IsKeepAxis:(BOOL)isKeepAxis XTitleList:(NSArray *)xTitleList YTitleList:(NSArray *)yTitleList Points:(NSArray <NSArray<NSString *>*>*)points  XUnit:(NSString *)Xunit YUnit:(NSString *)Yunit maxXValue:(CGFloat)maxX maxYValue:(CGFloat)maxY IsFilled:(BOOL)isFilled IsShade:(BOOL)isShade{
      QCLineView *lineView = [QCLineView qcLineViewWithFrame:frame IsKeepAxis:isKeepAxis XTitleList:xTitleList YTitleList:yTitleList Points:points XUnit:Xunit YUnit:Yunit maxXValue:maxX maxYValue:maxY];
      [lineView setAllPoints:points IsFilled:isFilled IsShade:isShade];
      return lineView;
      
}
+ (QCLineView *)qcLineViewWithFrame:(CGRect)frame IsKeepAxis:(BOOL)isKeepAxis XTitleList:(NSArray *)xTitleList YTitleList:(NSArray *)yTitleList Points:(NSArray <NSArray<NSString *>*>*)points  XUnit:(NSString *)Xunit YUnit:(NSString *)Yunit maxXValue:(CGFloat)maxX maxYValue:(CGFloat)maxY{
      QCLineView *lineView = [[QCLineView alloc]init];
      lineView.frame = frame;
      lineView.backgroundColor = KbackColor;

      lineView.path = [UIBezierPath bezierPath];
      lineView.shapelayer = [CAShapeLayer layer];
      lineView.shapelayer.strokeColor = kLineColor.CGColor;
      lineView.shapelayer.fillColor = kFillColor.CGColor;
      lineView.shapelayer.lineWidth = kLineWith;
      [lineView.layer addSublayer:lineView.shapelayer];

      UIGraphicsBeginImageContext(lineView.bounds.size);
      lineView.gc = UIGraphicsGetCurrentContext();
      //创建CGMutablePathRef
      lineView.mupath = CGPathCreateMutable();

      lineView.Xscale = (frame.size.width - YlabelWidth)/maxX;
      lineView.Yscale = (frame.size.height - YlabelHeight)/maxY;
      //是否保留轴线
      if(isKeepAxis){
            //坐标系及文字显示
            CGFloat XlabelHeight = YlabelHeight;
            UIFont  *Xfont = [UIFont systemFontOfSize:XlabelHeight];
            UIFont  *Yfont = [UIFont systemFontOfSize:YlabelHeight];
            CGFloat XLabelSpace = (frame.size.width-15)/(xTitleList.count+1);
            CGFloat YLabelSpace = (frame.size.height-XlabelHeight)/(yTitleList.count+1);

            //设置x轴
            UIView *xView = [[UIView alloc] initWithFrame:CGRectMake(YlabelWidth, frame.size.height-XlabelHeight, frame.size.width-YlabelWidth, kXlineWith)];
            xView.backgroundColor = [UIColor redColor];
            [lineView addSubview:xView];
            //设置y轴
            UIView *yView = [[UIView alloc] initWithFrame:CGRectMake(YlabelWidth, XlabelHeight, kYlineWith, frame.size.height-XlabelHeight*2)];
            yView.backgroundColor = [UIColor greenColor];
            [lineView addSubview:yView];
            //设置x轴坐标
            for (int a = 0; a < xTitleList.count; a++) {
                  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(YlabelWidth+XLabelSpace*a, frame.size.height-XlabelHeight+XlabelLineSpace, XLabelSpace, XlabelHeight-XlabelLineSpace)];
                  label.font = Xfont;
                  label.textAlignment = NSTextAlignmentRight;
                  label.textColor = kLabelTextColor;
                  label.text = [NSString stringWithFormat:@"%@%@", xTitleList[a], Xunit];
                  [lineView addSubview:label];
            }
            //设置y轴坐标
            for (int a = 0; a < yTitleList.count; a++) {
                  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-XlabelHeight-YLabelSpace*(a+1)-YlabelHeight/2, YlabelWidth-YlabelLineSpace, YlabelHeight)];
                  label.font = Yfont;
                  label.textAlignment = NSTextAlignmentRight;
                  label.textColor = kLabelTextColor;
                  label.text = [NSString stringWithFormat:@"%@%@", yTitleList[a], Yunit];
                  [lineView addSubview:label];
            }
      }

      return lineView;
}

- (void)setAllPoints:(NSArray <NSArray<NSString *>*>*)points IsFilled:(BOOL)isFilled IsShade:(BOOL)isShade{

      [points enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addNewPoint:obj IsFilled:isFilled];
      }];
      //是否填充颜色
      if (isFilled) {
            CGPoint point = CGPointMake(YlabelWidth+[points.lastObject.firstObject floatValue]*self.Xscale, self.frame.size.height-YlabelHeight);
            [self.path addLineToPoint:point];
            CGPathAddLineToPoint(self.mupath, NULL, point.x, point.y);
            //填充是否渐变
            if(isShade){
                  //绘制渐变
                  [self drawLinearGradient:self.gc path:self.mupath startColor:[UIColor whiteColor].CGColor endColor:kFillColor.CGColor];

                  //注意释放CGMutablePathRef
                  CGPathRelease(self.mupath);

                  //从Context中获取图像，并显示在界面上
                  UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
                  UIGraphicsEndImageContext();

                  UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
                  [self addSubview:imgView];

            }

      }
      self.shapelayer.path = self.path.CGPath;

}

- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
      CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
      CGFloat locations[] = { 0.0, 1.0 };

      NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];

      CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);


      CGRect pathRect = CGPathGetBoundingBox(path);

      //具体方向可根据需求修改
      CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
      CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));

      CGContextSaveGState(context);
      CGContextAddPath(context, path);
      CGContextClip(context);
      CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
      CGContextRestoreGState(context);
      CGGradientRelease(gradient);
      CGColorSpaceRelease(colorSpace);
}

- (void)addNewPoint:(NSArray<NSString *>*)newPoint IsFilled:(BOOL)isFilled{
      CGFloat x = [[newPoint firstObject] floatValue];
      CGFloat y = [[newPoint lastObject] floatValue];

      static dispatch_once_t onceToken;
      dispatch_once(&onceToken, ^{
            if (!isFilled) {
                  [self.path moveToPoint:CGPointMake(YlabelWidth+x*self.Xscale, self.frame.size.height-y*self.Yscale-YlabelHeight)];
            } else {
                  [self.path moveToPoint:CGPointMake(YlabelWidth+x*self.Xscale, self.frame.size.height-YlabelHeight)];
                  CGPathMoveToPoint(self.mupath, NULL, YlabelWidth+x*self.Xscale, self.frame.size.height-YlabelHeight);
            }
      });
      [self.path addLineToPoint:CGPointMake(YlabelWidth+x*self.Xscale, self.frame.size.height-y*self.Yscale-YlabelHeight)];
      CGPathAddLineToPoint(self.mupath, NULL, YlabelWidth+x*self.Xscale, self.frame.size.height-y*self.Yscale-YlabelHeight);

}
@end
