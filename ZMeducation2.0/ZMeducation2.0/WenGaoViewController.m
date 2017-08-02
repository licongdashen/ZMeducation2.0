//
//  WenGaoViewController.m
//  ZMeducation2.0
//
//  Created by 李聪 on 2017/8/2.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "WenGaoViewController.h"

@interface WenGaoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WenGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 64)];
    view.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [self.view addSubview:view];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 23, 65, 30)];
    [backBtn setTitle:@"返回" forState:0];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    
    UITableView *tabv = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 64) style:UITableViewStylePlain];
    tabv.delegate = self;
    tabv.dataSource = self;
    [self.view addSubview:tabv];
    
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
    return [self.arr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 69, DEF_DEVICE_WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:lineView];
        
    }

    cell.textLabel.text  = [NSString stringWithFormat:@"%@",self.arr[indexPath.row]];
    
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
