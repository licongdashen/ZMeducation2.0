//
//  LiuLanViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/13.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "LiuLanViewController.h"
#import "dianpingliulanCell.h"
#import "LiuLanDetailViewController.h"
#import "GouSiDetailViewController.h"
#import "WenGaoDetailViewController.h"

@interface LiuLanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableDictionary *userInfo;
@property (nonatomic, strong)UITableView *tav;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) UIView *view4;
@property (nonatomic, strong) UIView *view5;

@property (nonatomic, strong) UITableView *tabv1;

@property (nonatomic, weak)UIButton *selBtn;

@property (nonatomic, weak)UILabel *selLb;

@property (nonatomic, strong) NSMutableArray *M2005Arr;

@property (nonatomic, strong) NSMutableDictionary *M2005dic;

@property (nonatomic, strong) UITableView *view3tabv;

@property (nonatomic, strong) NSMutableArray *M2073Arr;

@end

@implementation LiuLanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [DEF_UserDefaults objectForKey:SAVE_USERINFO];

    self.titleArr = @[@"构思浏览",@"文稿浏览",@"我的点评",@"收藏浏览",@"发布浏览"];
    
    self.tav = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 175, self.view.height - 95) style:UITableViewStylePlain];
    self.tav.delegate = self;
    self.tav.dataSource = self;
    self.tav.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tav];
    
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height - 95)];
    self.view1.hidden = YES;
    [self.view addSubview:self.view1];

    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height - 95)];
    self.view2.hidden = YES;
    [self.view addSubview:self.view2];
    
    self.view3 = [[UIView alloc]initWithFrame:CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height - 95)];
    self.view3.hidden = YES;
    [self.view addSubview:self.view3];
    
    self.view4 = [[UIView alloc]initWithFrame:CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height - 95)];
    self.view4.hidden = YES;
    [self.view addSubview:self.view4];
    
    self.view5 = [[UIView alloc]initWithFrame:CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height - 95)];
    self.view5.hidden = YES;
    [self.view addSubview:self.view5];
    
}

