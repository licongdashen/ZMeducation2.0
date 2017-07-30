//
//  XiaoZuHeZuoViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/24.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "XiaoZuHeZuoViewController.h"
#import "XiaoZuHeZuoCell.h"
#import "TouPiaoJieguoViewController.h"

@interface XiaoZuHeZuoViewController ()<UITableViewDelegate,UITableViewDataSource>

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

@property (nonatomic, weak)UITableView *tabv1;

@property (nonatomic, strong)NSMutableArray *M2043Arr;

@property (nonatomic, strong)NSMutableArray *tempM2043Arr;

@property (nonatomic, weak)UIButton *tijiao2Btn;

@property (nonatomic, weak)UIButton *jiegouBtn;

@property (nonatomic, strong)UITableView *tabv2;

@property (nonatomic, weak)UIButton *selBtn;

@property (nonatomic, weak)UILabel *selLb;

@property (nonatomic, strong)NSMutableDictionary *M2045Dic;

@property (nonatomic, strong)NSMutableArray *M2045Arr;

@property (nonatomic, strong)NSMutableArray *M2044Arr;

@property (nonatomic, weak)UILabel *TitleLb2;

@property (nonatomic, strong)UITableView *tabv3;

@property (nonatomic, strong)NSMutableArray * tempM2044Arr;

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
    self.tempM2043Arr = [[NSMutableArray alloc]init];
    self.tempM2044Arr = [[NSMutableArray alloc]init];

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
    
    UILabel *title2Lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, view1.width, 18)];
    title2Lb.text = @"主题:";
    title2Lb.textAlignment = NSTextAlignmentCenter;
    [self.view2 addSubview:title2Lb];
    
    UITableView *tabv1= [[UITableView alloc]initWithFrame:CGRectMake(40, title2Lb.bottom + 10, self.view1.width - 80, 430) style:UITableViewStylePlain];
    tabv1.delegate = self;
    tabv1.dataSource = self;
    tabv1.backgroundColor = [UIColor clearColor];
    [self.view2 addSubview:tabv1];
    self.tabv1 = tabv1;
    
    UIButton *tijiao2Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, tabv1.bottom + 10, 180, 30)];
    tijiao2Btn.centerX = bgImagv.centerX - 200;
    [tijiao2Btn addTarget:self action:@selector(tijiao2) forControlEvents:UIControlEventTouchUpInside];
    [self.view2 addSubview:tijiao2Btn];
    self.tijiao2Btn = tijiao2Btn;
    
    UIButton *jiegouBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, tabv1.bottom + 10, 180, 30)];
    jiegouBtn.centerX = bgImagv.centerX + 200;
    [jiegouBtn addTarget:self action:@selector(jiegou) forControlEvents:UIControlEventTouchUpInside];
    [jiegouBtn setImage:DEF_IMAGE(@"hezuo_jieguo") forState:UIControlStateNormal];
    jiegouBtn.hidden = YES;
    [self.view2 addSubview:jiegouBtn];
    self.jiegouBtn = jiegouBtn;
    
    UILabel *TitleLb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view3.width, 20)];
    TitleLb2.textAlignment = NSTextAlignmentCenter;
    [self.view3 addSubview:TitleLb2];
    self.TitleLb2 = TitleLb2;
    
    UIButton *selBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 45, 280, 30)];
    [selBtn setImage:DEF_IMAGE(@"luntan_xuanze") forState:UIControlStateNormal];
    [selBtn addTarget:self action:@selector(sel1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view3 addSubview:selBtn];
    self.selBtn = selBtn;
    
    UILabel *selLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 280 - 30, 30)];
    selLb.userInteractionEnabled = NO;
    [selBtn addSubview:selLb];
    self.selLb = selLb;
    
    self.tabv2 = [[UITableView alloc]initWithFrame:CGRectMake(selBtn.x, selBtn.bottom, selBtn.width, 300) style:UITableViewStylePlain];
    self.tabv2.delegate = self;
    self.tabv2.dataSource = self;
    self.tabv2.hidden = YES;
    [self.view3 addSubview:self.tabv2];
    
    UIButton *chaxunBtn = [[UIButton alloc]initWithFrame:CGRectMake(selBtn.right + 50, 45, 90, 30)];
    [chaxunBtn setImage:DEF_IMAGE(@"luntan_chaxun") forState:UIControlStateNormal];
    [chaxunBtn addTarget:self action:@selector(chaxun) forControlEvents:UIControlEventTouchUpInside];
    [self.view3 addSubview:chaxunBtn];
    
    self.tabv3 = [[UITableView alloc]initWithFrame:CGRectMake(20, chaxunBtn.bottom + 10, self.view3.width - 40, self.view3.height - chaxunBtn.bottom - 10) style:UITableViewStylePlain];
    self.tabv3.delegate = self;
    self.tabv3.dataSource = self;
    self.tabv3.backgroundColor = [UIColor clearColor];
    [self.view3 addSubview:self.tabv3];

    NSDictionary * dic1 = @{@"version"         :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M2041",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M2041"]};
    [RequestOperationManager getParametersDic:dic1 success:^(NSMutableDictionary *result) {
        
        titleLb.text = [NSString stringWithFormat:@"主题:  %@",result[@"optionTitle"]];
        
        title1Lb.text = [NSString stringWithFormat:@"分项:  %@",result[@"content"]];

    } failture:^(id result) {
        
    }];
    
    
    NSDictionary * dic2 = @{@"version"         :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2043",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"unitId"           :self.dic[@"unitId"],
                            @"unitTypeId"       :self.dic[@"unitTypeId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2043"]};
    [RequestOperationManager getParametersDic:dic2 success:^(NSMutableDictionary *result) {
        [CACUtility hideMBProgress:DEF_MyAppDelegate.window];

        title2Lb.text = [NSString stringWithFormat:@"主题:  %@",result[@"title"]];
        
        self.M2043Arr = result[@"groups"];
        
        [self.tempM2043Arr removeAllObjects];
        
        for (NSDictionary *dic in self.M2043Arr) {
            NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
            [dic1 setObject:dic[@"groupId"] forKey:@"optionId"];
            [dic1 setObject:[NSString stringWithFormat:@"%@",dic[@"ifSelect"]] forKey:@"flag"];
            [self.tempM2043Arr addObject:dic1];
        }
        
        if ([result[@"ifVote"] intValue] == 1) {
            [self.tijiao2Btn setImage:DEF_IMAGE(@"hezuo_yitoupiao") forState:UIControlStateNormal];
            self.tijiao2Btn.enabled = NO;
            self.jiegouBtn.hidden = NO;

        }else{
            [self.tijiao2Btn setImage:DEF_IMAGE(@"hezuo_toupiao") forState:UIControlStateNormal];
            self.tijiao2Btn.enabled = YES;
            self.jiegouBtn.hidden = YES;

        }
        [self.tabv1 reloadData];

    } failture:^(id result) {
        [CACUtility hideMBProgress:DEF_MyAppDelegate.window];

    }];

    
    NSDictionary * dic3 = @{@"version"         :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2045",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"unitId"           :self.dic[@"unitId"],
                            @"unitTypeId"       :self.dic[@"unitTypeId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2045"]};
    [RequestOperationManager getParametersDic:dic3 success:^(NSMutableDictionary *result) {
        [CACUtility hideMBProgress:DEF_MyAppDelegate.window];
        self.M2045Arr = result[@"options"];
        [self.tabv2 reloadData];
    } failture:^(id result) {
        [CACUtility hideMBProgress:DEF_MyAppDelegate.window];

    }];


}


