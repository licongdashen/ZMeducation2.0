//
//  LiuLanDetailViewController.m
//  ZMeducation2.0
//
//  Created by 李聪 on 2017/8/15.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "LiuLanDetailViewController.h"

@interface LiuLanDetailViewController ()<UITextViewDelegate>

@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic, strong)NSMutableDictionary *M2071Dic;
@property (nonatomic, strong)UIButton *btn1;
@property (nonatomic, strong)UIButton *btn2;
@property (nonatomic, strong)UIView *view1dianpingView;
@property (nonatomic, strong)UIView *view1gousiView;

@property (nonatomic, strong)NSMutableArray *tempM2071Arr;

@property (nonatomic, strong)UIView *navView;

@end

@implementation LiuLanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.userInfo = [DEF_UserDefaults objectForKey:SAVE_USERINFO];
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 64)];
    self.navView.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [self.view addSubview:self.navView];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 23, 65, 30)];
    [backBtn setTitle:@"返回" forState:0];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:backBtn];

    UIButton *commintBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.navView.width - 75, 23, 65, 30)];
    [commintBtn setTitle:@"提交" forState:0];
    [commintBtn addTarget:self action:@selector(commint) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:commintBtn];
    
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
            if (self.M2071Dic[@"contents"] == nil || [self.M2071Dic[@"contents"] count] == 0) {
                self.tempM2071Arr = [[NSMutableArray alloc]init];
                for (int i = 0; i < 6; i++) {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    [dic setObject:@"" forKey:@"advice"];
                    [self.tempM2071Arr addObject:dic];
                }
            }else{
                self.tempM2071Arr = [[NSMutableArray alloc]initWithArray:self.M2071Dic[@"contents"]];
            }
            [self loadview1];
        }else if ([result[@"reviewType"] intValue] == 2){
            if (self.M2071Dic[@"contents"] == nil || [self.M2071Dic[@"contents"] count] == 0) {
                self.tempM2071Arr = [[NSMutableArray alloc]init];
                NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                NSMutableArray *arr2 = [[NSMutableArray alloc]init];
                for (int i = 0; i < 4; i++) {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    [dic setObject:@"" forKey:@"advice1"];
                    [arr1 addObject:dic];
                    
                    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
                    [dic1 setObject:@"" forKey:@"advice2"];
                    [arr2 addObject:dic1];
                }
                
                [self.tempM2071Arr addObject:arr1];
                [self.tempM2071Arr addObject:arr2];
                
            }else{
                self.tempM2071Arr = [[NSMutableArray alloc]initWithArray:self.M2071Dic[@"contents"]];
            }

            [self loadview2];
            
        }else if ([result[@"reviewType"] intValue] == 3){
            if (self.M2071Dic[@"contents"] == nil || [self.M2071Dic[@"contents"] count] == 0) {
                self.tempM2071Arr = [[NSMutableArray alloc]init];
                for (int i = 0; i < 2; i++) {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    [dic setObject:@"" forKey:@"advice"];
                    [self.tempM2071Arr addObject:dic];
                }
            }else{
                self.tempM2071Arr = [[NSMutableArray alloc]initWithArray:self.M2071Dic[@"contents"]];
            }
            [self loadview3];
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
    
    UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 265, 93)];
    label11.text = self.M2071Dic[@"titles"][0][0];
    label11.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label11];
    
    UILabel *label12 = [[UILabel alloc]initWithFrame:CGRectMake(label11.right, 0, 220, 93)];
    label12.text = self.M2071Dic[@"titles"][0][1];
    label12.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label12];
    
    UILabel *label13 = [[UILabel alloc]initWithFrame:CGRectMake(label12.right, 0, 220, 93)];
    label13.text = self.M2071Dic[@"titles"][0][2];
    label13.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label13];
    
    UILabel *label14 = [[UILabel alloc]initWithFrame:CGRectMake(label13.right, 0, 220, 93)];
    label14.text = self.M2071Dic[@"titles"][0][3];
    label14.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label14];
    
    UILabel *label15 = [[UILabel alloc]initWithFrame:CGRectMake(label14.right, 0, 80, 93)];
    label15.text = self.M2071Dic[@"titles"][0][4];
    label15.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label15];
    
    
    UILabel *label21 = [[UILabel alloc]initWithFrame:CGRectMake(0, label11.bottom, 265 - 90, 93)];
    label21.text = self.M2071Dic[@"titles"][1][0];
    label21.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label21];
    
    UILabel *label22 = [[UILabel alloc]initWithFrame:CGRectMake(label21.right, label11.bottom, 90, 93)];
    label22.text = self.M2071Dic[@"titles"][1][1];
    label22.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label22];

    UILabel *label23 = [[UILabel alloc]initWithFrame:CGRectMake(label22.right, label11.bottom, 220, 93)];
    label23.text = self.M2071Dic[@"titles"][1][2];
    label23.numberOfLines = 0;
    label23.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label23];
    
    UILabel *label24 = [[UILabel alloc]initWithFrame:CGRectMake(label23.right, label11.bottom, 220, 93)];
    label24.text = self.M2071Dic[@"titles"][1][3];
    label24.numberOfLines = 0;
    label23.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label24];
    
    UILabel *label25 = [[UILabel alloc]initWithFrame:CGRectMake(label24.right, label11.bottom, 220, 93)];
    label25.text = self.M2071Dic[@"titles"][1][4];
    label25.numberOfLines = 0;
    label25.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label25];
    
    UILabel *label31 = [[UILabel alloc]initWithFrame:CGRectMake(0, label21.bottom, 265 - 90, 93 * 2)];
    label31.text = self.M2071Dic[@"titles"][2][0];
    label31.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label31];
    
    UILabel *label32 = [[UILabel alloc]initWithFrame:CGRectMake(label31.right, label21.bottom, 90, 93)];
    label32.text = self.M2071Dic[@"titles"][2][1];
    label32.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label32];
    
    UILabel *label33 = [[UILabel alloc]initWithFrame:CGRectMake(label32.right, label21.bottom, 220, 93)];
    label33.text = self.M2071Dic[@"titles"][2][2];
    label33.textAlignment = NSTextAlignmentCenter;
    label33.numberOfLines = 0;
    label33.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label33];
    
    UILabel *label34 = [[UILabel alloc]initWithFrame:CGRectMake(label33.right, label21.bottom, 220, 93)];
    label34.text = self.M2071Dic[@"titles"][2][3];
    label34.textAlignment = NSTextAlignmentCenter;
    label34.numberOfLines = 0;
    label34.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label34];
    
    UILabel *label35 = [[UILabel alloc]initWithFrame:CGRectMake(label34.right, label21.bottom, 220, 93)];
    label35.text = self.M2071Dic[@"titles"][2][4];
    label35.numberOfLines = 0;
    label35.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label35];
    
    UILabel *label42 = [[UILabel alloc]initWithFrame:CGRectMake(label31.right, label32.bottom, 90, 93)];
    label42.text = self.M2071Dic[@"titles"][3][1];
    label42.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label42];
    
    UILabel *label43 = [[UILabel alloc]initWithFrame:CGRectMake(label42.right, label32.bottom, 220, 93)];
    label43.text = self.M2071Dic[@"titles"][3][2];
    label43.numberOfLines = 0;
    label43.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label43];
    
    UILabel *label44 = [[UILabel alloc]initWithFrame:CGRectMake(label43.right, label32.bottom, 220, 93)];
    label44.text = self.M2071Dic[@"titles"][3][3];
    label44.numberOfLines = 0;
    label44.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label44];
    
    UILabel *label45 = [[UILabel alloc]initWithFrame:CGRectMake(label44.right, label32.bottom, 220, 93)];
    label45.text = self.M2071Dic[@"titles"][3][4];
    label45.numberOfLines = 0;
    label45.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label45];
    
    UILabel *label51 = [[UILabel alloc]initWithFrame:CGRectMake(0, label31.bottom, 265 - 90, 93 * 2)];
    label51.text = self.M2071Dic[@"titles"][4][0];
    label51.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label51];
    
    UILabel *label52 = [[UILabel alloc]initWithFrame:CGRectMake(label51.right, label31.bottom, 90, 93)];
    label52.text = self.M2071Dic[@"titles"][4][1];
    label52.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label52];
    
    UILabel *label53 = [[UILabel alloc]initWithFrame:CGRectMake(label52.right, label31.bottom, 220, 93)];
    label53.text = self.M2071Dic[@"titles"][4][2];
    label53.textAlignment = NSTextAlignmentCenter;
    label53.numberOfLines = 0;
    label53.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label53];

    UILabel *label54 = [[UILabel alloc]initWithFrame:CGRectMake(label53.right, label31.bottom, 220, 93)];
    label54.text = self.M2071Dic[@"titles"][4][3];
    label54.textAlignment = NSTextAlignmentCenter;
    label54.numberOfLines = 0;
    label54.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label54];

    UILabel *label55 = [[UILabel alloc]initWithFrame:CGRectMake(label54.right, label31.bottom, 220, 93)];
    label55.text = self.M2071Dic[@"titles"][4][4];
    label55.numberOfLines = 0;
    label55.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label55];

    UILabel *label62 = [[UILabel alloc]initWithFrame:CGRectMake(label51.right, label52.bottom, 90, 93)];
    label62.text = self.M2071Dic[@"titles"][5][1];
    label62.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label62];
    
    UILabel *label63 = [[UILabel alloc]initWithFrame:CGRectMake(label52.right, label52.bottom, 220, 93)];
    label63.text = self.M2071Dic[@"titles"][5][2];
    label63.numberOfLines = 0;
    label63.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label63];
    
    UILabel *label64 = [[UILabel alloc]initWithFrame:CGRectMake(label53.right, label52.bottom, 220, 93)];
    label64.text = self.M2071Dic[@"titles"][5][3];
    label64.numberOfLines = 0;
    label64.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label64];
    
    UILabel *label65 = [[UILabel alloc]initWithFrame:CGRectMake(label54.right, label52.bottom, 220, 93)];
    label65.text = self.M2071Dic[@"titles"][5][4];
    label65.numberOfLines = 0;
    label65.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label65];


    UILabel *label71 = [[UILabel alloc]initWithFrame:CGRectMake(0, label65.bottom, 265 - 90, 93)];
    label71.text = self.M2071Dic[@"titles"][6][0];
    label71.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label71];
    
    UILabel *label72 = [[UILabel alloc]initWithFrame:CGRectMake(label21.right, label65.bottom, 90, 93)];
    label72.text = self.M2071Dic[@"titles"][6][1];
    label72.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label72];
    
    UILabel *label73 = [[UILabel alloc]initWithFrame:CGRectMake(label22.right, label65.bottom, 220, 93)];
    label73.text = self.M2071Dic[@"titles"][6][2];
    label73.numberOfLines = 0;
    label73.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label73];
    
    UILabel *label74 = [[UILabel alloc]initWithFrame:CGRectMake(label23.right, label65.bottom, 220, 93)];
    label74.text = self.M2071Dic[@"titles"][6][3];
    label74.numberOfLines = 0;
    label74.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label74];
    
    UILabel *label75 = [[UILabel alloc]initWithFrame:CGRectMake(label24.right, label65.bottom, 220, 93)];
    label75.text = self.M2071Dic[@"titles"][6][4];
    label75.numberOfLines = 0;
    label75.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label75];

    int y = 93;
    for (int i = 0; i < 6; i++) {
        UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(label75.right, y, 90, 93)];
        tv.text = self.tempM2071Arr[i][@"advice"];
        tv.tag = 1000 + i;
        tv.delegate = self;
        tv.font = DEF_MyFont(16);
        tv.backgroundColor = [UIColor clearColor];
        [bg_selfCommentImagv addSubview:tv];
        
        y += 93;
    }
}

