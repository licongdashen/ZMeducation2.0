//
//  ZMBaseViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/12.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "ZMBaseViewController.h"

@implementation ZMBaseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,DEF_DEVICE_WIDTH, 64)];
    navView.backgroundColor = DEF_COLOR_RGB(123, 165, 238);
    [self.view addSubview:navView];
}

@end
