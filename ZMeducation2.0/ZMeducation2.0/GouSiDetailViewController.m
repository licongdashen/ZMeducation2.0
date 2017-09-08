//
//  GouSiDetailViewController.m
//  ZMeducation2.0
//
//  Created by 李聪 on 2017/8/20.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "GouSiDetailViewController.h"

@interface GouSiDetailViewController ()<UITextViewDelegate>
@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic, strong)NSMutableDictionary *M2071Dic;
@property (nonatomic, strong)UIButton *btn1;
@property (nonatomic, strong)UIButton *btn2;
@property (nonatomic, strong)UIView *view1dianpingView;
@property (nonatomic, strong)UIView *view1gousiView;

@property (nonatomic, strong)NSMutableArray *tempM2071Arr;

@property (nonatomic, strong)UIView *navView;

@property (nonatomic, strong)NSMutableArray *tempM2061Arr;

@property (nonatomic, strong)UIView *gousiBackView;

@property (nonatomic, strong)NSMutableArray *M2074Arr;

@property (nonatomic, strong)NSMutableDictionary *M2074Dic;

@property (nonatomic, strong)UIScrollView *scro;

@end

@implementation GouSiDetailViewController

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
    
//    UIButton *commintBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.navView.width - 75, 23, 65, 30)];
//    [commintBtn setTitle:@"提交" forState:0];
//    [commintBtn addTarget:self action:@selector(commint) forControlEvents:UIControlEventTouchUpInside];
//    [self.navView addSubview:commintBtn];
    
    UIImageView *imagvBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 64)];
    imagvBg.image = DEF_IMAGENAME(@"xiezuo_bg");
    imagvBg.userInteractionEnabled = YES;
    [self.view addSubview:imagvBg];
    
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2061",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"unitId"           :self.dic[@"unitId"],
                            @"authorId"         :self.dic[@"authorId"],
                            @"unitTypeId"       :self.dic[@"unitTypeId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2061"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        NSData *jsonData = [result[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                       options:NSJSONReadingMutableContainers
                                                         error:nil];
        self.tempM2061Arr = [[NSMutableArray alloc]initWithArray:arr];

        
        self.M2071Dic = result;
        if ([self.dic[@"unitTypeId"] intValue] == 62) {
//            if (self.M2071Dic[@"contents"] == nil || [self.M2071Dic[@"contents"] count] == 0) {
//                self.tempM2071Arr = [[NSMutableArray alloc]init];
//                for (int i = 0; i < 6; i++) {
//                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//                    [dic setObject:@"" forKey:@"advice"];
//                    [self.tempM2071Arr addObject:dic];
//                }
//            }else{
//                self.tempM2071Arr = [[NSMutableArray alloc]initWithArray:self.M2071Dic[@"contents"]];
//            }
            [self loadview1];
        }else if ([self.dic[@"unitTypeId"] intValue] == 63){
//            if (self.M2071Dic[@"contents"] == nil || [self.M2071Dic[@"contents"] count] == 0) {
//                self.tempM2071Arr = [[NSMutableArray alloc]init];
//                NSMutableArray *arr1 = [[NSMutableArray alloc]init];
//                NSMutableArray *arr2 = [[NSMutableArray alloc]init];
//                for (int i = 0; i < 4; i++) {
//                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//                    [dic setObject:@"" forKey:@"advice1"];
//                    [arr1 addObject:dic];
//                    
//                    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
//                    [dic1 setObject:@"" forKey:@"advice2"];
//                    [arr2 addObject:dic1];
//                }
//                
//                [self.tempM2071Arr addObject:arr1];
//                [self.tempM2071Arr addObject:arr2];
//                
//            }else{
//                self.tempM2071Arr = [[NSMutableArray alloc]initWithArray:self.M2071Dic[@"contents"]];
//            }
            
            [self loadview2];
            
        }else if ([self.dic[@"unitTypeId"] intValue] == 64){
//            if (self.M2071Dic[@"contents"] == nil || [self.M2071Dic[@"contents"] count] == 0) {
//                self.tempM2071Arr = [[NSMutableArray alloc]init];
//                for (int i = 0; i < 2; i++) {
//                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//                    [dic setObject:@"" forKey:@"advice"];
//                    [self.tempM2071Arr addObject:dic];
//                }
//            }else{
//                self.tempM2071Arr = [[NSMutableArray alloc]initWithArray:self.M2071Dic[@"contents"]];
//            }
            [self loadview3];
        }
        
    } failture:^(id result) {
        
    }];
}