-(void)loadview2
{
    UIImageView *bg_selfCommentImagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20 + 65, self.view.width, self.view.height - 20 - 65)];
    bg_selfCommentImagv.image = DEF_IMAGE(@"bg_interComment");
    bg_selfCommentImagv.userInteractionEnabled = YES;
    [self.view addSubview:bg_selfCommentImagv];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 150, 20)];
    label1.text = [NSString stringWithFormat:@"作者:%@",self.M2071Dic[@"authorName"]];
    [self.view1dianpingView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH - 250, 0, 150, 20)];
    label2.text = [NSString stringWithFormat:@"点评者:%@",self.M2071Dic[@"userName"]];
    [self.view1dianpingView addSubview:label2];
    

    UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 132, 112)];
    label11.text = self.M2071Dic[@"titles"][0][0];
    label11.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label11];

    UILabel *label12 = [[UILabel alloc]initWithFrame:CGRectMake(label11.right, 0, 545, 112)];
    label12.text = self.M2071Dic[@"titles"][0][1];
    label12.numberOfLines = 0;
    label12.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label12];

    UILabel *label13 = [[UILabel alloc]initWithFrame:CGRectMake(label12.right, 0, 120, 112)];
    label13.text = self.M2071Dic[@"titles"][0][2];
    label13.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label13];
    
    UILabel *label21 = [[UILabel alloc]initWithFrame:CGRectMake(0, label11.bottom, 132, 112)];
    label21.text = self.M2071Dic[@"titles"][1][0];
    label21.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label21];
    
    UILabel *label22 = [[UILabel alloc]initWithFrame:CGRectMake(label11.right, label11.bottom, 545, 112)];
    label22.text = self.M2071Dic[@"titles"][1][1];
    label22.numberOfLines = 0;
    label22.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label22];
    
    UILabel *label23 = [[UILabel alloc]initWithFrame:CGRectMake(label12.right, label11.bottom, 120, 112)];
    label23.text = self.M2071Dic[@"titles"][1][2];
    label23.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label23];
    
    UILabel *label31 = [[UILabel alloc]initWithFrame:CGRectMake(0, label21.bottom, 132, 112)];
    label31.text = self.M2071Dic[@"titles"][2][0];
    label31.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label31];
    
    UILabel *label32 = [[UILabel alloc]initWithFrame:CGRectMake(label11.right, label21.bottom, 545, 112)];
    label32.text = self.M2071Dic[@"titles"][2][1];
    label32.numberOfLines = 0;
    label32.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label32];
    
    UILabel *label33 = [[UILabel alloc]initWithFrame:CGRectMake(label12.right, label21.bottom, 120, 112)];
    label33.text = self.M2071Dic[@"titles"][2][2];
    label33.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label33];

    UILabel *label41 = [[UILabel alloc]initWithFrame:CGRectMake(0, label31.bottom, 132, 190)];
    label41.text = self.M2071Dic[@"titles"][3][0];
    label41.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label41];
    
    UILabel *label42 = [[UILabel alloc]initWithFrame:CGRectMake(label11.right, label31.bottom, 545, 190)];
    label42.text = self.M2071Dic[@"titles"][3][1];
    label42.numberOfLines = 0;
    label42.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label42];
    
    UILabel *label43 = [[UILabel alloc]initWithFrame:CGRectMake(label12.right, label31.bottom, 120, 190)];
    label43.text = self.M2071Dic[@"titles"][3][2];
    label43.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label43];
    
    UILabel *label51 = [[UILabel alloc]initWithFrame:CGRectMake(0, label41.bottom, 132, 100)];
    label51.text = self.M2071Dic[@"titles"][4][0];
    label51.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label51];
    
    UILabel *label52 = [[UILabel alloc]initWithFrame:CGRectMake(label11.right, label41.bottom, 545, 100)];
    label52.text = self.M2071Dic[@"titles"][4][1];
    label52.numberOfLines = 0;
    label52.adjustsFontSizeToFitWidth = YES;
    [bg_selfCommentImagv addSubview:label52];
    
    UILabel *label53 = [[UILabel alloc]initWithFrame:CGRectMake(label12.right, label41.bottom, 120, 100)];
    label53.text = self.M2071Dic[@"titles"][4][2];
    label53.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label53];
    
    UILabel *label61 = [[UILabel alloc]initWithFrame:CGRectMake(0, label51.bottom, 132, 70)];
    label61.text = @"总分";
    label61.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label61];
    
    UILabel *label63 = [[UILabel alloc]initWithFrame:CGRectMake(label12.right, label51.bottom, 120, 70)];
    label63.text = [NSString stringWithFormat:@"%d",[self.M2071Dic[@"titles"][1][2] intValue] + [self.M2071Dic[@"titles"][2][2] intValue] + [self.M2071Dic[@"titles"][3][2] intValue] + [self.M2071Dic[@"titles"][4][2] intValue]];
    label63.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label63];

    UILabel *label64 = [[UILabel alloc]initWithFrame:CGRectMake(label63.right, label51.bottom, 120, 70)];
    label64.text = [NSString stringWithFormat:@"%d",[self.tempM2071Arr[0][0][@"advice1"] intValue] + [self.tempM2071Arr[0][1][@"advice1"] intValue] + [self.tempM2071Arr[0][2][@"advice1"] intValue] + [self.tempM2071Arr[0][3][@"advice1"] intValue]];
    label64.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label64];
    
    UILabel *label65 = [[UILabel alloc]initWithFrame:CGRectMake(label64.right, label51.bottom, 120, 70)];
    label65.text = [NSString stringWithFormat:@"%d",[self.tempM2071Arr[1][0][@"advice2"] intValue] + [self.tempM2071Arr[1][1][@"advice2"] intValue] + [self.tempM2071Arr[1][2][@"advice2"] intValue] + [self.tempM2071Arr[1][3][@"advice2"] intValue]];
    label65.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label65];

    UILabel *label14 = [[UILabel alloc]initWithFrame:CGRectMake(label13.right, 0, 240, 112/2)];
    label14.text = @"得分";
    label14.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label14];
    
    UILabel *label15 = [[UILabel alloc]initWithFrame:CGRectMake(label13.right, label14.bottom, 120, 112/2)];
    label15.text = @"自评";
    label15.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label15];
    
    UILabel *label16 = [[UILabel alloc]initWithFrame:CGRectMake(label15.right, label14.bottom, 120, 112/2)];
    label16.text = @"同学评";
    label16.textAlignment = NSTextAlignmentCenter;
    [bg_selfCommentImagv addSubview:label16];
    
    int y = label15.bottom;
    for (int i = 0; i < 4; i++) {
        UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(label13.right, y, 120, 112)];
        tv.text = self.tempM2071Arr[0][i][@"advice1"];
        tv.tag = 2000 + i;
        tv.delegate = self;
        tv.font = DEF_MyFont(16);
        tv.backgroundColor = [UIColor clearColor];
        [bg_selfCommentImagv addSubview:tv];
        
        UITextView *tv1 = [[UITextView alloc]initWithFrame:CGRectMake(label15.right, y, 120, 112)];
        tv1.text = self.tempM2071Arr[1][i][@"advice2"];
        tv1.tag = 3000 + i;
        tv1.delegate = self;
        tv1.font = DEF_MyFont(16);

        tv1.backgroundColor = [UIColor clearColor];
        [bg_selfCommentImagv addSubview:tv1];
        
        if (i == 2) {
            y += 190;
        }else{
            y += 112;
        }
    }
    
}

