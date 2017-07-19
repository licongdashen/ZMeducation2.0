//
//  JianDaTiViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/19.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "JianDaTiViewController.h"

@interface JianDaTiViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic, strong)NSMutableDictionary *result;

@property (nonatomic, weak) UILabel *tiwenLb;

@property (nonatomic, weak)UIImageView *tiwenScro;

@property (nonatomic, strong) UITableView *tabv;

@property (nonatomic, strong) NSMutableArray *chaxunArr;

@property (nonatomic, weak) UITextView *tv;

@end

@implementation JianDaTiViewController

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
    
    UIImageView *bgImagv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, self.view.width - 30 - 175, self.view.height - 30 - 95)];
    bgImagv.image = DEF_IMAGE(@"tiankongti_Bg");
    bgImagv.userInteractionEnabled = YES;
    [self.view addSubview:bgImagv];
    
    UIImageView *imageTitle = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 80, 30)];
    imageTitle.contentMode = UIViewContentModeScaleAspectFit;
    imageTitle.image = DEF_IMAGE(@"jiandati_title");
    imageTitle.centerX = bgImagv.centerX;
    [bgImagv addSubview:imageTitle];
    
    UIImageView *imagetouxiang = [[UIImageView alloc]initWithFrame:CGRectMake(35, 50, 65, 55)];
    imagetouxiang.contentMode = UIViewContentModeScaleAspectFit;
    imagetouxiang.image = DEF_IMAGE(@"tiankongti_touxiang");
    [bgImagv addSubview:imagetouxiang];
    
    UIImageView *imagetiwen = [[UIImageView alloc]initWithFrame:CGRectMake(imagetouxiang.right + 16, 50, 1354/2, 55)];
    imagetiwen.contentMode = UIViewContentModeScaleAspectFit;
    imagetiwen.image = DEF_IMAGE(@"tiankongti_tiwen");
    [bgImagv addSubview:imagetiwen];
    
    UILabel *tiwenLb = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, imagetiwen.width - 50, imagetiwen.height)];
    tiwenLb.font = DEF_MyFont(16);
    [imagetiwen addSubview:tiwenLb];
    self.tiwenLb = tiwenLb;
    
    UIImageView *tiwenScro = [[UIImageView alloc]initWithFrame:CGRectMake(35, imagetouxiang.bottom + 20, self.view.width - 30 - 175 - 70, 75)];
    tiwenScro.userInteractionEnabled = YES;
    tiwenScro.image = DEF_IMAGE(@"jiandati_shurukuang");
    [bgImagv addSubview:tiwenScro];
    self.tiwenScro = tiwenScro;
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 25, 18)];
    titleLb.text = @"答:";
    titleLb.font = DEF_MyFont(16);
    [tiwenScro addSubview:titleLb];
    
    UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(titleLb.right, 0, 700,55)];
    tv.backgroundColor = [UIColor clearColor];
    [tiwenScro addSubview:tv];
    self.tv = tv;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(55, tiwenScro.bottom + 15, 180, 30)];
    [btn setImage:DEF_IMAGE(@"tiankongti_tijiao") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(btn.right + 350, tiwenScro.bottom + 15, 180, 30)];
    [btn1 setImage:DEF_IMAGE(@"tiankongti_chaxun") forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(chaxun) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:btn1];
    
    self.tabv = [[UITableView alloc]initWithFrame:CGRectMake(25, btn.bottom + 15, self.view.width - 30 - 175 - 50, 350) style:UITableViewStylePlain];
    self.tabv.delegate = self;
    self.tabv.dataSource = self;
    self.tabv.backgroundColor = [UIColor clearColor];
    self.tabv.hidden = YES;
    self.tabv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgImagv addSubview:self.tabv];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tabv.width, 35)];
    self.tabv.tableHeaderView = view;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tabv.width, 2)];
    lineView.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [view addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 33, self.tabv.width, 2)];
    lineView1.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [view addSubview:lineView1];
    
    UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 60, 35)];
    nameLb.font = DEF_MyFont(17);
    nameLb.text = @"提交人";
    [view addSubview:nameLb];
    
    UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(317, 0, 80, 35)];
    contentLb.font = DEF_MyFont(17);
    contentLb.text = @"提交内容";
    [view addSubview:contentLb];
    
    UILabel *timeLb = [[UILabel alloc]initWithFrame:CGRectMake(640, 0, 80, 35)];
    timeLb.font = DEF_MyFont(17);
    timeLb.text = @"提交时间";
    [view addSubview:timeLb];
    
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M021",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M021"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        self.result = result;
        self.tiwenLb.text = self.result[@"title"];
        NSString *str = self.result[@"content"];
        tv.text = str;
        
    } failture:^(id result) {
        
    }];
}

-(void)tijiao
{
    
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M022",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"content"          :self.tv.text,
                           @"sign"             :[CACUtility getSignWithMethod:@"M022"]};
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

-(void)chaxun
{
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M023",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M023"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        self.chaxunArr = result[@"contents"];
        [self.tabv reloadData];
        self.tabv.hidden = NO;
    } failture:^(id result) {
        [CACUtility showTips:@"提交失败"];
    }];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.chaxunArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 69, self.tabv.width, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:lineView];
        
        UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 80, 70)];
        nameLb.font = DEF_MyFont(16);
        nameLb.numberOfLines = 3;
        nameLb.tag = 200;
        [cell.contentView addSubview:nameLb];
        
        UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(nameLb.right + 10, 0, 450, 70)];
        contentLb.font = DEF_MyFont(16);
        contentLb.numberOfLines = 3;
        contentLb.tag = 201;
        [cell.contentView addSubview:contentLb];
        
        UILabel *timeLb = [[UILabel alloc]initWithFrame:CGRectMake(contentLb.right + 20, 0, 140, 70)];
        timeLb.font = DEF_MyFont(16);
        timeLb.numberOfLines = 3;
        timeLb.tag = 202;
        [cell.contentView addSubview:timeLb];
        
    }
    UILabel *nameLb = [cell.contentView viewWithTag:200];
    nameLb.text = self.chaxunArr[indexPath.row][@"authorName"];
    
    UILabel *contentLb = [cell.contentView viewWithTag:201];
    contentLb.text = self.chaxunArr[indexPath.row][@"content"];
    
    UILabel *timeLb = [cell.contentView viewWithTag:202];
    timeLb.text = self.chaxunArr[indexPath.row][@"lastUpdateTime"];
    
    return cell;
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
