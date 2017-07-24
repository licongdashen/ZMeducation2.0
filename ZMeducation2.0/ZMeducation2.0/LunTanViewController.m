//
//  LunTanViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/20.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "LunTanViewController.h"
#import "LunTanCell.h"

@interface LunTanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic, strong)NSMutableDictionary *result;
@property (nonatomic, weak) UIImageView *bgImagv;

@property (nonatomic, strong)UITableView *tabv;

@property (nonatomic, strong)NSMutableArray *m007Arr;

@property (nonatomic, strong)NSMutableDictionary *m007Dic;

@property (nonatomic, weak)UIButton *selBtn;

@property (nonatomic, weak)UILabel *selLb;

@property (nonatomic, strong)NSMutableDictionary *M031Dic;

@property (nonatomic, strong) UITableView *tabv1;

@property (nonatomic, weak) UILabel *titleLb;

@property (nonatomic, weak) UITextView *tv;

@end

@implementation LunTanViewController

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
    imageTitle.image = DEF_IMAGE(@"luntan_title");
    imageTitle.centerX = bgImagv.centerX;
    [bgImagv addSubview:imageTitle];
    
    UILabel *TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(40, 50, 150, 20)];
    TitleLb.text = @"请选择同学姓名  :";
    [bgImagv addSubview:TitleLb];
    
    UIButton *selBtn = [[UIButton alloc]initWithFrame:CGRectMake(TitleLb.right + 15, 45, 280, 30)];
    [selBtn setImage:DEF_IMAGE(@"luntan_xuanze") forState:UIControlStateNormal];
    [selBtn addTarget:self action:@selector(sel1:) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:selBtn];
    self.selBtn = selBtn;
    
    UILabel *selLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 280 - 30, 30)];
    selLb.userInteractionEnabled = NO;
    [selBtn addSubview:selLb];
    self.selLb = selLb;
    
    self.tabv = [[UITableView alloc]initWithFrame:CGRectMake(selBtn.x, selBtn.bottom, selBtn.width, 300) style:UITableViewStylePlain];
    self.tabv.delegate = self;
    self.tabv.dataSource = self;
    self.tabv.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabv.hidden = YES;
    [bgImagv addSubview:self.tabv];
    
    UIButton *chaxunBtn = [[UIButton alloc]initWithFrame:CGRectMake(bgImagv.width - 130, 45, 90, 30)];
    [chaxunBtn setImage:DEF_IMAGE(@"luntan_chaxun") forState:UIControlStateNormal];
    [chaxunBtn addTarget:self action:@selector(chaxun) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:chaxunBtn];
    
    
    self.tabv1 = [[UITableView alloc]initWithFrame:CGRectMake(25, chaxunBtn.bottom + 10, DEF_DEVICE_WIDTH - 30 - 175 - 50, 385) style:UITableViewStylePlain];
    self.tabv1.delegate = self;
    self.tabv1.dataSource = self;
    self.tabv1.backgroundColor = [UIColor clearColor];
    self.tabv1.hidden = YES;
    self.tabv1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgImagv addSubview:self.tabv1];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tabv1.width, 35)];
    self.tabv1.tableHeaderView = view;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tabv1.width, 2)];
    lineView.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [view addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 33, self.tabv1.width, 2)];
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

    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(25, self.tabv1.bottom, self.tabv1.width, 2)];
    lineView2.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [bgImagv addSubview:lineView2];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(35, lineView2.bottom, self.tabv1.width - 20, 45)];
    titleLb.font = DEF_MyFont(17);
    titleLb.text = @"论坛主题:";
    [bgImagv addSubview:titleLb];
    self.titleLb = titleLb;
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(25, titleLb.bottom, self.tabv1.width, 75)];
    imagv.image = DEF_IMAGE(@"luntan_shurukuang");
    imagv.userInteractionEnabled = YES;
    [bgImagv addSubview:imagv];
    
    UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, imagv.width, imagv.height)];
    tv.backgroundColor = [UIColor clearColor];
    [imagv addSubview:tv];
    self.tv = tv;
    
    UIButton *tijiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, imagv.bottom + 10, 180, 30)];
    tijiaoBtn.centerX = bgImagv.centerX;
    [tijiaoBtn setImage:DEF_IMAGE(@"tiankongti_tijiao") forState:UIControlStateNormal];
    [tijiaoBtn addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:tijiaoBtn];
    
    NSDictionary * dic1 = @{@"version"         :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M007",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M007"]};
    [RequestOperationManager getParametersDic:dic1 success:^(NSMutableDictionary *result) {
        self.m007Arr = result[@"users"];
        [self.tabv reloadData];
    } failture:^(id result) {
        
    }];

}

