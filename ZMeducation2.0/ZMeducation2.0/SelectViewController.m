//
//  SelectViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/20.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController ()

@property (nonatomic, strong)UIScrollView *typeScro;

@property (nonatomic, strong)UIScrollView *nianjiScro;

@property (nonatomic, strong)UIScrollView *banjiScro;

@property (nonatomic, strong)UIScrollView *kechengScro;

@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic, strong)NSMutableArray *nianjiArr;

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userInfo = [DEF_UserDefaults objectForKey:SAVE_USERINFO];

    UIImageView *backImav = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    backImav.image = DEF_IMAGE(@"sel_Bg");
    backImav.userInteractionEnabled = YES;
    [self.view addSubview:backImav];

    self.typeScro = [[UIScrollView alloc]initWithFrame:CGRectMake(260 + 17, 135, 490, 100)];
    [self.view addSubview:self.typeScro];
    
    self.nianjiScro = [[UIScrollView alloc]initWithFrame:CGRectMake(260 + 17, self.typeScro.bottom + 25, 490, 100)];
    [self.view addSubview:self.nianjiScro];
    
    self.banjiScro = [[UIScrollView alloc]initWithFrame:CGRectMake(260 + 17, self.nianjiScro.bottom + 25, 490, 100)];
    self.banjiScro.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.banjiScro];
    
    self.kechengScro = [[UIScrollView alloc]initWithFrame:CGRectMake(260 + 17, self.banjiScro.bottom + 25, 490, 100)];
    self.kechengScro.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.kechengScro];
    
    UIButton *yueduBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 14, 66, 72)];
    [yueduBtn setImage:DEF_IMAGENAME(@"sel_yuedu") forState:UIControlStateNormal];
    [yueduBtn addTarget:self action:@selector(yuedu) forControlEvents:UIControlEventTouchUpInside];
    [self.typeScro addSubview:yueduBtn];
    
    UIButton *xiezuoBtn = [[UIButton alloc]initWithFrame:CGRectMake(yueduBtn.right + 15, 14, 66, 72)];
    [xiezuoBtn setImage:DEF_IMAGENAME(@"sel_xiezuo") forState:UIControlStateNormal];
    [xiezuoBtn addTarget:self action:@selector(xiezuo) forControlEvents:UIControlEventTouchUpInside];
    [self.typeScro addSubview:xiezuoBtn];
}

-(void)yuedu
{
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M003",
                           @"userId"           :self.userInfo[@"userId"],
                           @"typeId"           :@"1",
                           @"deviceToken"      :@"9a6c75bc32ccb2f1f4cdf060ba216046a68e964bcb230081102b61e9925e6e8a",
                           @"sign"             :@"69D8BA9D4D2FCFC6E28BAAE227DF1CBB"};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        [DEF_UserDefaults setObject:result forKey:SAVE_USERINFO];
        [self loadyuedunianji];
    } failture:^(id result) {
        
    }];

}

-(void)xiezuo
{

    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M003",
                           @"userId"           :self.userInfo[@"userId"],
                           @"typeId"           :@"2",
                           @"deviceToken"      :@"9a6c75bc32ccb2f1f4cdf060ba216046a68e964bcb230081102b61e9925e6e8a",
                           @"sign"             :@"69D8BA9D4D2FCFC6E28BAAE227DF1CBB"};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        [DEF_UserDefaults setObject:result forKey:SAVE_USERINFO];
        self.nianjiArr = result[@"grades"];
        [self loadxiezuonianji];
    } failture:^(id result) {
        
    }];

}

-(void)loadyuedunianji
{
    for (UIView *view in [self.nianjiScro subviews]) {
        [view removeFromSuperview];
    }
    for (UIView *view in [self.banjiScro subviews]) {
        [view removeFromSuperview];
    }
    for (UIView *view in [self.kechengScro subviews]) {
        [view removeFromSuperview];
    }
}

-(void)loadxiezuonianji
{
    for (UIView *view in [self.nianjiScro subviews]) {
        [view removeFromSuperview];
    }
    for (UIView *view in [self.banjiScro subviews]) {
        [view removeFromSuperview];
    }
    for (UIView *view in [self.kechengScro subviews]) {
        [view removeFromSuperview];
    }
    
    int x = 0;
    for (int i = 0; i < [self.nianjiArr count]; i++) {
        UIButton *nianjiBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, 14, 66, 72)];
        [nianjiBtn setImage:DEF_IMAGENAME(@"sel_Btn") forState:UIControlStateNormal];
        [nianjiBtn addTarget:self action:@selector(nianji:) forControlEvents:UIControlEventTouchUpInside];
        nianjiBtn.tag = 1000 + i;
        [self.nianjiScro addSubview:nianjiBtn];
        
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 66, 68)];
        lable.text = self.nianjiArr[i][@"gradeName"];
        lable.font = DEF_MyBoldFont(21);
        lable.textColor = DEF_COLOR_RGB(43, 177, 243);
        lable.textAlignment = NSTextAlignmentCenter;
        lable.userInteractionEnabled = NO;
        [nianjiBtn addSubview:lable];
        
        x += 15 + 66;
    }
}

-(void)nianji:(UIButton *)sender
{
    for (UIView *view in [self.banjiScro subviews]) {
        [view removeFromSuperview];
    }
    for (UIView *view in [self.kechengScro subviews]) {
        [view removeFromSuperview];
    }

    NSInteger tag = sender.tag;
    
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
