//
//  LunTanViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/20.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "LunTanViewController.h"

@interface LunTanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic, strong)NSMutableDictionary *result;
@property (nonatomic, weak) UIImageView *bgImagv;

@property (nonatomic, strong)UITableView *tabv;

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
    
    UIImageView *bgImagv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, self.view.width - 30 - 175, self.view.height - 30 - 95)];
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
    [selBtn addTarget:selBtn action:@selector(sel) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:selBtn];
    
}

-(void)sel
{
    
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