-(void)loadview1
{
    for (UIView *view in [self.view1 subviews]) {
        [view removeFromSuperview];
    }
    
    UILabel *TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(40, 50, 150, 20)];
    TitleLb.text = @"请选择课程姓名  :";
    [self.view1 addSubview:TitleLb];
    
    UIButton *selBtn = [[UIButton alloc]initWithFrame:CGRectMake(TitleLb.right + 15, 45, 280, 30)];
    [selBtn setImage:DEF_IMAGE(@"luntan_xuanze") forState:UIControlStateNormal];
    [selBtn addTarget:self action:@selector(sel1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view1 addSubview:selBtn];
    self.selBtn = selBtn;
    
    UILabel *selLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 280 - 30, 30)];
    selLb.userInteractionEnabled = NO;
    [selBtn addSubview:selLb];
    self.selLb = selLb;
    
    self.tabv1 = [[UITableView alloc]initWithFrame:CGRectMake(selBtn.x, selBtn.bottom, selBtn.width, 300) style:UITableViewStylePlain];
    self.tabv1.delegate = self;
    self.tabv1.dataSource = self;
    self.tabv1.backgroundColor = [UIColor whiteColor];
    self.tabv1.hidden = YES;
    [self.view1 addSubview:self.tabv1];
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(10, selBtn.bottom + 10, self.view1.width - 20, self.view1.height - selBtn.bottom - 20)];
    imagv.image = DEF_IMAGE(@"liulan_beijing");
    imagv.userInteractionEnabled = YES;
    [self.view1 addSubview:imagv];
    
    self.view3tabv = [[UITableView alloc]initWithFrame:CGRectMake(20, selBtn.bottom + 20, self.view1.width - 40, self.view1.height - selBtn.bottom - 40) style:UITableViewStylePlain];
    self.view3tabv.delegate = self;
    self.view3tabv.dataSource = self;
    self.view3tabv.backgroundColor = [UIColor clearColor];
    self.view3tabv.hidden = YES;
    self.view3tabv.layer.cornerRadius = 12;
    [self.view1 addSubview:self.view3tabv];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view3tabv.width, 34)];
    view.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    self.view3tabv.tableHeaderView = view;
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 34)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.text = @"提交时间";
    [view addSubview:label1];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(label1.right, 3, 1, 28)];
    line1.backgroundColor = [UIColor whiteColor];
    [view addSubview:line1];
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(line1.right, 0, 125, 34)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    label2.text = @"模块名称";
    [view addSubview:label2];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(label2.right, 3, 1, 28)];
    line2.backgroundColor = [UIColor whiteColor];
    [view addSubview:line2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(line2.right, 0, 75, 34)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = [UIColor whiteColor];
    label3.text = @"提交人";
    [view addSubview:label3];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(label3.right, 3, 1, 28)];
    line3.backgroundColor = [UIColor whiteColor];
    [view addSubview:line3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(line3.right, 0, 140, 34)];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.textColor = [UIColor whiteColor];
    label4.text = @"课程名称";
    [view addSubview:label4];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(label4.right, 3, 1, 28)];
    line4.backgroundColor = [UIColor whiteColor];
    [view addSubview:line4];
    
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(line4.right, 0, 100, 34)];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.textColor = [UIColor whiteColor];
    label5.text = @"";
    [view addSubview:label5];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(label5.right, 3, 1, 28)];
    line5.backgroundColor = [UIColor clearColor];
    [view addSubview:line5];
    
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(line5.right, 0, 100, 34)];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.textColor = [UIColor whiteColor];
    label6.text = @"点评数量";
    [view addSubview:label6];
    
    UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(label6.right, 3, 1, 28)];
    line6.backgroundColor = [UIColor whiteColor];
    [view addSubview:line6];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(line6.right, 0, 110, 34)];
    label7.textAlignment = NSTextAlignmentCenter;
    label7.textColor = [UIColor whiteColor];
    label7.text = @"操作";
    [view addSubview:label7];
    
    UIButton *chaxunBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view1.width - 130, 45, 90, 30)];
    [chaxunBtn setImage:DEF_IMAGE(@"luntan_chaxun") forState:UIControlStateNormal];
    [chaxunBtn addTarget:self action:@selector(chaxun1) forControlEvents:UIControlEventTouchUpInside];
    [self.view1 addSubview:chaxunBtn];
    
    NSDictionary * dic4;
    if ([self.userInfo[@"role"] isEqualToString:@"04"]) {
        dic4 = @{@"version"         :@"2.0.0",
                 @"clientType"       :@"1001",
                 @"signType"         :@"md5",
                 @"timestamp"        :[CACUtility getNowTime],
                 @"method"           :@"M2005",
                 @"userId"           :self.userInfo[@"userId"],
                 @"gradeId"          :self.userInfo[@"gradeId"],
                 @"classId"          :self.userInfo[@"classId"],
                 @"courseId"         :self.userInfo[@"courseId"],
                 @"typeId"           :self.userInfo[@"currentTypeId"],
                 @"sign"             :[CACUtility getSignWithMethod:@"M2005"]};
        
    }else{
        dic4 = @{@"version"         :@"2.0.0",
                 @"clientType"       :@"1001",
                 @"signType"         :@"md5",
                 @"timestamp"        :[CACUtility getNowTime],
                 @"method"           :@"M2005",
                 @"userId"           :self.userInfo[@"userId"],
                 @"gradeId"          :self.userInfo[@"gradeId"],
                 @"classId"          :self.userInfo[@"classId"],
                 @"courseId"         :self.userInfo[@"courseId"],
                 @"typeId"           :@"2",
                 @"sign"             :[CACUtility getSignWithMethod:@"M2005"]};
    }
    
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        self.M2005Arr = result[@"courses"];
        self.selLb.text = self.M2005Arr[0][@"courseName"];
        self.M2005dic = self.M2005Arr[0];
        [self.tabv1 reloadData];
    } failture:^(id result) {
        
    }];

}