-(void)loadview3
{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 150, 20)];
    label1.text = [NSString stringWithFormat:@"作者:%@",self.M2071Dic[@"authorName"]];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH - 250, 0, 150, 20)];
    label2.text = [NSString stringWithFormat:@"点评者:%@",self.M2071Dic[@"userName"]];
    [self.view addSubview:label2];

    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, 150, 30)];
    titleLb.text = @"我欣赏的是";
    [self.view addSubview:titleLb];
    
    UITextView *tv1 = [[UITextView alloc]initWithFrame:CGRectMake(250, 100, 600, 300)];
    tv1.text =  self.tempM2071Arr[0][@"advice"];
    tv1.layer.borderColor = [UIColor grayColor].CGColor;
    tv1.layer.borderWidth = 1;
    tv1.backgroundColor = [UIColor clearColor];
    tv1.tag = 5555;
    tv1.delegate = self;
    tv1.font = DEF_MyFont(16);

    [self.view addSubview:tv1];
    
    UILabel *titleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 500, 250, 30)];
    titleLb1.text = @"我建议你改变的是的是";
    [self.view addSubview:titleLb1];
    
    UITextView *tv2 = [[UITextView alloc]initWithFrame:CGRectMake(250, 450, 600, 300)];
    tv2.text =  self.tempM2071Arr[1][@"advice"];
    tv2.layer.borderColor = [UIColor grayColor].CGColor;
    tv2.layer.borderWidth = 1;
    tv2.backgroundColor = [UIColor clearColor];
    tv2.tag = 6666;
    tv2.delegate = self;
    tv2.font = DEF_MyFont(16);

    [self.view addSubview:tv2];
}

