//
//  LiuChengViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/13.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "LiuChengViewController.h"
#import "TianKongTiViewController.h"
#import "YinPinViewController.h"
#import "JianDaTiViewController.h"
#import "DanXuanTiViewController.h"
#import "DuoXuanTiViewController.h"
#import "LunTanViewController.h"
#import "PdfViewController.h"
#import "ShiPinViewController.h"

@interface LiuChengViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tav;

@property (nonatomic, weak) UIViewController *currentVc;

@property (nonatomic, strong) TianKongTiViewController *vc1;

@property (nonatomic, strong) YinPinViewController *vc2;

@property (nonatomic, strong) JianDaTiViewController *vc3;

@property (nonatomic, strong) DanXuanTiViewController *vc4;

@property (nonatomic, strong) DuoXuanTiViewController *vc5;

@property (nonatomic, strong) LunTanViewController *vc6;

@property (nonatomic, strong) PdfViewController *vc7;

@property (nonatomic, strong) ShiPinViewController *vc8;

@end

@implementation LiuChengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tav = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 175, self.view.height - 95) style:UITableViewStylePlain];
    self.tav.delegate = self;
    self.tav.dataSource = self;
    self.tav.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tav];
    
    UIViewController* currentVc = [[UIViewController alloc]init];
    currentVc.view.frame = CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height);
    [self addChildViewController:currentVc];
    [self.view addSubview:currentVc.view];
    self.currentVc = currentVc;
    

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
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"liucheng_sel-1"]];
    }
    
    NSMutableArray *arr = self.dic[@"modules"];
    NSMutableDictionary *dic = arr[indexPath.section];
    NSMutableArray *arr1 = dic[@"units"];
    NSMutableDictionary *dic1 = arr1[indexPath.row];
    cell.textLabel.text = dic1[@"unitName"];
    cell.textLabel.textColor = DEF_COLOR_RGB(58, 62, 62);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = self.dic[@"modules"];

    NSDictionary *dic = arr[indexPath.section][@"units"][indexPath.row];
    
    if ([dic[@"unitTypeId"] intValue] == 11) {
        //pdf文件
        
        if (!self.vc7) {
            self.vc7 = [[PdfViewController alloc]init];
            self.vc7.view.frame = CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height);
        }
        
        [self addChildViewController:self.vc7];
        if (self.currentVc == self.vc7) {
            self.vc7.dic = dic;

            return;
        }
        [self transitionFromViewController:self.currentVc toViewController:self.vc7 duration:0.01 options:UIViewAnimationOptionTransitionNone animations:^{
        } completion:^(BOOL finished) {
            if (finished) {
                
                [self.vc7 didMoveToParentViewController:self];
                [self.currentVc willMoveToParentViewController:nil];
                [self.currentVc removeFromParentViewController];
                
                self.currentVc = self.vc7;
                self.vc7.dic = dic;

            }
        }];

    }else if ([dic[@"unitTypeId"] intValue] == 12) {
        //视频
        
        if (!self.vc8) {
            self.vc8 = [[ShiPinViewController alloc]init];
            self.vc8.view.frame = CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height);
        }
        
        [self addChildViewController:self.vc8];
        if (self.currentVc == self.vc8) {
            self.vc8.dic = dic;
            return;
        }
        [self transitionFromViewController:self.currentVc toViewController:self.vc8 duration:0.01 options:UIViewAnimationOptionTransitionNone animations:^{
        } completion:^(BOOL finished) {
            if (finished) {
                
                [self.vc8 didMoveToParentViewController:self];
                [self.currentVc willMoveToParentViewController:nil];
                [self.currentVc removeFromParentViewController];
                
                self.currentVc = self.vc8;
                
                self.vc8.dic = dic;

            }
        }];

    }else if ([dic[@"unitTypeId"] intValue] == 13) {
        //音频
        if (!self.vc2) {
            self.vc2 = [[YinPinViewController alloc]init];
            self.vc2.view.frame = CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height);
        }
        
        [self addChildViewController:self.vc2];
        if (self.currentVc == self.vc2) {
            self.vc2.dic = dic;

            return;
        }
        [self transitionFromViewController:self.currentVc toViewController:self.vc2 duration:0.01 options:UIViewAnimationOptionTransitionNone animations:^{
        } completion:^(BOOL finished) {
            if (finished) {
                
                [self.vc2 didMoveToParentViewController:self];
                [self.currentVc willMoveToParentViewController:nil];
                [self.currentVc removeFromParentViewController];
                
                self.currentVc = self.vc2;
                self.vc2.dic = dic;

            }
        }];
        
    }else if ([dic[@"unitTypeId"] intValue] == 21) {
        //填空题
        
        if (!self.vc1) {
            self.vc1 = [[TianKongTiViewController alloc]init];
            self.vc1.view.frame = CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height);
        }
        
        [self addChildViewController:self.vc1];
        if (self.currentVc == self.vc1) {
            self.vc1.dic = dic;

            return;
        }
        [self transitionFromViewController:self.currentVc toViewController:self.vc1 duration:0.01 options:UIViewAnimationOptionTransitionNone animations:^{
        } completion:^(BOOL finished) {
            if (finished) {
                
                [self.vc1 didMoveToParentViewController:self];
                [self.currentVc willMoveToParentViewController:nil];
                [self.currentVc removeFromParentViewController];
                self.currentVc = self.vc1;
                self.vc1.dic = dic;

            }
        }];
        
    }else if ([dic[@"unitTypeId"] intValue] == 22) {
        //简答题
        
        if (!self.vc3) {
            self.vc3 = [[JianDaTiViewController alloc]init];
            self.vc3.view.frame = CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height);
        }
        
        [self addChildViewController:self.vc3];
        if (self.currentVc == self.vc3) {
            self.vc3.dic = dic;

            return;
        }
        [self transitionFromViewController:self.currentVc toViewController:self.vc3 duration:0.01 options:UIViewAnimationOptionTransitionNone animations:^{
        } completion:^(BOOL finished) {
            if (finished) {
                
                [self.vc3 didMoveToParentViewController:self];
                [self.currentVc willMoveToParentViewController:nil];
                [self.currentVc removeFromParentViewController];
                self.currentVc = self.vc3;
                self.vc3.dic = dic;

            }
        }];

    }else if ([dic[@"unitTypeId"] intValue] == 23) {
        //是非题
    
    }else if ([dic[@"unitTypeId"] intValue] == 24) {
        //单选题
        
        if (!self.vc4) {
            self.vc4 = [[DanXuanTiViewController alloc]init];
            self.vc4.view.frame = CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height);
            
        }
        
        [self addChildViewController:self.vc4];
        if (self.currentVc == self.vc4) {
            self.vc4.dic = dic;

            return;
        }
        [self transitionFromViewController:self.currentVc toViewController:self.vc4 duration:0.01 options:UIViewAnimationOptionTransitionNone animations:^{
        } completion:^(BOOL finished) {
            if (finished) {
                
                [self.vc4 didMoveToParentViewController:self];
                [self.currentVc willMoveToParentViewController:nil];
                [self.currentVc removeFromParentViewController];
                self.currentVc = self.vc4;
                self.vc4.dic = dic;

            }
        }];

    }else if ([dic[@"unitTypeId"] intValue] == 25) {
        //多选题
        
        if (!self.vc5) {
            self.vc5 = [[DuoXuanTiViewController alloc]init];
            self.vc5.view.frame = CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height);
        }
        
        [self addChildViewController:self.vc5];
        if (self.currentVc == self.vc5) {
            self.vc5.dic = dic;

            return;
        }
        [self transitionFromViewController:self.currentVc toViewController:self.vc5 duration:0.01 options:UIViewAnimationOptionTransitionNone animations:^{
        } completion:^(BOOL finished) {
            if (finished) {
                
                [self.vc5 didMoveToParentViewController:self];
                [self.currentVc willMoveToParentViewController:nil];
                [self.currentVc removeFromParentViewController];
                self.currentVc = self.vc5;
                self.vc5.dic = dic;

            }
        }];

    }else if ([dic[@"unitTypeId"] intValue] == 31) {
        //论坛
        if (!self.vc6) {
            self.vc6 = [[LunTanViewController alloc]init];
            self.vc6.view.frame = CGRectMake(175, 0, DEF_DEVICE_WIDTH - 175, self.view.height);
        }
        
        [self addChildViewController:self.vc6];
        if (self.currentVc == self.vc6) {
            self.vc6.dic = dic;

            return;
        }
        [self transitionFromViewController:self.currentVc toViewController:self.vc6 duration:0.01 options:UIViewAnimationOptionTransitionNone animations:^{
        } completion:^(BOOL finished) {
            if (finished) {
                
                [self.vc6 didMoveToParentViewController:self];
                [self.currentVc willMoveToParentViewController:nil];
                [self.currentVc removeFromParentViewController];
                self.currentVc = self.vc6;
                self.vc6.dic = dic;

            }
        }];

    }else if ([dic[@"unitTypeId"] intValue] == 41) {
        //独立完成分项
        
    }else if ([dic[@"unitTypeId"] intValue] == 42) {
        //合作完成分项
        
    }else if ([dic[@"unitTypeId"] intValue] == 51) {
        //投票
        
    }else if ([dic[@"unitTypeId"] intValue] == 52) {
        //抢答
        
    }else if ([dic[@"unitTypeId"] intValue] == 61) {
        //我的构思
        
    }else if ([dic[@"unitTypeId"] intValue] == 79) {
        //我的文稿
        
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