-(void)loadview2
{
    for (UIView *view in [self.view2 subviews]) {
        [view removeFromSuperview];
    }

    UILabel *TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(40, 50, 150, 20)];
    TitleLb.text = @"请选择课程姓名  :";
    [self.view2 addSubview:TitleLb];
    
    UIButton *selBtn = [[UIButton alloc]initWithFrame:CGRectMake(TitleLb.right + 15, 45, 280, 30)];
    [selBtn setImage:DEF_IMAGE(@"luntan_xuanze") forState:UIControlStateNormal];
    [selBtn addTarget:self action:@selector(sel1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view2 addSubview:selBtn];
    self.selBtn = selBtn;
    
    UILabel *selLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 280 - 30, 30)];
    selLb.userInteractionEnabled = NO;
    [selBtn addSubview:selLb];
    self.selLb = selLb;
    
    self.tabv1 = [[UITableView alloc]initWithFrame:CGRectMake(selBtn.x, selBtn.bottom, selBtn.width, 300) style:UITableViewStylePlain];
    self.tabv1.delegate = self;
    self.tabv1.dataSource = self;
    self.tabv1.backgroundColor = [UIColor whiteColor];
    self.tabv1.hidden = YES;
    [self.view2 addSubview:self.tabv1];
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(10, selBtn.bottom + 10, self.view2.width - 20, self.view2.height - selBtn.bottom - 20)];
    imagv.image = DEF_IMAGE(@"liulan_beijing");
    imagv.userInteractionEnabled = YES;
    [self.view2 addSubview:imagv];
    
    self.view3tabv = [[UITableView alloc]initWithFrame:CGRectMake(20, selBtn.bottom + 20, self.view2.width - 40, self.view2.height - selBtn.bottom - 40) style:UITableViewStylePlain];
    self.view3tabv.delegate = self;
    self.view3tabv.dataSource = self;
    self.view3tabv.backgroundColor = [UIColor clearColor];
    self.view3tabv.hidden = YES;
    self.view3tabv.layer.cornerRadius = 12;
    [self.view2 addSubview:self.view3tabv];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view3tabv.width, 34)];
    view.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    self.view3tabv.tableHeaderView = view;
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 34)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.text = @"提交时间";
    [view addSubview:label1];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(label1.right, 3, 1, 28)];
    line1.backgroundColor = [UIColor whiteColor];
    [view addSubview:line1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(line1.right, 0, 125, 34)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    label2.text = @"模块名称";
    [view addSubview:label2];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(label2.right, 3, 1, 28)];
    line2.backgroundColor = [UIColor whiteColor];
    [view addSubview:line2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(line2.right, 0, 75, 34)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = [UIColor whiteColor];
    label3.text = @"提交人";
    [view addSubview:label3];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(label3.right, 3, 1, 28)];
    line3.backgroundColor = [UIColor whiteColor];
    [view addSubview:line3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(line3.right, 0, 140, 34)];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.textColor = [UIColor whiteColor];
    label4.text = @"课程名称";
    [view addSubview:label4];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(label4.right, 3, 1, 28)];
    line4.backgroundColor = [UIColor whiteColor];
    [view addSubview:line4];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(line4.right, 0, 100, 34)];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.textColor = [UIColor whiteColor];
    label5.text = @"";
    [view addSubview:label5];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(label5.right, 3, 1, 28)];
    line5.backgroundColor = [UIColor clearColor];
    [view addSubview:line5];
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(line5.right, 0, 100, 34)];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.textColor = [UIColor whiteColor];
    label6.text = @"点评数量";
    [view addSubview:label6];
    
    UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(label6.right, 3, 1, 28)];
    line6.backgroundColor = [UIColor whiteColor];
    [view addSubview:line6];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(line6.right, 0, 110, 34)];
    label7.textAlignment = NSTextAlignmentCenter;
    label7.textColor = [UIColor whiteColor];
    label7.text = @"操作";
    [view addSubview:label7];
    
    UIButton *chaxunBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view2.width - 130, 45, 90, 30)];
    [chaxunBtn setImage:DEF_IMAGE(@"luntan_chaxun") forState:UIControlStateNormal];
    [chaxunBtn addTarget:self action:@selector(chaxun2) forControlEvents:UIControlEventTouchUpInside];
    [self.view2 addSubview:chaxunBtn];
    
    NSDictionary * dic4;
    if ([self.userInfo[@"role"] isEqualToString:@"04"]) {
        dic4 = @{@"version"         :@"2.0.0",
                 @"clientType"       :@"1001",
                 @"signType"         :@"md5",
                 @"timestamp"        :[CACUtility getNowTime],
                 @"method"           :@"M2005",
                 @"userId"           :self.userInfo[@"userId"],
                 @"gradeId"          :self.userInfo[@"gradeId"],
                 @"classId"          :self.userInfo[@"classId"],
                 @"courseId"         :self.userInfo[@"courseId"],
                 @"typeId"           :self.userInfo[@"currentTypeId"],
                 @"sign"             :[CACUtility getSignWithMethod:@"M2005"]};
        
    }else{
        dic4 = @{@"version"         :@"2.0.0",
                 @"clientType"       :@"1001",
                 @"signType"         :@"md5",
                 @"timestamp"        :[CACUtility getNowTime],
                 @"method"           :@"M2005",
                 @"userId"           :self.userInfo[@"userId"],
                 @"gradeId"          :self.userInfo[@"gradeId"],
                 @"classId"          :self.userInfo[@"classId"],
                 @"courseId"         :self.userInfo[@"courseId"],
                 @"typeId"           :@"2",
                 @"sign"             :[CACUtility getSignWithMethod:@"M2005"]};
    }
    
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        self.M2005Arr = result[@"courses"];
        self.selLb.text = self.M2005Arr[0][@"courseName"];
        self.M2005dic = self.M2005Arr[0];
        [self.tabv1 reloadData];
    } failture:^(id result) {
        
    }];

}

