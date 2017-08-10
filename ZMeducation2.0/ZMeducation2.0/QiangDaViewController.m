//
//  QiangDaViewController.m
//  ZMeducation2.0
//
//  Created by 李聪 on 2017/8/6.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "QiangDaViewController.h"

@interface QiangDaViewController ()
@property (nonatomic, strong)NSMutableDictionary *userInfo;
@property (nonatomic, weak) UIImageView *bgImagv;
@property(nonatomic, weak)UILabel *tiwenLb;
@property (nonatomic, strong)NSMutableDictionary *M2054Dic;
@property (nonatomic, weak)UIButton *tijiao2Btn;

@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UILabel *label2;

@end

@implementation QiangDaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [DEF_UserDefaults objectForKey:SAVE_USERINFO];
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
    imageTitle.image = DEF_IMAGE(@"qiangda_title");
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
    
    UIButton *tijiao2Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, bgImagv.bottom - 50, 180, 30)];
    tijiao2Btn.centerX = bgImagv.centerX;
    [tijiao2Btn addTarget:self action:@selector(tijiao2) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:tijiao2Btn];
    self.tijiao2Btn = tijiao2Btn;

    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(35, 150, 700, 200)];
    self.label1.numberOfLines = 10;
    [self.view addSubview:self.label1];
    
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(35, self.label1.bottom + 20, 700, 200)];
    self.label2.numberOfLines = 10;
    [self.view addSubview:self.label2];
    
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2054",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"raceId"           :self.dic[@"unitId"],
                            @"unitTypeId"       :self.dic[@"unitTypeId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2054"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        self.tiwenLb.text = result[@"raceTitle"];
        self.M2054Dic = result;

        if ([result[@"ifRace"] intValue] == 1) {
            [self.tijiao2Btn setImage:DEF_IMAGE(@"qiangda_sel") forState:UIControlStateNormal];
            self.tijiao2Btn.enabled = NO;
            
        }else{
            [self.tijiao2Btn setImage:DEF_IMAGE(@"qiangda_unsel") forState:UIControlStateNormal];
            self.tijiao2Btn.enabled = YES;
        }

        self.label1.text = [NSString stringWithFormat:@"已抢答同学:\n%@",result[@"raceUsers"]];
        
        self.label2.text = [NSString stringWithFormat:@"未抢答同学:\n%@",result[@"noRaceUsers"]];

        
    } failture:^(id result) {
    }];
}

-(void)tijiao2
{
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2055",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"], 
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"raceId"           :self.dic[@"unitId"],
                            @"unitTypeId"       :self.dic[@"unitTypeId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2055"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        if ([result[@"responseCode"] isEqualToString:@"00"]) {
            [CACUtility showTips:@"抢答成功"];
            [self.tijiao2Btn setImage:DEF_IMAGE(@"qiangda_sel") forState:UIControlStateNormal];
            self.tijiao2Btn.enabled = NO;
        }else if ([result[@"responseCode"] isEqualToString:@"96"]){
            [CACUtility showTips:result[@"responseMessage"]];
        }else{
            [CACUtility showTips:@"抢答失败"];
        }
    } failture:^(id result) {
        [CACUtility showTips:@"抢答失败"];
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