-(void)commint
{
    
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2072",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"unitId"           :self.dic[@"unitId"],
                            @"authorId"         :self.dic[@"authorId"],
                            @"contents"         :[CACUtility dictionaryToJson:self.tempM2071Arr],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2072"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        if ([result[@"responseCode"] isEqualToString:@"00"]) {
            [CACUtility showTips:@"提交成功"];
        }else if ([result[@"responseCode"] isEqualToString:@"96"]){
            if (result[@"responseMessage"] != nil) {
                [CACUtility showTips:result[@"responseMessage"]];
            }
        }else{
            [CACUtility showTips:@"提交失败"];
        }
    } failture:^(id result) {
        [CACUtility showTips:@"提交失败"];

    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.M2071Dic[@"reviewType"] intValue] == 1) {
        int tag = (int)textView.tag - 1000;
        NSMutableDictionary *dic = self.tempM2071Arr[tag];
        [dic setObject:textView.text forKey:@"advice"];

    }else if ([self.M2071Dic[@"reviewType"] intValue] == 2){
        if (textView.tag >= 3000) {
            int tag = (int)textView.tag - 3000;
            NSMutableDictionary *dic = self.tempM2071Arr[1][tag];
            [dic setObject:textView.text forKey:@"advice2"];
        }else{
            int tag = (int)textView.tag - 2000;
            NSMutableDictionary *dic = self.tempM2071Arr[0][tag];
            [dic setObject:textView.text forKey:@"advice1"];
        }
    }else if ([self.M2071Dic[@"reviewType"] intValue] == 3){
        if (textView.tag == 5555) {
            NSMutableDictionary *dic = self.tempM2071Arr[0];
            [dic setObject:textView.text forKey:@"advice"];
        }else{
            NSMutableDictionary *dic = self.tempM2071Arr[1];
            [dic setObject:textView.text forKey:@"advice"];

        }
    }
    
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
