//
//  LiuChengViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/13.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "LiuChengViewController.h"

@interface LiuChengViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tav;

@end

@implementation LiuChengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tav = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 175, self.view.height) style:UITableViewStylePlain];
    self.tav.delegate = self;
    self.tav.dataSource = self;
    self.tav.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tav];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 57;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 175, 57)];
    view.backgroundColor = DEF_COLOR_RGB(218, 226, 226);
    
    NSMutableArray *arr = self.dic[@"modules"];
    NSMutableDictionary *dic = arr[section];
    
//    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 10, 12)];
//    imagv.image = DEF_IMAGE(@"home_jiantou");
//    imagv.contentMode = UIViewContentModeCenter;
//    [view addSubview:imagv];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 175 - 30, 35)];
    lable.backgroundColor = [UIColor clearColor];
    lable.font = DEF_MyBoldFont(15);
    lable.text = dic[@"moduleName"];
    lable.numberOfLines = 2;
    [lable setAdjustsFontSizeToFitWidth:YES];
    [view addSubview:lable];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 55;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSMutableArray *arr = self.dic[@"modules"];
    return [arr count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *arr = self.dic[@"modules"];
    NSMutableDictionary *dic = arr[section];
    NSMutableArray *arr1 = dic[@"units"];
    return [arr1 count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //理财推荐
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    NSMutableArray *arr = self.dic[@"modules"];
    NSMutableDictionary *dic = arr[indexPath.section];
    NSMutableArray *arr1 = dic[@"units"];
    NSMutableDictionary *dic1 = arr1[indexPath.row];
    cell.textLabel.text = dic1[@"unitName"];
    cell.textLabel.textColor = DEF_COLOR_RGB(58, 62, 62);
    return cell;
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