-(void)chaxun
{
    self.tabv2.hidden = YES;
    
    
    
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M2044",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"optionId"         :self.M2045Dic[@"optionId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M2044"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        [CACUtility hideMBProgress:DEF_MyAppDelegate.window];

        self.M2044Arr = result[@"options"][0][@"contents"];
        self.TitleLb2.text = result[@"title"];
        [self.tabv3 reloadData];
        
        for (NSDictionary *dic in self.M2044Arr) {
            NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
            [dic1 setObject:dic[@"groupId"] forKey:@"optionId"];
            [dic1 setObject:[NSString stringWithFormat:@"%@",dic[@"ifSelect"]] forKey:@"flag"];
            [self.tempM2044Arr addObject:dic1];
        }

    } failture:^(id result) {
        [CACUtility hideMBProgress:DEF_MyAppDelegate.window];

    }];
    
}

-(void)sel1:(UIButton *)sender
{
    [self.view3 bringSubviewToFront:self.tabv2];
    
    if (self.tabv2.hidden == YES) {
        self.tabv2.hidden = NO;
    }else{
        self.tabv2.hidden = YES;
    }
}

-(void)jiegou
{
    TouPiaoJieguoViewController *vc = [[TouPiaoJieguoViewController alloc]init];
    vc.dic = self.dic;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tijiao2
{
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M2046",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"voteContent"      :self.tempM2043Arr,
                           @"type"             :@"1",
                           @"sign"             :[CACUtility getSignWithMethod:@"M2046"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        if ([result[@"responseCode"] isEqualToString:@"00"]) {
            [CACUtility showTips:@"投票成功"];
            self.tijiao2Btn.enabled = NO;
            self.jiegouBtn.hidden = NO;
        }else if ([result[@"responseCode"] isEqualToString:@"96"]){
            [CACUtility showTips:result[@"responseMessage"]];
        }else{
            [CACUtility showTips:@"投票失败"];
        }
    } failture:^(id result) {
        [CACUtility showTips:@"投票失败"];
    }];

}

