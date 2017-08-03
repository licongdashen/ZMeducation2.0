//
//  TouPiaoJieGuo2ViewController.m
//  ZMeducation2.0
//
//  Created by 李聪 on 2017/8/3.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "TouPiaoJieGuo2ViewController.h"

@interface TouPiaoJieGuo2ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableDictionary *userInfo;
@property (nonatomic, strong)NSMutableArray *M2051Arr;
@property (nonatomic, weak)UITableView *tabv1;
@property (nonatomic)int count;
@end

@implementation TouPiaoJieGuo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [DEF_UserDefaults objectForKey:SAVE_USERINFO];
    self.count = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 64)];
    view.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [self.view addSubview:view];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 23, 65, 30)];
    [backBtn setTitle:@"返回" forState:0];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, view.bottom + 20, DEF_DEVICE_WIDTH, 30)];
    titleLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLb];
    
    UITableView *tabv1= [[UITableView alloc]initWithFrame:CGRectMake(20, titleLb.bottom + 20, self.view.width - 40, DEF_DEVICE_HEIGHT - 64 - 20 - 20) style:UITableViewStylePlain];
    tabv1.delegate = self;
    tabv1.dataSource = self;
    tabv1.separatorStyle = UITableViewCellAccessoryNone;
    tabv1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tabv1];
    self.tabv1 = tabv1;

    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2051",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"unitId"           :self.dic[@"unitId"],
                            @"unitTypeId"       :self.dic[@"unitTypeId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2051"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        titleLb.text = result[@"title"];
        self.M2051Arr = result[@"groupNames"];
        [self.tabv1 reloadData];
        
        for (NSMutableDictionary *dic in self.M2051Arr) {
            self.count += [dic[@"voteCount"] intValue];
        }

    } failture:^(id result) {
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
    return [self.M2051Arr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 69, self.tabv1.width, 1)];
        line.backgroundColor = [UIColor grayColor];
        [cell addSubview:line];
        
        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 30)];
        titleLb.tag = 201;
        [cell addSubview:titleLb];
        
        UILabel *countLb1 = [[UILabel alloc]initWithFrame:CGRectZero];
        countLb1.tag = 202;
        countLb1.backgroundColor = [UIColor colorWithRed:85/255.0f green:166/255.0f blue:239/255.0f alpha:1.0];
        [cell.contentView addSubview:countLb1];
        
    }
    
    UILabel *name = [cell viewWithTag:201];
    name.text = [NSString stringWithFormat:@"%@:    %d票",self.M2051Arr[indexPath.row][@"optionName"],[self.M2051Arr[indexPath.row][@"voteCount"] intValue]];
    
    
    UILabel *labe2 = [cell.contentView viewWithTag:202];
    labe2.frame = CGRectMake(0, 30,((float)[self.M2051Arr[indexPath.row][@"voteCount"] intValue]/self.count)*800, 30);
    labe2.text = [NSString stringWithFormat:@"%g%%",((float)[self.M2051Arr[indexPath.row][@"voteCount"] intValue])/self.count*100];
    
    
    return cell;
    
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
