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
@property (nonatomic, strong)UIButton *btn1;
@property (nonatomic, strong)UIButton *btn2;
@property (nonatomic, strong)UIView *view1dianpingView;
@property (nonatomic, strong)UIView *view1gousiView;

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
                            @"authorId"         :self.dic[@"authorId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2071"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        self.M2071Dic = result;
        if ([result[@"reviewType"] intValue] == 1) {
            [self loadview1];
        }else if ([result[@"reviewType"] intValue] == 2){
        
            [self loadview2];
            
        }else if ([result[@"reviewType"] intValue] == 3){
        
        }
        
    } failture:^(id result) {
        
    }];
    
}

-(void)loadview1
{
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH/2 - 115, 70, 115, 30)];
    btn1.layer.cornerRadius = 15;
    btn1.layer.borderWidth = 2;
    [btn1 setTitle:@"点评详情" forState:UIControlStateNormal];
    btn1.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(action1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    self.btn1 = btn1;

    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.right, 70, 115, 30)];
    btn2.layer.cornerRadius = 15;
    btn2.layer.borderWidth = 2;
    [btn2 setTitle:@"构思详情" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor clearColor];
    btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(action2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    self.btn2 = btn2;
    
    self.view1dianpingView = [[UIView alloc]initWithFrame:CGRectMake(0, btn1.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 100)];
    [self.view addSubview:self.view1dianpingView];
    
    self.view1gousiView = [[UIView alloc]initWithFrame:CGRectMake(0, btn1.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 100)];
    self.view1gousiView.hidden = YES;
    [self.view addSubview:self.view1gousiView];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 150, 20)];
    label1.text = [NSString stringWithFormat:@"作者:%@",self.M2071Dic[@"authorName"]];
    [self.view1dianpingView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH - 250, 0, 150, 20)];
    label2.text = [NSString stringWithFormat:@"点评者:%@",self.M2071Dic[@"userName"]];
    [self.view1dianpingView addSubview:label2];
    
    UIImageView *bg_selfCommentImagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view1dianpingView.width, self.view1dianpingView.height - 20)];
    bg_selfCommentImagv.image = DEF_IMAGE(@"bg_selfComment");
    bg_selfCommentImagv.userInteractionEnabled = YES;
    [self.view1dianpingView addSubview:bg_selfCommentImagv];
    
}

-(void)action1:(UIButton *)sender
{
    self.view1gousiView.hidden = YES;
    self.view1dianpingView.hidden = NO;

    self.btn2.backgroundColor = [UIColor clearColor];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    sender.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

-(void)action2:(UIButton *)sender
{
    self.view1gousiView.hidden = NO;
    self.view1dianpingView.hidden = YES;
    
    self.btn1.backgroundColor = [UIColor clearColor];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    sender.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