-(void)action1:(UIButton *)sender
{
    self.gousiBackView.hidden = NO;
    self.view1dianpingView.hidden = YES;
    
    self.btn2.backgroundColor = [UIColor clearColor];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    sender.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

-(void)action2:(UIButton *)sender
{
    self.gousiBackView.hidden = YES;
    self.view1dianpingView.hidden = NO;
    
    self.btn1.backgroundColor = [UIColor clearColor];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    sender.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2074",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"unitId"           :self.dic[@"unitId"],
                            @"authorId"         :self.dic[@"authorId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2074"],
                            @"unitId"           :self.dic[@"unitId"],
                            @"unitTypeId"       :self.dic[@"unitTypeId"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
    } failture:^(id result) {
        
    }];
}

-(void)loadview1
{
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH/2 - 115, 70, 115, 30)];
    btn1.layer.cornerRadius = 15;
    btn1.layer.borderWidth = 2;
    [btn1 setTitle:@"构思详情" forState:UIControlStateNormal];
    btn1.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(action1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    self.btn1 = btn1;
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.right, 70, 115, 30)];
    btn2.layer.cornerRadius = 15;
    btn2.layer.borderWidth = 2;
    [btn2 setTitle:@"点评详情" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor clearColor];
    btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(action2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    self.btn2 = btn2;

    self.gousiBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 53 + 50, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 53)];
    self.gousiBackView.userInteractionEnabled = NO;
    [self.view addSubview:self.gousiBackView];
    
    self.view1dianpingView = [[UIView alloc]initWithFrame:CGRectMake(0, btn1.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 100)];
    self.view1dianpingView.hidden = YES;
    [self.view addSubview:self.view1dianpingView];

    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.gousiBackView.width, self.gousiBackView.height - 100)];
    imagv.image = DEF_IMAGE(@"article_1");
    imagv.userInteractionEnabled = YES;
    imagv.contentMode = UIViewContentModeScaleAspectFit;
    [self.gousiBackView addSubview:imagv];
    
    UITextView *tv1 = [[UITextView alloc]initWithFrame:CGRectMake(120, 50, 190, 50)];
    tv1.text = self.tempM2061Arr[0][@"advice"];
    tv1.tag = 2001;
    tv1.delegate = self;
    tv1.font = DEF_MyFont(16);
    [imagv addSubview:tv1];
    
    UITextView *tv2 = [[UITextView alloc]initWithFrame:CGRectMake(120, tv1.bottom + 30, 190, 450)];
    tv2.text = self.tempM2061Arr[1][@"advice"];
    tv2.tag = 2002;
    tv2.delegate = self;
    tv2.font = DEF_MyFont(16);
    
    [imagv addSubview:tv2];
    
    UITextView *tv3 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 100, tv1.y + 20, 190, 50)];
    tv3.text = self.tempM2061Arr[2][@"advice"];
    tv3.tag = 2003;
    tv3.delegate = self;
    tv3.font = DEF_MyFont(16);
    
    [imagv addSubview:tv3];
    
    UITextView *tv4 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 100, tv3.bottom + 40, 190, 50)];
    tv4.text = self.tempM2061Arr[3][@"advice"];
    tv4.tag = 2004;
    tv4.delegate = self;
    tv4.font = DEF_MyFont(16);
    
    [imagv addSubview:tv4];
    
    UITextView *tv5 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 100, tv4.bottom + 40, 190, 50)];
    tv5.text = self.tempM2061Arr[4][@"advice"];
    tv5.tag = 2005;
    tv5.delegate = self;
    tv5.font = DEF_MyFont(16);
    
    [imagv addSubview:tv5];
    
    UITextView *tv6 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 100, tv5.bottom + 45, 190, 50)];
    tv6.text = self.tempM2061Arr[5][@"advice"];
    tv6.tag = 2006;
    tv6.delegate = self;
    tv6.font = DEF_MyFont(16);
    
    [imagv addSubview:tv6];
    
    UITextView *tv7 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 100, tv6.bottom + 45, 190, 50)];
    tv7.text = self.tempM2061Arr[6][@"advice"];
    tv7.tag = 2007;
    tv7.delegate = self;
    tv7.font = DEF_MyFont(16);
    
    [imagv addSubview:tv7];
    
    UITextView *tv8 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 100, tv7.bottom + 45, 190, 50)];
    tv8.text = self.tempM2061Arr[7][@"advice"];
    tv8.tag = 2008;
    tv8.delegate = self;
    tv8.font = DEF_MyFont(16);
    
    [imagv addSubview:tv8];
    
    UITextView *tv9 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.right + 130, tv1.y + 20, 160, 110)];
    tv9.text = self.tempM2061Arr[8][@"advice"];
    tv9.tag = 2009;
    tv9.delegate = self;
    tv9.font = DEF_MyFont(16);
    
    [imagv addSubview:tv9];
    
    UITextView *tv10 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.right + 130, tv9.bottom + 60, 160, 110)];
    tv10.text = self.tempM2061Arr[9][@"advice"];
    tv10.tag = 2010;
    tv10.delegate = self;
    tv10.font = DEF_MyFont(16);
    
    [imagv addSubview:tv10];
    
    UITextView *tv11 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.right + 130, tv10.bottom + 60, 160, 110)];
    tv11.text = self.tempM2061Arr[10][@"advice"];
    tv11.tag = 2011;
    tv11.delegate = self;
    tv11.font = DEF_MyFont(16);
    
    [imagv addSubview:tv11];
    