-(void)tijiao
{
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M2042",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"content"          :self.tv.text,
                           @"sign"             :[CACUtility getSignWithMethod:@"M2042"]};
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tabv1) {
        UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 30)];
        foot.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
        
        UIButton *imgv = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        [imgv setImage:DEF_IMAGE(@"danxuanti_unsel") forState:UIControlStateNormal];
        [imgv addTarget:self action:@selector(sel:) forControlEvents:UIControlEventTouchUpInside];
        imgv.tag = 1000 + section;
        [foot addSubview:imgv];
        
        if ([self.tempM2043Arr[section][@"flag"]intValue] == 1) {
            [imgv setImage:DEF_IMAGE(@"danxuanti_sel") forState:UIControlStateNormal];
        }else{
            [imgv setImage:DEF_IMAGE(@"danxuanti_unsel") forState:UIControlStateNormal];
        }
        UILabel *title2Lb = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, self.tabv1.width - 70, 30)];
        title2Lb.text = [NSString stringWithFormat:@"%@:    %d票",self.M2043Arr[section][@"groupName"],[self.M2043Arr[section][@"voteCount"] intValue]];
        title2Lb.textColor = [UIColor whiteColor];
        [foot addSubview:title2Lb];
        
        return foot;
    }else if (tableView == self.tabv2){
    
        return nil;
    }else if (tableView == self.tabv3){
    
        return nil;
    }

    return nil;
}

-(void)sel:(UIButton *)sender
{
    int tag = (int)sender.tag - 1000;
    NSMutableDictionary *dic = self.tempM2043Arr[tag];
    
    if ([dic[@"flag"] intValue] == 1) {
        [dic setObject:@"0" forKey:@"flag"];
    }else{
        [dic setObject:@"1" forKey:@"flag"];
    }
    
    [self.tabv1 reloadData];
    NSLog(@"ggggggg%@",self.tempM2043Arr);
}

-(void)sel2:(UIButton *)sender
{
    int tag = (int)sender.tag - 10000;
    NSMutableDictionary *dic = self.tempM2044Arr[tag];
    
    if ([dic[@"flag"] intValue] == 1) {
        [dic setObject:@"0" forKey:@"flag"];
    }else{
        [dic setObject:@"1" forKey:@"flag"];
    }
    
    [self.tabv3 reloadData];
    NSLog(@"ggggggg%@",self.tempM2044Arr);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tabv1) {
        return 30;
    }else if (tableView == self.tabv2){
    
        return 0;
    }else if (tableView == self.tabv3){
        return 0;
    }
    return 30;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tabv1) {
        return [self.M2043Arr count];
    }else if (tableView == self.tabv2){
    
        return 1;
    }else if (tableView == self.tabv3){
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView == self.tabv1) {
        return 120;
    }else if (tableView == self.tabv2){
    
        return 50;
    }else if (tableView == self.tabv3){
    
        return 120;
    }
    return 120;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tabv1) {
        return [self.M2043Arr[section][@"contents"] count];

    }else if (tableView == self.tabv2){
    
        return self.M2045Arr.count;
    }else if (tableView == self.tabv3){
    
        return self.M2044Arr.count;
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tabv1) {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, self.tabv1.width - 50, 30)];
            nameLb.font = DEF_MyFont(16);
            nameLb.tag = 200;
            [cell.contentView addSubview:nameLb];
            
            UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(60, nameLb.bottom, self.tabv1.width - 70, 90)];
            tv.backgroundColor = [UIColor clearColor];
            tv.editable = NO;
            tv.tag = 201;
            [cell.contentView addSubview:tv];
        }
        
        UILabel *nameLb = [cell viewWithTag:200];
        nameLb.text = [NSString stringWithFormat:@"%@(%@):",self.M2043Arr[indexPath.section][@"contents"][indexPath.row][@"author"],self.M2043Arr[indexPath.section][@"contents"][indexPath.row][@"optionTitle"]];
        
        UITextView *tv = [cell viewWithTag:201];
        tv.text = self.M2043Arr[indexPath.section][@"contents"][indexPath.row][@"content"];
        
        return cell;
        
    }else if (tableView == self.tabv2){
        
        static NSString *CellIdentifier2 = @"Cell2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
        }
        
        cell.textLabel.text = self.M2045Arr[indexPath.row][@"optionName"];
        
        return cell;

    }else if (tableView == self.tabv3){
        
        static NSString *CellIdentifier1 = @"Cell3";
        
        XiaoZuHeZuoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (!cell) {
            cell = [[XiaoZuHeZuoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
        }
        
        if ([self.tempM2044Arr[indexPath.row][@"flag"] intValue] == 1) {
            [cell.selBtn setImage:DEF_IMAGE(@"danxuanti_sel") forState:UIControlStateNormal];
        }else{
            [cell.selBtn setImage:DEF_IMAGE(@"danxuanti_unsel") forState:UIControlStateNormal];
        }
        cell.selBtn.tag = 10000 + indexPath.row;
        [cell.selBtn addTarget:self action:@selector(sel2:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    
    }
    
    static NSString *CellIdentifier1 = @"Cell1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tabv2) {
        self.M2045Dic = self.M2045Arr[indexPath.row];
        self.tabv2.hidden = YES;
        self.selLb.text = self.M2045Dic[@"optionName"];
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