-(void)loadview3
{
    for (UIView *view in [self.view3 subviews]) {
        [view removeFromSuperview];
    }

    UILabel *TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(40, 50, 150, 20)];
    TitleLb.text = @"请选择课程姓名  :";
    [self.view3 addSubview:TitleLb];
    
    UIButton *selBtn = [[UIButton alloc]initWithFrame:CGRectMake(TitleLb.right + 15, 45, 280, 30)];
    [selBtn setImage:DEF_IMAGE(@"luntan_xuanze") forState:UIControlStateNormal];
    [selBtn addTarget:self action:@selector(sel1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view3 addSubview:selBtn];
    self.selBtn = selBtn;
    
    UILabel *selLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 280 - 30, 30)];
    selLb.userInteractionEnabled = NO;
    [selBtn addSubview:selLb];
    self.selLb = selLb;
    
    self.tabv1 = [[UITableView alloc]initWithFrame:CGRectMake(selBtn.x, selBtn.bottom, selBtn.width, 300) style:UITableViewStylePlain];
    self.tabv1.delegate = self;
    self.tabv1.dataSource = self;
    self.tabv1.backgroundColor = [UIColor whiteColor];
    self.tabv1.hidden = YES;
    [self.view3 addSubview:self.tabv1];
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(10, selBtn.bottom + 10, self.view3.width - 20, self.view3.height - selBtn.bottom - 20)];
    imagv.image = DEF_IMAGE(@"liulan_beijing");
    imagv.userInteractionEnabled = YES;
    [self.view3 addSubview:imagv];
    
    self.view3tabv = [[UITableView alloc]initWithFrame:CGRectMake(20, selBtn.bottom + 20, self.view3.width - 40, self.view3.height - selBtn.bottom - 40) style:UITableViewStylePlain];
    self.view3tabv.delegate = self;
    self.view3tabv.dataSource = self;
    self.view3tabv.backgroundColor = [UIColor clearColor];
    self.view3tabv.hidden = YES;
    self.view3tabv.layer.cornerRadius = 12;
    [self.view3 addSubview:self.view3tabv];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view3tabv.width, 34)];
    view.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    self.view3tabv.tableHeaderView = view;
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 34)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.text = @"提交时间";
    [view addSubview:label1];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(label1.right, 3, 1, 28)];
    line1.backgroundColor = [UIColor whiteColor];
    [view addSubview:line1];
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(line1.right, 0, 125, 34)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    label2.text = @"模块名称";
    [view addSubview:label2];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(label2.right, 3, 1, 28)];
    line2.backgroundColor = [UIColor whiteColor];
    [view addSubview:line2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(line2.right, 0, 75, 34)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = [UIColor whiteColor];
    label3.text = @"提交人";
    [view addSubview:label3];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(label3.right, 3, 1, 28)];
    line3.backgroundColor = [UIColor whiteColor];
    [view addSubview:line3];

    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(line3.right, 0, 140, 34)];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.textColor = [UIColor whiteColor];
    label4.text = @"课程名称";
    [view addSubview:label4];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(label4.right, 3, 1, 28)];
    line4.backgroundColor = [UIColor whiteColor];
    [view addSubview:line4];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(line4.right, 0, 100, 34)];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.textColor = [UIColor whiteColor];
    label5.text = @"";
    [view addSubview:label5];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(label5.right, 3, 1, 28)];
    line5.backgroundColor = [UIColor clearColor];
    [view addSubview:line5];
    
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(line5.right, 0, 100, 34)];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.textColor = [UIColor whiteColor];
    label6.text = @"状态";
    [view addSubview:label6];
    
    UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(label6.right, 3, 1, 28)];
    line6.backgroundColor = [UIColor whiteColor];
    [view addSubview:line6];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(line6.right, 0, 110, 34)];
    label7.textAlignment = NSTextAlignmentCenter;
    label7.textColor = [UIColor whiteColor];
    label7.text = @"操作";
    [view addSubview:label7];

    
    UIButton *chaxunBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view3.width - 130, 45, 90, 30)];
    [chaxunBtn setImage:DEF_IMAGE(@"luntan_chaxun") forState:UIControlStateNormal];
    [chaxunBtn addTarget:self action:@selector(chaxun) forControlEvents:UIControlEventTouchUpInside];
    [self.view3 addSubview:chaxunBtn];

    NSDictionary * dic4;
    if ([self.userInfo[@"role"] isEqualToString:@"04"]) {
        dic4 = @{@"version"         :@"2.0.0",
                @"clientType"       :@"1001",
                @"signType"         :@"md5",
                @"timestamp"        :[CACUtility getNowTime],
                @"method"           :@"M2005",
                @"userId"           :self.userInfo[@"userId"],
                @"gradeId"          :self.userInfo[@"gradeId"],
                @"classId"          :self.userInfo[@"classId"],
                @"courseId"         :self.userInfo[@"courseId"],
                @"typeId"           :self.userInfo[@"currentTypeId"],
                @"sign"             :[CACUtility getSignWithMethod:@"M2005"]};

    }else{
        dic4 = @{@"version"         :@"2.0.0",
                 @"clientType"       :@"1001",
                 @"signType"         :@"md5",
                 @"timestamp"        :[CACUtility getNowTime],
                 @"method"           :@"M2005",
                 @"userId"           :self.userInfo[@"userId"],
                 @"gradeId"          :self.userInfo[@"gradeId"],
                 @"classId"          :self.userInfo[@"classId"],
                 @"courseId"         :self.userInfo[@"courseId"],
                 @"typeId"           :@"2",
                 @"sign"             :[CACUtility getSignWithMethod:@"M2005"]};
    }
    
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        self.M2005Arr = result[@"courses"];
        self.selLb.text = self.M2005Arr[0][@"courseName"];
        self.M2005dic = self.M2005Arr[0];
        [self.tabv1 reloadData];
    } failture:^(id result) {
        
    }];
}

