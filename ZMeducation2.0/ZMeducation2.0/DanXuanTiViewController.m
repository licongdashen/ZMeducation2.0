//
//  DanXuanTiViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/19.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "DanXuanTiViewController.h"

@interface DanXuanTiViewController ()

@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic, strong)NSMutableDictionary *result;

@property (nonatomic, weak) UILabel *tiwenLb;

@property (nonatomic, weak)UIImageView *tiwenScro;

@property (nonatomic, strong) NSMutableArray *chaxunArr;

@property (nonatomic, weak) UITextView *tv;

@end

@implementation DanXuanTiViewController

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
    
    UIImageView *imageTitle = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 80, 30)];
    imageTitle.contentMode = UIViewContentModeScaleAspectFit;
    imageTitle.image = DEF_IMAGE(@"danxuanti_title");
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

    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(365, 242, 180, 30)];
    [btn setImage:DEF_IMAGE(@"tiankongti_tijiao") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(btn.right + 40, 242, 180, 30)];
    [btn1 setImage:DEF_IMAGE(@"tiankongti_chaxun") forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(chaxun) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:btn1];
    
    
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tabv.width, 2)];
//    lineView.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
//    [bgImagv addSubview:lineView];
    
    
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
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M021"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        self.result = result;
        self.tiwenLb.text = self.result[@"title"];
        NSString *str = self.result[@"content"];
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *err;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                             
                                                            options:NSJSONReadingMutableContainers
                             
                                                              error:&err];
        NSLog(@"dddddddd%@",dic);
       
    } failture:^(id result) {
        
    }];
}

-(void)tijiao
{
    
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M022",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"content"          :self.tv.text,
                           @"sign"             :[CACUtility getSignWithMethod:@"M022"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        
        if ([result[@"responseCode"] isEqualToString:@"00"]) {
            [CACUtility showTips:@"提交成功"];
        }else if ([result[@"responseCode"] isEqualToString:@"96"]){
            [CACUtility showTips:result[@"responseMessage"]];
        }else{
            [CACUtility showTips:@"提交失败"];
        }
        
    } failture:^(id result) {
        [CACUtility showTips:@"提交失败"];
    }];
}

-(void)chaxun
{
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M023",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M023"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        self.chaxunArr = result[@"contents"];
        
    } failture:^(id result) {
        [CACUtility showTips:@"提交失败"];
    }];
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
