//
//  toupiaoViewController.m
//  ZMeducation2.0
//
//  Created by 李聪 on 2017/8/1.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "toupiaoViewController.h"
#import "XiaoZuHeZuoCell.h"
#import "TouPiaoJieGuo2ViewController.h"

@interface toupiaoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableDictionary *userInfo;
@property (nonatomic, weak) UIImageView *bgImagv;
@property(nonatomic, weak)UILabel *tiwenLb;
@property (nonatomic, strong)NSMutableDictionary *M2051Dic;
@property (nonatomic, strong)NSMutableArray *tempM2051Arr;

@property (nonatomic, strong)UITableView *tabv;
@property (nonatomic, weak)UIButton *jiegouBtn;

@property (nonatomic, weak)UIButton *tijiao2Btn;

@end

@implementation toupiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [DEF_UserDefaults objectForKey:SAVE_USERINFO];
    self.tempM2051Arr = [[NSMutableArray alloc]init];
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
    imageTitle.image = DEF_IMAGE(@"toupiao_title");
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

    self.tabv = [[UITableView alloc]initWithFrame:CGRectMake(20, imagetiwen.bottom + 10, self.bgImagv.width - 40, 400) style:UITableViewStylePlain];
    self.tabv.delegate = self;
    self.tabv.dataSource = self;
    self.tabv.backgroundColor = [UIColor clearColor];
    [self.bgImagv addSubview:self.tabv];

    
    UIButton *tijiao2Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.tabv.bottom + 10, 180, 30)];
    tijiao2Btn.centerX = bgImagv.centerX - 200;
    [tijiao2Btn addTarget:self action:@selector(tijiao2) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:tijiao2Btn];
    self.tijiao2Btn = tijiao2Btn;
    
    UIButton *jiegouBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.tabv.bottom + 10, 180, 30)];
    jiegouBtn.centerX = bgImagv.centerX + 200;
    [jiegouBtn addTarget:self action:@selector(jiegou) forControlEvents:UIControlEventTouchUpInside];
    [jiegouBtn setImage:DEF_IMAGE(@"hezuo_jieguo") forState:UIControlStateNormal];
    jiegouBtn.hidden = YES;
    [bgImagv addSubview:jiegouBtn];
    self.jiegouBtn = jiegouBtn;
    
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
        self.M2051Dic = result;
        self.tiwenLb.text = result[@"voteTitle"];
        
        for (NSDictionary *dic in self.M2051Dic[@"groupNames"]) {
            NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
            [dic1 setObject:dic[@"optionId"] forKey:@"optionId"];
            [dic1 setObject:[NSString stringWithFormat:@"%@",dic[@"ifSelect"]] forKey:@"flag"];
            [self.tempM2051Arr addObject:dic1];
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

        [self.tabv reloadData];
    } failture:^(id result) {
    }];
}

-(void)tijiao2
{
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M2052",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"voteContent"      :self.tempM2051Arr,
                           @"sign"             :[CACUtility getSignWithMethod:@"M2052"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        if ([result[@"responseCode"] isEqualToString:@"00"]) {
            [CACUtility showTips:@"投票成功"];
            self.tijiao2Btn.enabled = NO;
            self.jiegouBtn.hidden = NO;
        }else if ([result[@"responseCode"] isEqualToString:@"96"]){
            if (result[@"responseMessage"] != nil) {
                [CACUtility showTips:result[@"responseMessage"]];
            }
        }else{
            [CACUtility showTips:@"投票失败"];
        }
    } failture:^(id result) {
        [CACUtility showTips:@"投票失败"];
    }];

}

-(void)jiegou
{
    TouPiaoJieGuo2ViewController *vc = [[TouPiaoJieGuo2ViewController alloc]init];
    vc.dic = self.dic;
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)sel2:(UIButton *)sender
{
    int tag = (int)sender.tag - 10000;
    NSMutableDictionary *dic = self.tempM2051Arr[tag];
    
    if ([dic[@"flag"] intValue] == 1) {
        [dic setObject:@"0" forKey:@"flag"];
    }else{
        [dic setObject:@"1" forKey:@"flag"];
    }
    
    [self.tabv reloadData];
    NSLog(@"ggggggg%@",self.tempM2051Arr);
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
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.M2051Dic[@"groupNames"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    XiaoZuHeZuoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[XiaoZuHeZuoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, self.tabv.width, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:lineView];
        
        UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 400, 30)];
        nameLb.tag = 204;
        [cell addSubview:nameLb];

    }
    
    UILabel *nameLb = [cell viewWithTag:204];
    nameLb.text = [NSString stringWithFormat:@"%@--%@",self.M2051Dic[@"groupNames"][indexPath.row][@"optionName"],self.M2051Dic[@"groupNames"][indexPath.row][@"optionContent"]];

    if ([self.tempM2051Arr[indexPath.row][@"flag"] intValue] == 1) {
        [cell.selBtn setImage:DEF_IMAGE(@"danxuanti_sel") forState:UIControlStateNormal];
    }else{
        [cell.selBtn setImage:DEF_IMAGE(@"danxuanti_unsel") forState:UIControlStateNormal];
    }
    cell.selBtn.tag = 10000 + indexPath.row;
    [cell.selBtn addTarget:self action:@selector(sel2:) forControlEvents:UIControlEventTouchUpInside];

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