-(void)sel1:(UIButton *)sender
{
    [self.view3 bringSubviewToFront:self.tabv1];
    [self.view2 bringSubviewToFront:self.tabv1];
    [self.view1 bringSubviewToFront:self.tabv1];

    if (self.tabv1.hidden == YES) {
        self.tabv1.hidden = NO;
    }else{
        self.tabv1.hidden = YES;
    }

}

-(void)chaxun
{
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2073",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.M2005dic[@"courseId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2073"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        self.M2073Arr = result[@"myFeedbacks"];
        self.view3tabv.hidden = NO;

        [self.view3tabv reloadData];
        
    } failture:^(id result) {
        
    }];
}

-(void)chaxun1
{
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2063",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.M2005dic[@"courseId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2063"],
                            @"type"             :@"1"};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        self.M2073Arr = result[@"contents"];
        self.view3tabv.hidden = NO;
        
        [self.view3tabv reloadData];
        
    } failture:^(id result) {
        
    }];

}

-(void)chaxun2
{
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2063",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.M2005dic[@"courseId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2063"],
                            @"type"             :@"2"};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        self.M2073Arr = result[@"contents"];
        self.view3tabv.hidden = NO;
        
        [self.view3tabv reloadData];
        
    } failture:^(id result) {
        
    }];

}