-(void)tijiao
{
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M031",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"content"          :self.tv.text,
                           @"sign"             :[CACUtility getSignWithMethod:@"M031"]};
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
    self.tabv.hidden = YES;
    
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M032",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"authorId"         :self.m007Dic[@"userId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M032"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        self.M031Dic = result;
        [self.tabv1 reloadData];
        self.tabv1.hidden = NO;
        self.titleLb.text = [NSString stringWithFormat:@"论坛主题:  %@",result[@"title"]];
    } failture:^(id result) {
    }];

}

-(void)sel1:(UIButton *)sender
{
    if (self.tabv.hidden == YES) {
        self.tabv.hidden = NO;
    }else{
        self.tabv.hidden = YES;
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView == self.tabv) {
        return 50;
    }
    return 75;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.tabv) {
        return [self.m007Arr count];
    }
    return [self.M031Dic[@"contents"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tabv) {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, self.tabv.width, 0.5)];
            lineView.backgroundColor = [UIColor grayColor];
            [cell.contentView addSubview:lineView];
            
        }
        
        cell.textLabel.text = self.m007Arr[indexPath.row][@"userName"];
        
        return cell;

    }
    
    static NSString *CellIdentifier1 = @"Cell1";
    
    LunTanCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (!cell) {
        cell = [[LunTanCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 74.5, self.tabv1.width, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:lineView];
        
        UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 80, 70)];
        nameLb.font = DEF_MyFont(16);
        nameLb.numberOfLines = 3;
        nameLb.tag = 200;
        [cell.contentView addSubview:nameLb];
        
        UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(nameLb.right + 10, 0, 400, 70)];
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
    nameLb.text = self.M031Dic[@"contents"][indexPath.row][@"authorName"];
    
    UILabel *contentLb = [cell.contentView viewWithTag:201];
    contentLb.text = self.M031Dic[@"contents"][indexPath.row][@"content"];
    
    UILabel *timeLb = [cell.contentView viewWithTag:202];
    timeLb.text = self.M031Dic[@"contents"][indexPath.row][@"lastUpdateTime"];

    cell.btn.tag = 1000+ indexPath.row;
    [cell.btn addTarget:self action:@selector(zan:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.M031Dic[@"contents"][indexPath.row][@"ifVote"] intValue] == 1) {
        cell.btn.enabled = NO;
    }else{
        cell.btn.enabled = YES;
    }

    cell.btn1.tag = 10000+ indexPath.row;
    [cell.btn1 addTarget:self action:@selector(ding:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.M031Dic[@"contents"][indexPath.row][@"ifSelect"] intValue] == 1) {
        cell.btn1.enabled = NO;
    }else{
        cell.btn1.enabled = YES;
    }

    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.m007Dic = self.m007Arr[indexPath.row];
    self.tabv.hidden = YES;
    self.selLb.text = self.m007Dic[@"userName"];
}

-(void)zan:(UIButton *)sender
{
    int tag = (int)sender.tag - 1000;
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M033",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"answerId"         :self.M031Dic[@"contents"][tag][@"answerId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M033"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {

        if ([result[@"responseCode"] isEqualToString:@"00"]) {
            [CACUtility showTips:@"点赞成功"];
            [self performSelector:@selector(chaxun) withObject:nil afterDelay:2];
        }else if ([result[@"responseCode"] isEqualToString:@"96"]){
            [CACUtility showTips:result[@"responseMessage"]];
        }else{
            [CACUtility showTips:@"点赞失败"];
        }

    } failture:^(id result) {
        [CACUtility showTips:@"点赞失败"];
    }];

}

-(void)ding:(UIButton *)sender
{
    int tag = (int)sender.tag - 10000;
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M034",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"answerId"         :self.M031Dic[@"contents"][tag][@"answerId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M034"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        
        if ([result[@"responseCode"] isEqualToString:@"00"]) {
            [CACUtility showTips:@"顶置成功"];
            [self performSelector:@selector(chaxun) withObject:nil afterDelay:2];
        }else if ([result[@"responseCode"] isEqualToString:@"96"]){
            [CACUtility showTips:result[@"responseMessage"]];
        }else{
            [CACUtility showTips:@"顶置失败"];
        }
        
    } failture:^(id result) {
        [CACUtility showTips:@"顶置失败"];
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