//    UIButton *commit = [[UIButton alloc]initWithFrame:CGRectMake(tv11.right - 80, tv11.bottom + 20, 80, 80)];
//    [commit addTarget:self action:@selector(gousicommit) forControlEvents:UIControlEventTouchUpInside];
//    [imagv addSubview:commit];

}

-(void)loadview2
{
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH/2 - 115, 70, 115, 30)];
    btn1.layer.cornerRadius = 15;
    btn1.layer.borderWidth = 2;
    [btn1 setTitle:@"构思详情" forState:UIControlStateNormal];
    btn1.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(action1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    self.btn1 = btn1;
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.right, 70, 115, 30)];
    btn2.layer.cornerRadius = 15;
    btn2.layer.borderWidth = 2;
    [btn2 setTitle:@"点评详情" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor clearColor];
    btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(action2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    self.btn2 = btn2;

    self.gousiBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 53 + 50, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 53)];
    self.gousiBackView.userInteractionEnabled = NO;
    [self.view addSubview:self.gousiBackView];
    
    self.view1dianpingView = [[UIView alloc]initWithFrame:CGRectMake(0, btn1.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 100)];
    self.view1dianpingView.hidden = YES;
    [self.view addSubview:self.view1dianpingView];
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.gousiBackView.width, self.gousiBackView.height - 100)];
    imagv.image = DEF_IMAGE(@"article_2");
    imagv.userInteractionEnabled = YES;
    imagv.userInteractionEnabled = YES;
    imagv.contentMode = UIViewContentModeScaleAspectFit;
    [self.gousiBackView addSubview:imagv];
    
    UITextView *tv1 = [[UITextView alloc]initWithFrame:CGRectMake(120, 50, 190, 50)];
    tv1.text = self.tempM2061Arr[0][@"advice"];
    tv1.tag = 2001;
    tv1.delegate = self;
    tv1.font = DEF_MyFont(16);
    
    [imagv addSubview:tv1];
    
    UITextView *tv2 = [[UITextView alloc]initWithFrame:CGRectMake(120, tv1.bottom + 30, 190, 450)];
    tv2.text = self.tempM2061Arr[1][@"advice"];
    tv2.tag = 2002;
    tv2.delegate = self;
    tv2.font = DEF_MyFont(16);
    
    [imagv addSubview:tv2];
    
    UITextView *tv4 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 70, tv1.y + 10, 220, 70)];
    tv4.text = self.tempM2061Arr[2][@"advice"];
    tv4.tag = 2003;
    tv4.delegate = self;
    tv4.font = DEF_MyFont(16);
    
    [imagv addSubview:tv4];
    
    UITextView *tv5 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 40, tv4.bottom + 50, 120, 90)];
    tv5.text = self.tempM2061Arr[3][@"advice"];
    tv5.tag = 2004;
    tv5.delegate = self;
    tv5.font = DEF_MyFont(16);
    
    [imagv addSubview:tv5];
    
    UITextView *tv6 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 40, tv5.bottom + 60, 120, 90)];
    tv6.text = self.tempM2061Arr[4][@"advice"];
    tv6.tag = 2005;
    tv6.delegate = self;
    tv6.font = DEF_MyFont(16);
    
    [imagv addSubview:tv6];
    
    UITextView *tv7 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 40, tv6.bottom + 60, 120, 90)];
    tv7.text = self.tempM2061Arr[5][@"advice"];
    tv7.tag = 2006;
    tv7.delegate = self;
    tv7.font = DEF_MyFont(16);
    
    [imagv addSubview:tv7];
    
    UITextView *tv8 = [[UITextView alloc]initWithFrame:CGRectMake(tv7.right + 65, tv4.bottom + 50, 120, 90)];
    tv8.text = self.tempM2061Arr[6][@"advice"];
    tv8.tag = 2007;
    tv8.delegate = self;
    tv8.font = DEF_MyFont(16);
    
    [imagv addSubview:tv8];
    
    UITextView *tv9 = [[UITextView alloc]initWithFrame:CGRectMake(tv7.right + 65, tv8.bottom + 70, 120, 90)];
    tv9.text = self.tempM2061Arr[7][@"advice"];
    tv9.tag = 2008;
    tv9.delegate = self;
    tv9.font = DEF_MyFont(16);
    
    [imagv addSubview:tv9];
    
    UITextView *tv10 = [[UITextView alloc]initWithFrame:CGRectMake(tv7.right + 65, tv9.bottom + 70, 120, 90)];
    tv10.text = self.tempM2061Arr[8][@"advice"];
    tv10.tag = 2009;
    tv10.delegate = self;
    tv10.font = DEF_MyFont(16);
    
    [imagv addSubview:tv10];
    
    UITextView *tv11 = [[UITextView alloc]initWithFrame:CGRectMake(tv4.right + 140, tv1.y + 20, 150, 110)];
    tv11.text = self.tempM2061Arr[9][@"advice"];
    tv11.tag = 2010;
    tv11.delegate = self;
    tv11.font = DEF_MyFont(16);
    
    [imagv addSubview:tv11];
    
    UITextView *tv12 = [[UITextView alloc]initWithFrame:CGRectMake(tv4.right + 140, tv11.bottom + 60, 150, 110)];
    tv12.text = self.tempM2061Arr[10][@"advice"];
    tv12.tag = 2011;
    tv12.delegate = self;
    [imagv addSubview:tv12];
    
    UITextView *tv13 = [[UITextView alloc]initWithFrame:CGRectMake(tv4.right + 140, tv12.bottom + 60, 150, 110)];
    tv13.text = self.tempM2061Arr[11][@"advice"];
    tv13.tag = 2012;
    tv13.delegate = self;
    tv13.font = DEF_MyFont(16);
    
    [imagv addSubview:tv13];

}

