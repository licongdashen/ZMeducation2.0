//
//  TianKongTiViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/13.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "TianKongTiViewController.h"

@interface TianKongTiViewController ()

@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic, strong)NSMutableDictionary *result;

@property (nonatomic, weak) UILabel *tiwenLb;

@end

@implementation TianKongTiViewController

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

    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M021",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitType"],
                           @"sign"             :[CACUtility getSignWithMethod:@"m003"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        self.result = result;
        self.tiwenLb.text = self.result[@"title"];

    } failture:^(id result) {
        
    }];

    UIImageView *bgImagv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, self.view.width - 30 - 175, self.view.height - 30 - 95)];
    bgImagv.image = DEF_IMAGE(@"tiankongti_Bg");
    bgImagv.userInteractionEnabled = YES;
    [self.view addSubview:bgImagv];
    
    UIImageView *imageTitle = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 80, 30)];
    imageTitle.contentMode = UIViewContentModeScaleAspectFit;
    imageTitle.image = DEF_IMAGE(@"tiankongti_title");
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
