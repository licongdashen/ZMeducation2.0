//
//  SelectViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/20.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController ()

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backImav = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    backImav.image = DEF_IMAGE(@"sel_Bg");
    backImav.userInteractionEnabled = YES;
    [self.view addSubview:backImav];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
