//
//  HomeViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/13.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "HomeViewController.h"
#import "LiuChengViewController.h"
#import "XieZuoViewController.h"
#import "LiuLanViewController.h"
#import "GongJuViewController.h"

@interface HomeViewController ()

@property (nonatomic ,weak)UIButton *btn1;
@property (nonatomic ,weak)UIButton *btn2;
@property (nonatomic ,weak)UIButton *btn3;
@property (nonatomic ,weak)UIButton *btn4;
@property (nonatomic ,weak)UIButton *btn5;

@property (nonatomic, weak) UIViewController *currentVc;

@property (nonatomic, strong) LiuChengViewController *vc1;

@property (nonatomic, strong) XieZuoViewController *vc2;

@property (nonatomic, strong) LiuLanViewController *vc3;

@property (nonatomic, strong) GongJuViewController *vc4;
@property (nonatomic, strong)NSMutableDictionary *userInfo;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [DEF_UserDefaults objectForKey:SAVE_USERINFO];

    UIImageView *backImav = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    backImav.image = DEF_IMAGE(@"home_Bg");
    backImav.userInteractionEnabled = YES;
    [self.view addSubview:backImav];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH - 120, 40, 100, 15)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentRight;
    label.text = self.userInfo[@"gradeName"];
    [backImav addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH - 120, label.bottom + 5, 100, 15)];
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentRight;
    label1.text = self.userInfo[@"realName"];
    [backImav addSubview:label1];
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,DEF_DEVICE_WIDTH, 95)];
    navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navView];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(205, 30, 100, 50)];
    [btn1 setImage:DEF_IMAGE(@"liucheng_sel") forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(action1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    self.btn1 = btn1;
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.right + 32, 30, 100, 50)];
    [btn2 setImage:DEF_IMAGE(@"xiezuo") forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(action2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    self.btn2 = btn2;
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(btn2.right + 32, 30, 100, 50)];
    [btn3 setImage:DEF_IMAGE(@"liulan") forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(action3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    self.btn3 = btn3;
    
    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(btn3.right + 32, 30, 100, 50)];
    [btn4 setImage:DEF_IMAGE(@"gongju") forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(action4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    self.btn4 = btn4;
    
    UIButton *btn5 = [[UIButton alloc]initWithFrame:CGRectMake(btn4.right + 32, 30, 100, 50)];
    [btn5 setImage:DEF_IMAGE(@"tuichu") forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(action5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];

    self.vc1 = [[LiuChengViewController alloc]init];
    self.vc1.dic = self.dic;
    self.vc1.view.frame = CGRectMake(0, 95, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 95);
    [self addChildViewController:self.vc1];
    [self.view addSubview:self.vc1.view];
    self.currentVc = self.vc1;
    
    self.vc2 = [[XieZuoViewController alloc]init];
    self.vc2.dic = self.dic;
    self.vc2.view.frame = CGRectMake(0, 95, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 95);
    
    self.vc3 = [[LiuLanViewController alloc]init];
    self.vc3.view.frame = CGRectMake(0, 95, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 95);
    self.vc3.dic = self.dic;
    
    self.vc4 = [[GongJuViewController alloc]init];
    self.vc4.view.frame = CGRectMake(0, 95, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 95);
    
}

-(void)action1
{
    [self addChildViewController:self.vc1];
    if (self.currentVc == self.vc1) {
        return;
    }
    [self transitionFromViewController:self.currentVc toViewController:self.vc1 duration:0.01 options:UIViewAnimationOptionTransitionNone animations:^{
    } completion:^(BOOL finished) {
        if (finished) {
            
            [self.vc1 didMoveToParentViewController:self];
            [self.currentVc willMoveToParentViewController:nil];
            [self.currentVc removeFromParentViewController];
            
            self.currentVc = self.vc1;
        }
    }];
    [self.btn1 setImage:DEF_IMAGE(@"liucheng_sel") forState:UIControlStateNormal];
    [self.btn2 setImage:DEF_IMAGE(@"xiezuo") forState:UIControlStateNormal];
    [self.btn3 setImage:DEF_IMAGE(@"liulan") forState:UIControlStateNormal];
    [self.btn4 setImage:DEF_IMAGE(@"gongju") forState:UIControlStateNormal];
}

-(void)action2
{
    [self addChildViewController:self.vc2];
    if (self.currentVc == self.vc2) {
        return;
    }
    [self transitionFromViewController:self.currentVc toViewController:self.vc2 duration:0.01 options:UIViewAnimationOptionTransitionNone animations:^{
    } completion:^(BOOL finished) {
        if (finished) {
            
            [self.vc2 didMoveToParentViewController:self];
            [self.currentVc willMoveToParentViewController:nil];
            [self.currentVc removeFromParentViewController];
            
            self.currentVc = self.vc2;
        }
    }];
    [self.btn1 setImage:DEF_IMAGE(@"liucheng") forState:UIControlStateNormal];
    [self.btn2 setImage:DEF_IMAGE(@"xiezuo_sel") forState:UIControlStateNormal];
    [self.btn3 setImage:DEF_IMAGE(@"liulan") forState:UIControlStateNormal];
    [self.btn4 setImage:DEF_IMAGE(@"gongju") forState:UIControlStateNormal];

}

-(void)action3
{
    [self addChildViewController:self.vc3];
    if (self.currentVc == self.vc3) {
        return;
    }
    [self transitionFromViewController:self.currentVc toViewController:self.vc3 duration:0.01 options:UIViewAnimationOptionTransitionNone animations:^{
    } completion:^(BOOL finished) {
        if (finished) {
            
            [self.vc3 didMoveToParentViewController:self];
            [self.currentVc willMoveToParentViewController:nil];
            [self.currentVc removeFromParentViewController];
            
            self.currentVc = self.vc3;
        }
    }];
    [self.btn1 setImage:DEF_IMAGE(@"liucheng") forState:UIControlStateNormal];
    [self.btn2 setImage:DEF_IMAGE(@"xiezuo") forState:UIControlStateNormal];
    [self.btn3 setImage:DEF_IMAGE(@"liulan_sel") forState:UIControlStateNormal];
    [self.btn4 setImage:DEF_IMAGE(@"gongju") forState:UIControlStateNormal];

}

-(void)action4
{
    [self addChildViewController:self.vc4];
    if (self.currentVc == self.vc4) {
        return;
    }
    [self transitionFromViewController:self.currentVc toViewController:self.vc4 duration:0.01 options:UIViewAnimationOptionTransitionNone animations:^{
    } completion:^(BOOL finished) {
        if (finished) {
            
            [self.vc2 didMoveToParentViewController:self];
            [self.currentVc willMoveToParentViewController:nil];
            [self.currentVc removeFromParentViewController];
            
            self.currentVc = self.vc4;
        }
    }];
    [self.btn1 setImage:DEF_IMAGE(@"liucheng") forState:UIControlStateNormal];
    [self.btn2 setImage:DEF_IMAGE(@"xiezuo") forState:UIControlStateNormal];
    [self.btn3 setImage:DEF_IMAGE(@"liulan") forState:UIControlStateNormal];
    [self.btn4 setImage:DEF_IMAGE(@"gongju_sel") forState:UIControlStateNormal];

}

-(void)action5
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