-(void)loadview4
{
    for (UIView *view in [self.view4 subviews]) {
        [view removeFromSuperview];
    }

}

-(void)loadview5
{
    for (UIView *view in [self.view5 subviews]) {
        [view removeFromSuperview];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 1)];
    foot.alpha = 0.0f;
    return foot;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView == self.tav) {
        return 55;

    }else if (tableView == self.tabv1){
    
        return 55;
    }else if (tableView == self.view3tabv){
    
        return 40;
    }
    
    return 100;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.tav) {
        return [self.titleArr count];

    }else if (tableView == self.tabv1){
        return [self.M2005Arr count];
    }else if (tableView == self.view3tabv){
    
        return self.M2073Arr.count;
    }
    return 0;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //理财推荐
    
    if (tableView == self.tav) {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        cell.textLabel.text = self.titleArr[indexPath.row];
        cell.textLabel.textColor = DEF_COLOR_RGB(58, 62, 62);
        
        return cell;

    }else if (tableView == self.tabv1){
        static NSString *CellIdentifier = @"Cell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        cell.textLabel.text = self.M2005Arr[indexPath.row][@"courseName"];
        
        return cell;

    }else if (tableView == self.view3tabv){
    
        static NSString *CellIdentifier = @"Cell2";
        
        dianpingliulanCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[dianpingliulanCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 34)];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.textColor = [UIColor blackColor];
            label1.tag = 201;
            label1.adjustsFontSizeToFitWidth = YES;
            [cell addSubview:label1];
            
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(label1.right, 0, 125, 34)];
            label2.textAlignment = NSTextAlignmentCenter;
            label2.textColor = [UIColor blackColor];
            label2.tag = 202;
            label2.adjustsFontSizeToFitWidth = YES;
            [cell addSubview:label2];
            
            UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(label2.right, 0, 75, 34)];
            label3.textAlignment = NSTextAlignmentCenter;
            label3.textColor = [UIColor blackColor];
            label3.tag = 203;
            label3.adjustsFontSizeToFitWidth = YES;
            [cell addSubview:label3];
            
            UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(label3.right, 0, 140, 34)];
            label4.textAlignment = NSTextAlignmentCenter;
            label4.textColor = [UIColor blackColor];
            label4.tag = 204;
            label4.adjustsFontSizeToFitWidth = YES;
            [cell addSubview:label4];
            
            UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(label4.right, 0, 100, 34)];
            label5.textAlignment = NSTextAlignmentCenter;
            label5.textColor = [UIColor blackColor];
            label5.tag = 205;
            label5.adjustsFontSizeToFitWidth = YES;
            [cell addSubview:label5];
            
            UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(label5.right, 0, 100, 34)];
            label6.textAlignment = NSTextAlignmentCenter;
            label6.textColor = [UIColor blackColor];
            label6.tag = 206;
            label6.adjustsFontSizeToFitWidth = YES;
            [cell addSubview:label6];
            
        }
        if (self.view3.hidden == NO) {
            NSMutableDictionary *dic = self.M2073Arr[indexPath.row];
            UILabel *label1 = [cell viewWithTag:201];
            label1.text = dic[@"commitTime"];
            
            UILabel *label2 = [cell viewWithTag:202];
            label2.text = dic[@"unit"];
            
            UILabel *label3 = [cell viewWithTag:203];
            label3.text = dic[@"author"];
            
            UILabel *label4 = [cell viewWithTag:204];
            label4.text = dic[@"unit"];
            
            UILabel *label5 = [cell viewWithTag:205];
            label5.text = dic[@"module"];
            
            UILabel *label6 = [cell viewWithTag:206];
            label6.text = dic[@"status"];
            
            cell.selBtn.tag = 1000 + indexPath.row;
            [cell.selBtn addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];

        }else if (self.view1.hidden == NO){
            NSMutableDictionary *dic = self.M2073Arr[indexPath.row];
            UILabel *label1 = [cell viewWithTag:201];
            label1.text = dic[@"lastUpdateTime"];
            
            UILabel *label2 = [cell viewWithTag:202];
            label2.text = dic[@"unitName"];
            
            UILabel *label3 = [cell viewWithTag:203];
            label3.text = dic[@"authorName"];
            
            UILabel *label4 = [cell viewWithTag:204];
            label4.text = dic[@"unitName"];
            
            UILabel *label5 = [cell viewWithTag:205];
            label5.text = dic[@"module"];
            
            UILabel *label6 = [cell viewWithTag:206];
            label6.text = [NSString stringWithFormat:@"%@",dic[@"feedbackCount"]];
            
            cell.selBtn.tag = 1000 + indexPath.row;
            [cell.selBtn addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];

        }else if (self.view2.hidden == NO){
        
            NSMutableDictionary *dic = self.M2073Arr[indexPath.row];
            UILabel *label1 = [cell viewWithTag:201];
            label1.text = dic[@"lastUpdateTime"];
            
            UILabel *label2 = [cell viewWithTag:202];
            label2.text = dic[@"unitName"];
            
            UILabel *label3 = [cell viewWithTag:203];
            label3.text = dic[@"authorName"];
            
            UILabel *label4 = [cell viewWithTag:204];
            label4.text = dic[@"unitName"];
            
            UILabel *label5 = [cell viewWithTag:205];
            label5.text = dic[@"module"];
            
            UILabel *label6 = [cell viewWithTag:206];
            label6.text = [NSString stringWithFormat:@"%@",dic[@"feedbackCount"]];
            
            cell.selBtn.tag = 1000 + indexPath.row;
            [cell.selBtn addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;

    }
    
    static NSString *CellIdentifier = @"Cellq";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;

}

