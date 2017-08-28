//
//  DuoXuanTiViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/20.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "DuoXuanTiViewController.h"

@interface DuoXuanTiViewController ()
@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic, strong)NSMutableDictionary *result;

@property (nonatomic, weak) UILabel *tiwenLb;

@property (nonatomic, weak)UIImageView *tiwenScro;

@property (nonatomic, strong) NSMutableArray *chaxunArr;

@property (nonatomic, weak) UITextView *tv;

@property (nonatomic, strong) NSMutableArray *arr2;

@property (nonatomic, weak) UIImageView *bgImagv;

@property (nonatomic, weak) UILabel *lable1;
@property (nonatomic, weak) UILabel *lable2;
@property (nonatomic, weak) UILabel *lable3;
@property (nonatomic, weak) UILabel *lable4;

@end

@implementation DuoXuanTiViewController

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
    imageTitle.image = DEF_IMAGE(@"");
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
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(25, btn.bottom + 15, bgImagv.width - 50, 2)];
    lineView.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [bgImagv addSubview:lineView];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(25, lineView.bottom + 10, lineView.width, 70)];
    [bgImagv addSubview:lable1];
    self.lable1 = lable1;
    
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(25, lable1.bottom + 10, lineView.width, 70)];
    [bgImagv addSubview:lable2];
    self.lable2 = lable2;
    
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(25, lable2.bottom + 10, lineView.width, 70)];
    [bgImagv addSubview:lable3];
    self.lable3 = lable3;
    
    UILabel *lable4 = [[UILabel alloc]initWithFrame:CGRectMake(25, lable3.bottom + 10, lineView.width, 70)];
    [bgImagv addSubview:lable4];
    self.lable4 = lable4;
    
    UIScrollView *scr = [[UIScrollView alloc]initWithFrame:CGRectMake(120, imagetiwen.bottom + 20, 250, 37*4)];
    [bgImagv addSubview:scr];

    
    NSDictionary * dic1 = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M2021",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M2021"]};
    [RequestOperationManager getParametersDic:dic1 success:^(NSMutableDictionary *result) {
        self.result = result;
        self.tiwenLb.text = self.result[@"title"];

        self.arr2 = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in self.result[@"content"]) {
            NSMutableDictionary *dic111 = [[NSMutableDictionary alloc]initWithDictionary:dic];
            [self.arr2 addObject:dic111];
        }
        
        NSArray *arr1 = result[@"options"];
        int y = 0;
        for (int i = 0; i < [arr1 count]; i++) {
            NSDictionary *dic = arr1[i];
            if ([self.arr2 count] > 0) {
                NSDictionary *dic1 = self.arr2[i];
                if ([dic1[@"flag"] intValue] == 1) {
                    UIButton *imgv = [[UIButton alloc]initWithFrame:CGRectMake(0, y, 25, 25)];
                    [imgv setImage:DEF_IMAGE(@"danxuanti_sel") forState:UIControlStateNormal];
                    imgv.tag = 1000 + i;
                    [imgv addTarget:self action:@selector(sel:) forControlEvents:UIControlEventTouchUpInside];
                    [scr addSubview:imgv];
                    
                    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imgv.right + 15, y, 400, 25)];
                    label.text = dic[@"title"];
                    [scr addSubview:label];
                    
                }else{
                    UIButton *imgv = [[UIButton alloc]initWithFrame:CGRectMake(0, y, 25, 25)];
                    [imgv setImage:DEF_IMAGE(@"danxuanti_unsel") forState:UIControlStateNormal];
                    [imgv addTarget:self action:@selector(sel:) forControlEvents:UIControlEventTouchUpInside];
                    imgv.tag = 1000 + i;
                    [scr addSubview:imgv];
                    
                    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imgv.right + 15, y, 400, 25)];
                    label.text = dic[@"title"];
                    [scr addSubview:label];
                }
                
            }else{
                
                UIButton *imgv = [[UIButton alloc]initWithFrame:CGRectMake(0, y, 25, 25)];
                [imgv setImage:DEF_IMAGE(@"danxuanti_unsel") forState:UIControlStateNormal];
                [imgv addTarget:self action:@selector(sel:) forControlEvents:UIControlEventTouchUpInside];
                imgv.tag = 1000 + i;
                [scr addSubview:imgv];
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imgv.right + 15, y, 400, 25)];
                label.text = dic[@"title"];
                [scr addSubview:label];
            }
            
            y+=37;
            
        }
        scr.contentSize =CGSizeMake(250, 37 *arr1.count);

    } failture:^(id result) {
        
    }];
}
-(void)sel:(UIButton *)sender
{
    int tag = (int)sender.tag - 1000;
    
    for (int i = 0; i <[self.arr2 count]; i++) {
        NSMutableDictionary *dic = self.arr2[i];
        
//        UIButton *btn = [self.bgImagv viewWithTag:i + 1000];
//        [btn setImage:DEF_IMAGE(@"danxuanti_unsel") forState:UIControlStateNormal];
//        [dic setObject:@"0" forKey:@"flag"];
        if (i == tag) {
            if ([dic[@"flag"] intValue] == 1) {
                [sender setImage:DEF_IMAGE(@"danxuanti_unsel") forState:UIControlStateNormal];
                [dic setObject:@"0" forKey:@"flag"];
            }else{
                [sender setImage:DEF_IMAGE(@"danxuanti_sel") forState:UIControlStateNormal];
                [dic setObject:@"1" forKey:@"flag"];
            }
        }
    }
}

-(void)tijiao
{
    
    NSDictionary * dic = @{@"version"          :@"2.0.0",
                           @"clientType"       :@"1001",
                           @"signType"         :@"md5",
                           @"timestamp"        :[CACUtility getNowTime],
                           @"method"           :@"M2022",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"content"          :[CACUtility dictionaryToJson:self.arr2],
                           @"sign"             :[CACUtility getSignWithMethod:@"M2022"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        
        if ([result[@"responseCode"] isEqualToString:@"00"]) {
            [CACUtility showTips:@"提交成功"];
        }else if ([result[@"responseCode"] isEqualToString:@"96"]){
            if (result[@"responseMessage"] != nil) {
                [CACUtility showTips:result[@"responseMessage"]];
            }
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
                           @"method"           :@"M2023",
                           @"userId"           :self.userInfo[@"userId"],
                           @"gradeId"          :self.userInfo[@"gradeId"],
                           @"classId"          :self.userInfo[@"classId"],
                           @"courseId"         :self.userInfo[@"courseId"],
                           @"unitId"           :self.dic[@"unitId"],
                           @"unitTypeId"       :self.dic[@"unitTypeId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M2023"]};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        self.lable1.text = result[@"options"][0][@"title"];
        
        self.lable2.text = result[@"options"][0][@"authorNames"];
        
        self.lable3.text = result[@"options"][1][@"title"];
        
        self.lable4.text = result[@"options"][1][@"authorNames"];
        
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
