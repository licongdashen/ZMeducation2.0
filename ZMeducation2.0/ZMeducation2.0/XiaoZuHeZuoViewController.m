//
//  XiaoZuHeZuoViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/24.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "XiaoZuHeZuoViewController.h"

@interface XiaoZuHeZuoViewController ()

@property (nonatomic, strong)NSMutableDictionary *userInfo;
@property (nonatomic, weak) UIImageView *bgImagv;
@property (nonatomic, strong)UISegmentedControl *seg;

@property (nonatomic, weak)UIView *view1;
@property (nonatomic, weak)UIView *view2;
@property (nonatomic, weak)UIView *view3;
@property (nonatomic, weak)UIView *view4;

@property (nonatomic, weak)UILabel *titleLb;
@property (nonatomic, weak)UILabel *title1Lb;
@property (nonatomic, weak)UITextView *tv;

@end

@implementation XiaoZuHeZuoViewController

-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.dic = dic;
    }
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [DEF_UserDefaults objectForKey:SAVE_USERINFO];
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    [self.bgImagv removeFromSuperview];
    
    UIImageView *bgImagv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, DEF_DEVICE_WIDTH - 30 - 175, DEF_DEVICE_HEIGHT - 30 - 95)];
    bgImagv.image = DEF_IMAGE(@"tiankongti_Bg");
    bgImagv.userInteractionEnabled = YES;
    [self.view addSubview:bgImagv];
    self.bgImagv = bgImagv;

    UIImageView *imageTitle = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 80, 30)];
    imageTitle.contentMode = UIViewContentModeScaleAspectFit;
    imageTitle.image = DEF_IMAGE(@"xiaozuhezuo_title");
    imageTitle.centerX = bgImagv.centerX;
    [bgImagv addSubview:imageTitle];

    NSArray *arr = @[@"合作内容填写",@"合作小组浏览",@"合作分项浏览",@"合作文稿生成"];
    self.seg = [[UISegmentedControl alloc]initWithItems:arr];
    self.seg.frame = CGRectMake(35, 65, 500, 35);
    self.seg.selectedSegmentIndex = 0;
    self.seg.tintColor = DEF_COLOR_RGB(0, 154, 221);
    [bgImagv addSubview:self.seg];
    [self.seg addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];

    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.seg.bottom, bgImagv.width, bgImagv.height - 65)];
    [bgImagv addSubview:view1];
    self.view1 = view1;
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.seg.bottom, bgImagv.width, bgImagv.height - 65)];
    view2.hidden = YES;
    [bgImagv addSubview:view2];
    self.view2 = view2;

    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, self.seg.bottom, bgImagv.width, bgImagv.height - 65)];
    view3.hidden = YES;
    [bgImagv addSubview:view3];
    self.view3 = view3;

    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, self.seg.bottom, bgImagv.width, bgImagv.height - 65)];
    view4.hidden = YES;
    [bgImagv addSubview:view4];
    self.view4 = view4;

    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(35, 15, view1.width - 35, 18)];
    titleLb.text = @"主题:";
    [self.view1 addSubview:titleLb];
    self.titleLb = titleLb;
    
    UILabel *title1Lb = [[UILabel alloc]initWithFrame:CGRectMake(35, titleLb.bottom + 23, view1.width - 35, 18)];
    title1Lb.text = @"分项:";
    [self.view1 addSubview:title1Lb];
    self.title1Lb = title1Lb;
    
    UILabel *titleLb2 = [[UILabel alloc]initWithFrame:CGRectMake(35, title1Lb.bottom + 25, 44, 18)];
    titleLb2.text = @"内容:";
    [self.view1 addSubview:titleLb2];

    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(80, title1Lb.bottom + 25, 700, 360)];
    imagv.userInteractionEnabled = YES;
    imagv.image = DEF_IMAGE(@"hezuo_beijing");
    [self.view1 addSubview:imagv];
    
    UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, imagv.width - 20, imagv.height - 20)];
    [imagv addSubview:tv];
    self.tv = tv;
    
    UIButton *tijiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, imagv.bottom + 30, 180, 30)];
    tijiaoBtn.centerX = bgImagv.centerX;
    [tijiaoBtn setImage:DEF_IMAGE(@"tiankongti_tijiao") forState:UIControlStateNormal];
    [tijiaoBtn addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view1 addSubview:tijiaoBtn];

    
    NSDictionary * dic1 = @{@"version"         :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M241",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M241"]};
    [RequestOperationManager getParametersDic:dic1 success:^(NSMutableDictionary *result) {
        
        titleLb.text = [NSString stringWithFormat:@"主题:  %@",result[@"optionTitle"]];
        
        title1Lb.text = [NSString stringWithFormat:@"分项:  %@",result[@"content"]];

    } failture:^(id result) {
        
    }];

}

-(void)tijiao
{
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M242",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"content"          :self.tv.text,
                           @"sign"             :[CACUtility getSignWithMethod:@"M242"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        if ([result[@"responseCode"] isEqualToString:@"00"]) {
            [CACUtility showTips:@"提交成功"];
        }else if ([result[@"responseCode"] isEqualToString:@"96"]){
            [CACUtility showTips:result[@"responseMessage"]];
        }else{
            [CACUtility showTips:@"提交失败"];
        }
        
    } failture:^(id result) {
        [CACUtility showTips:@"提交失败"];
    }];
}


-(void)segmentAction:(UISegmentedControl *)Seg
{
    if (Seg.selectedSegmentIndex == 0) {
        self.view1.hidden = NO;
        self.view2.hidden = YES;
        self.view3.hidden = YES;
        self.view4.hidden = YES;
    }else if (Seg.selectedSegmentIndex == 1){
        self.view1.hidden = YES;
        self.view2.hidden = NO;
        self.view3.hidden = YES;
        self.view4.hidden = YES;
    }else if (Seg.selectedSegmentIndex == 2){
        self.view1.hidden = YES;
        self.view2.hidden = YES;
        self.view3.hidden = NO;
        self.view4.hidden = YES;
    }else if (Seg.selectedSegmentIndex == 3){
        self.view1.hidden = YES;
        self.view2.hidden = YES;
        self.view3.hidden = YES;
        self.view4.hidden = NO;
    }
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