-(void)detail:(UIButton *)sender
{
    if (self.view3.hidden == NO) {
        
        int tag = (int)sender.tag - 1000;
        
        NSMutableDictionary *dic = self.M2073Arr[tag];
        
        LiuLanDetailViewController *vc = [[LiuLanDetailViewController alloc]init];
        vc.dic = dic;
        
        [self.navigationController pushViewController:vc animated:YES];

    }else if (self.view1.hidden == NO){
        int tag = (int)sender.tag - 1000;
        
        NSMutableDictionary *dic = self.M2073Arr[tag];
        
        GouSiDetailViewController *vc = [[GouSiDetailViewController alloc]init];
        vc.dic = dic;
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.view2.hidden == NO){
        int tag = (int)sender.tag - 1000;
        
        NSMutableDictionary *dic = self.M2073Arr[tag];
        
         WenGaoDetailViewController*vc = [[WenGaoDetailViewController alloc]init];
         vc.dic = dic;
        [self.navigationController pushViewController:vc animated:YES];

    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tav) {
        if (indexPath.row == 0) {
            
            self.view1.hidden = NO;
            self.view2.hidden = YES;
            self.view3.hidden = YES;
            self.view4.hidden = YES;
            self.view5.hidden = YES;
            
            [self loadview1];
            
        }else if (indexPath.row == 1){
            self.view1.hidden = YES;
            self.view2.hidden = NO;
            self.view3.hidden = YES;
            self.view4.hidden = YES;
            self.view5.hidden = YES;
            
            [self loadview2];
            
        }else if (indexPath.row == 2){
            self.view1.hidden = YES;
            self.view2.hidden = YES;
            self.view3.hidden = NO;
            self.view4.hidden = YES;
            self.view5.hidden = YES;
            
            [self loadview3];
            
        }else if (indexPath.row == 3) {
            self.view1.hidden = YES;
            self.view2.hidden = YES;
            self.view3.hidden = YES;
            self.view4.hidden = NO;
            self.view5.hidden = YES;
            
            [self loadview4];
            
        }else{
            self.view1.hidden = YES;
            self.view2.hidden = YES;
            self.view3.hidden = YES;
            self.view4.hidden = YES;
            self.view5.hidden = NO;
            
            [self loadview5];
            
        }

    }else if (tableView == self.tabv1){
        
        self.selLb.text = self.M2005Arr[indexPath.row][@"courseName"];

        self.tabv1.hidden = YES;
        
        self.M2005dic = self.M2005Arr[indexPath.row];
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
