//
//  LiuLanViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/13.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "LiuLanViewController.h"

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
    
    
}

-(void)loadview2
{
    for (UIView *view in [self.view2 subviews]) {
        [view removeFromSuperview];
    }

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
    
    UIButton *chaxunBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view3.width - 130, 45, 90, 30)];
    [chaxunBtn setImage:DEF_IMAGE(@"luntan_chaxun") forState:UIControlStateNormal];
    [chaxunBtn addTarget:self action:@selector(chaxun) forControlEvents:UIControlEventTouchUpInside];
    [self.view3 addSubview:chaxunBtn];

    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
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
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        self.M2005Arr = result[@"courses"];
        [self.tabv1 reloadData];
    } failture:^(id result) {
        
    }];
}

-(void)sel1:(UIButton *)sender
{
    [self.view3 bringSubviewToFront:self.tabv1];
    
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
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"courseId"         :self.M2005dic[@"courseId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2073"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView == self.tav) {
        return 55;

    }else if (tableView == self.tabv1){
    
        return 55;
    }
    
    return 100;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.tav) {
        return [self.titleArr count];

    }else if (tableView == self.tabv1){
        return [self.M2005Arr count];
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
