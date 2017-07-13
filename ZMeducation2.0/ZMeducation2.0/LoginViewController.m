//
//  LoginViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/12.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "LoginViewController.h"
#import "SelectViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UITextField *userNameTf;

@property (nonatomic, strong) UITextField *userPassWorldTf;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView *backgroundImagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    backgroundImagv.image = DEF_IMAGENAME(@"login_Bg");
    backgroundImagv.userInteractionEnabled = YES;
    [self.view addSubview:backgroundImagv];
    
    self.userNameTf = [[UITextField alloc]initWithFrame:CGRectMake(380, 283, 280, 35)];
    self.userNameTf.text = @"T002";
    [self.view addSubview:self.userNameTf];
    
    self.userPassWorldTf = [[UITextField alloc]initWithFrame:CGRectMake(380, self.userNameTf.bottom + 22, 280, 35)];
    self.userPassWorldTf.text = @"123.com";
    [self.view addSubview:self.userPassWorldTf];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(380, self.userPassWorldTf.bottom + 22, 280, 38)];
    [loginBtn setImage:DEF_IMAGENAME(@"Login_Btn") forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

-(void)login
{
    
       
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M001",
                           @"userName"         :self.userNameTf.text,
                           @"password"         :self.userPassWorldTf.text,
                           @"deviceToken"      :@"9a6c75bc32ccb2f1f4cdf060ba216046a68e964bcb230081102b61e9925e6e8a",
                           @"sign"             :[CACUtility getSignWithMethod:@"M001"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        [DEF_UserDefaults setObject:result forKey:SAVE_USERINFO];

        SelectViewController *vc = [[SelectViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } failture:^(id result) {
        
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
