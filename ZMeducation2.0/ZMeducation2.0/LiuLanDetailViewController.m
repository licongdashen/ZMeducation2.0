//
//  LiuLanDetailViewController.m
//  ZMeducation2.0
//
//  Created by 李聪 on 2017/8/15.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "LiuLanDetailViewController.h"

@interface LiuLanDetailViewController ()

@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic, strong)NSMutableDictionary *M2071Dic;

@end

@implementation LiuLanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userInfo = [DEF_UserDefaults objectForKey:SAVE_USERINFO];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 64)];
    view.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [self.view addSubview:view];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 23, 65, 30)];
    [backBtn setTitle:@"返回" forState:0];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];

    UIImageView *imagvBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 64)];
    imagvBg.image = DEF_IMAGENAME(@"xiezuo_bg");
    imagvBg.userInteractionEnabled = YES;
    [self.view addSubview:imagvBg];

    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2071",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"unitId"           :self.dic[@"unitId"],
                            @"unitTypeId"       :self.dic[@"unitType"],
                            @"authorId"         :self.dic[@"authorId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2071"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        self.M2071Dic = result;
        if ([result[@"reviewType"] intValue] == 1) {
            
        }else if ([result[@"reviewType"] intValue] == 2){
        
            [self loadview2];
            
        }else if ([result[@"reviewType"] intValue] == 3){
        
        }
        
    } failture:^(id result) {
        
    }];
    
}

-(void)loadview2
{
    UILabel *labele = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, DEF_DEVICE_WIDTH, 40)];
    labele.text = self.M2071Dic[@"author"];
    
    NSArray *arr = self.M2071Dic[@"feedstr"];
    for (int i = 0; i < [arr count]; i ++ ) {
        
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
