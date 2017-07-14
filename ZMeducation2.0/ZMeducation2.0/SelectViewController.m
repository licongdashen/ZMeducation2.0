//
//  SelectViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/20.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "SelectViewController.h"
#import "HomeViewController.h"

@interface SelectViewController ()

@property (nonatomic, strong)UIScrollView *typeScro;

@property (nonatomic, strong)UIScrollView *nianjiScro;

@property (nonatomic, strong)UIScrollView *banjiScro;

@property (nonatomic, strong)UIScrollView *kechengScro;

@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic, strong)NSMutableArray *nianjiArr;

@property (nonatomic, strong)NSMutableArray *banjiArr;

@property (nonatomic, strong)NSMutableArray *kechengArr;

@property (nonatomic, strong)NSString *gradeId;

@property (nonatomic, strong)NSString *classId;

@property (nonatomic, strong)NSString *courseId;

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
    [self.view addSubview:self.banjiScro];
    
    self.kechengScro = [[UIScrollView alloc]initWithFrame:CGRectMake(260 + 17, self.banjiScro.bottom + 25, 490, 100)];
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
                           @"sign"             :[CACUtility getSignWithMethod:@"m003"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
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
                           @"sign"             :[CACUtility getSignWithMethod:@"m003"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
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
        
        UILabel * typeLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 52, 66, 20)];
        typeLb.text = self.nianjiArr[i][@"schoolType"];
        typeLb.font = DEF_MyBoldFont(16);
        typeLb.textColor = [UIColor whiteColor];
        typeLb.textAlignment = NSTextAlignmentCenter;
        typeLb.userInteractionEnabled = NO;
        [nianjiBtn addSubview:typeLb];
        
        x += 15 + 66;
    }
    self.nianjiScro.contentSize = CGSizeMake(x, 100);
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
    
    self.gradeId = self.nianjiArr[tag - 1000][@"gradeId"];
    
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M004",
                           @"userId"           :self.userInfo[@"userId"],
                           @"typeId"           :@"2",
                           @"gradeId"          :self.nianjiArr[tag - 1000][@"gradeId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"m004"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {

        self.banjiArr = result[@"classes"];
        [self loadbanji];
        
    } failture:^(id result) {
        
    }];

}

-(void)loadbanji
{
    int x = 0;
    for (int i = 0; i < [self.banjiArr count]; i++) {
        UIButton *banjiBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, 14, 66, 72)];
        [banjiBtn setImage:DEF_IMAGENAME(@"sel_Btn") forState:UIControlStateNormal];
        [banjiBtn addTarget:self action:@selector(banji:) forControlEvents:UIControlEventTouchUpInside];
        banjiBtn.tag = 10000 + i;
        [self.banjiScro addSubview:banjiBtn];
        
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 66, 68)];
        lable.text = [NSString stringWithFormat:@"%d班",[self.banjiArr[i][@"className"]intValue]];
        lable.font = DEF_MyBoldFont(21);
        lable.textColor = DEF_COLOR_RGB(43, 177, 243);
        lable.textAlignment = NSTextAlignmentCenter;
        lable.userInteractionEnabled = NO;
        [banjiBtn addSubview:lable];

        x += 15 + 66;
    }
    
    self.banjiScro.contentSize = CGSizeMake(x, 100);
}

-(void)banji:(UIButton *)sender
{
    for (UIView *view in [self.kechengScro subviews]) {
        [view removeFromSuperview];
    }
    NSInteger tag = sender.tag;

    self.classId = self.banjiArr[tag - 10000][@"classId"];
    
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M005",
                           @"userId"           :self.userInfo[@"userId"],
                           @"typeId"           :@"2",
                           @"gradeId"          :self.gradeId,
                           @"classId"          :self.banjiArr[tag - 10000][@"classId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"m005"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        
        self.kechengArr = result[@"courses"];
        [self loadkecheng];
    } failture:^(id result) {
        
    }];

}

-(void)loadkecheng
{
    int x = 0;
    for (int i = 0; i < [self.kechengArr count]; i++) {
        UIButton *kechengBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, 14, 55, 55)];
        [kechengBtn setImage:DEF_IMAGENAME(@"sel_kecheng") forState:UIControlStateNormal];
        [kechengBtn addTarget:self action:@selector(kecheng:) forControlEvents:UIControlEventTouchUpInside];
        kechengBtn.tag = 100000 + i;
        [self.kechengScro addSubview:kechengBtn];
        
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(x, kechengBtn.bottom, 55, 22)];
        lable.text = self.kechengArr[i][@"courseName"];
        lable.font = DEF_MyBoldFont(12);
        lable.textColor = DEF_COLOR_RGB(43, 177, 243);
        lable.textAlignment = NSTextAlignmentCenter;
        [lable setAdjustsFontSizeToFitWidth:YES];
        lable.numberOfLines = 2;
        [self.kechengScro addSubview:lable];
        
        x += 15 + 55;
    }
    
    self.kechengScro.contentSize = CGSizeMake(x, 100);
}

-(void)kecheng:(UIButton *)sender
{
    NSInteger tag = sender.tag;

    self.courseId = self.kechengArr[tag - 100000][@"courseId"];
    
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M006",
                           @"userId"           :self.userInfo[@"userId"],
                           @"typeId"           :@"2",
                           @"gradeId"          :self.gradeId,
                           @"classId"          :self.classId,
                           @"courseId"         :self.courseId,
                           @"sign"             :[CACUtility getSignWithMethod:@"m006"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        
        HomeViewController *VC = [[HomeViewController alloc]init];
        VC.dic = result;
        [self.navigationController pushViewController:VC animated:YES];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:self.userInfo];
        [dic setObject:self.gradeId forKey:@"gradeId"];
        [dic setObject:self.classId forKey:@"classId"];
        [dic setObject:self.courseId forKey:@"courseId"];
        [DEF_UserDefaults setObject:dic forKey:SAVE_USERINFO];

    } failture:^(id result) {
        
    }];

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
