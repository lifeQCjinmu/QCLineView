//
//  ViewController.m
//  QCLineViewTest
//
//  Created by mac on 2018/1/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "QCLineView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
      [super viewDidLoad];
      // Do any additional setup after loading the view, typically from a nib.

      CGRect lineViewFrame = CGRectMake(50, 100, 250, 200);
      NSArray *xTitleList = @[@"周一", @"周二", @"周三"];
      NSArray *yTitleList = @[@"100",@"200", @"300",@"400",@"500"];
      NSArray *points = @[@[@"12", @"76"],@[@"67", @"100"],@[@"80", @"300"],@[@"165", @"530"],@[@"180", @"11"],@[@"210", @"389"],@[@"211", @"421"],@[@"268", @"321"],@[@"300", @"123"],@[@"333", @"456"],@[@"360", @"434"]];
      NSString *Xunit = @"";
      NSString *Yunit = @"cm";
     QCLineView *lineView = [QCLineView qcLineViewWithFrame:lineViewFrame IsKeepAxis:YES XTitleList:xTitleList YTitleList:yTitleList Points:points XUnit:Xunit YUnit:Yunit maxXValue:400.0 maxYValue:600.0 IsFilled:NO IsShade:NO];
      [self.view addSubview:lineView];

}


- (void)didReceiveMemoryWarning {
      [super didReceiveMemoryWarning];
      // Dispose of any resources that can be recreated.
}


@end