-(void)loadview3
{
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH/2 - 115, 70, 115, 30)];
    btn1.layer.cornerRadius = 15;
    btn1.layer.borderWidth = 2;
    [btn1 setTitle:@"构思详情" forState:UIControlStateNormal];
    btn1.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(action1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    self.btn1 = btn1;
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.right, 70, 115, 30)];
    btn2.layer.cornerRadius = 15;
    btn2.layer.borderWidth = 2;
    [btn2 setTitle:@"点评详情" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor clearColor];
    btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(action2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    self.btn2 = btn2;

    self.gousiBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 53 + 50, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 53)];
    self.gousiBackView.userInteractionEnabled = NO;
    [self.view addSubview:self.gousiBackView];
    
    self.view1dianpingView = [[UIView alloc]initWithFrame:CGRectMake(0, btn1.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 100)];
    self.view1dianpingView.hidden = YES;
    [self.view addSubview:self.view1dianpingView];
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.gousiBackView.width, self.gousiBackView.height - 100)];
    imagv.image = DEF_IMAGE(@"article_4");
    imagv.userInteractionEnabled = YES;
    imagv.userInteractionEnabled = YES;
    imagv.contentMode = UIViewContentModeScaleAspectFit;
    [self.gousiBackView addSubview:imagv];
    
    UITextView *tv1 = [[UITextView alloc]initWithFrame:CGRectMake(120, 50, 190, 50)];
    tv1.text = self.tempM2061Arr[0][@"advice"];
    tv1.tag = 2001;
    tv1.delegate = self;
    tv1.font = DEF_MyFont(16);
    
    tv1.backgroundColor = [UIColor clearColor];
    [imagv addSubview:tv1];
    
    UITextView *tv2 = [[UITextView alloc]initWithFrame:CGRectMake(120, tv1.bottom + 30, 190, 450)];
    tv2.text = self.tempM2061Arr[1][@"advice"];
    tv2.tag = 2002;
    tv2.delegate = self;
    tv2.font = DEF_MyFont(16);
    tv2.backgroundColor = [UIColor clearColor];
    
    [imagv addSubview:tv2];
    
    UITextView *tv3 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 200, tv1.bottom + 180, 120, 120)];
    tv3.text = self.tempM2061Arr[2][@"advice"];
    tv3.tag = 2003;
    tv3.delegate = self;
    tv3.font = DEF_MyFont(16);
    tv3.backgroundColor = [UIColor clearColor];
    [imagv addSubview:tv3];
    
    UITextView *tv4 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.x, tv3.y - 160, 120, 120)];
    tv4.text = self.tempM2061Arr[3][@"advice"];
    tv4.tag = 2004;
    tv4.delegate = self;
    tv4.font = DEF_MyFont(16);
    tv4.backgroundColor = [UIColor clearColor];
    
    [imagv addSubview:tv4];
    
    UITextView *tv5 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.x - 70, tv3.bottom + 40, 100, 100)];
    tv5.text = self.tempM2061Arr[4][@"advice"];
    tv5.tag = 2005;
    tv5.delegate = self;
    tv5.font = DEF_MyFont(16);
    tv5.backgroundColor = [UIColor clearColor];
    [imagv addSubview:tv5];
    
    UITextView *tv6 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.x + 80, tv3.bottom + 40, 100, 100)];
    tv6.text = self.tempM2061Arr[5][@"advice"];
    tv6.tag = 2006;
    tv6.delegate = self;
    tv6.font = DEF_MyFont(16);
    tv6.backgroundColor = [UIColor clearColor];
    [imagv addSubview:tv6];
    
    UITextView *tv7 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.x - 130, tv3.y - 10, 100, 100)];
    tv7.text = self.tempM2061Arr[6][@"advice"];
    tv7.tag = 2007;
    tv7.delegate = self;
    tv7.font = DEF_MyFont(16);
    tv7.backgroundColor = [UIColor clearColor];
    [imagv addSubview:tv7];
    
    UITextView *tv8 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.right + 30, tv3.y - 10, 100, 100)];
    tv8.text = self.tempM2061Arr[7][@"advice"];
    tv8.tag = 2008;
    tv8.delegate = self;
    tv8.font = DEF_MyFont(16);
    tv8.backgroundColor = [UIColor clearColor];
    [imagv addSubview:tv8];
    
    UITextView *tv9 = [[UITextView alloc]initWithFrame:CGRectMake(tv8.right - 20, tv1.y + 20, 150, 110)];
    tv9.text = self.tempM2061Arr[8][@"advice"];
    tv9.tag = 2009;
    tv9.delegate = self;
    tv9.font = DEF_MyFont(16);
    tv9.backgroundColor = [UIColor clearColor];
    [imagv addSubview:tv9];
    
    UITextView *tv10 = [[UITextView alloc]initWithFrame:CGRectMake(tv8.right - 20, tv8.bottom + 30, 150, 110)];
    tv10.text = self.tempM2061Arr[9][@"advice"];
    tv10.tag = 2010;
    tv10.delegate = self;
    tv10.font = DEF_MyFont(16);
    tv10.backgroundColor = [UIColor clearColor];
    [imagv addSubview:tv10];

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
                            @"sign"             :[CACUtility getSignWithMethod:@"M2062"]};
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
