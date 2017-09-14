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

@property (nonatomic, weak) UITextView *tiwenLb;

@property (nonatomic, weak)UIImageView *tiwenScro;

@property (nonatomic, strong) NSMutableArray *chaxunArr;

@property (nonatomic, weak) UITextView *tv;

@property (nonatomic, strong) NSMutableArray *arr2;

@property (nonatomic, weak) UIImageView *bgImagv;

@property (nonatomic, weak) UITextView *lable1;
@property (nonatomic, weak) UITextView *lable2;
@property (nonatomic, weak) UITextView *lable3;
@property (nonatomic, weak) UITextView *lable4;


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
    imagetiwen.userInteractionEnabled = YES;
    [bgImagv addSubview:imagetiwen];
    
    UITextView *tiwenLb = [[UITextView alloc]initWithFrame:CGRectMake(50, 0, imagetiwen.width - 50, imagetiwen.height)];
    tiwenLb.font = DEF_MyFont(16);
    tiwenLb.editable = NO;
    [imagetiwen addSubview:tiwenLb];
    self.tiwenLb = tiwenLb;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(365, 242 + 20, 180, 30)];
    [btn setImage:DEF_IMAGE(@"tiankongti_tijiao") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(btn.right + 40, 242 + 20, 180, 30)];
    [btn1 setImage:DEF_IMAGE(@"tiankongti_chaxun") forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(chaxun) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:btn1];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(25, btn.bottom + 15, bgImagv.width - 50, 2)];
    lineView.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [bgImagv addSubview:lineView];
    
    UITextView *lable1 = [[UITextView alloc]initWithFrame:CGRectMake(25, lineView.bottom + 10, lineView.width, 70)];
    lable1.editable = NO;
    lable1.backgroundColor = [UIColor clearColor];
    lable1.font = DEF_MyFont(16);
    [bgImagv addSubview:lable1];
    self.lable1 = lable1;
    
    UITextView *lable2 = [[UITextView alloc]initWithFrame:CGRectMake(25, lable1.bottom + 10, lineView.width, 70)];
    lable2.editable = NO;
    lable2.backgroundColor = [UIColor clearColor];
    lable2.font = DEF_MyFont(16);

    [bgImagv addSubview:lable2];
    self.lable2 = lable2;
    
    UITextView *lable3 = [[UITextView alloc]initWithFrame:CGRectMake(25, lable2.bottom + 10, lineView.width, 70)];
    lable3.editable = NO;
    lable3.backgroundColor = [UIColor clearColor];
    lable3.font = DEF_MyFont(16);

    [bgImagv addSubview:lable3];
    self.lable3 = lable3;
    
    UITextView *lable4 = [[UITextView alloc]initWithFrame:CGRectMake(25, lable3.bottom + 10, lineView.width, 70)];
    lable4.editable = NO;
    lable4.backgroundColor = [UIColor clearColor];
    lable4.font = DEF_MyFont(16);

    [bgImagv addSubview:lable4];
    self.lable4 = lable4;
    
    UIScrollView *scr = [[UIScrollView alloc]initWithFrame:CGRectMake(120, imagetiwen.bottom + 20, 600, 37*4)];
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
                           @"unitId"           :_dic[@"unitId"],
                           @"unitTypeId"       :_dic[@"unitTypeId"],
                           @"sign"             :[CACUtility getSignWithMethod:@"M2021"]};
    @weakify(self);
    [RequestOperationManager getParametersDic:dic1 success:^(NSMutableDictionary *result) {
        @strongify(self);
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
                    
                    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imgv.right + 15, y, 600, 40)];
                    label.text = dic[@"title"];
                    label.numberOfLines = 2;
                    label.font = DEF_MyFont(15);
                    [scr addSubview:label];
                    
                }else{
                    UIButton *imgv = [[UIButton alloc]initWithFrame:CGRectMake(0, y, 25, 25)];
                    [imgv setImage:DEF_IMAGE(@"danxuanti_unsel") forState:UIControlStateNormal];
                    [imgv addTarget:self action:@selector(sel:) forControlEvents:UIControlEventTouchUpInside];
                    imgv.tag = 1000 + i;
                    [scr addSubview:imgv];
                    
                    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imgv.right + 15, y, 600, 40)];
                    label.text = dic[@"title"];
                    label.numberOfLines = 2;
                    label.font = DEF_MyFont(15);

                    [scr addSubview:label];
                }
                
            }else{
                
                UIButton *imgv = [[UIButton alloc]initWithFrame:CGRectMake(0, y, 25, 25)];
                [imgv setImage:DEF_IMAGE(@"danxuanti_unsel") forState:UIControlStateNormal];
                [imgv addTarget:self action:@selector(sel:) forControlEvents:UIControlEventTouchUpInside];
                imgv.tag = 1000 + i;
                [scr addSubview:imgv];
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imgv.right + 15, y, 600, 40)];
                label.text = dic[@"title"];
                label.numberOfLines = 2;
                label.font = DEF_MyFont(15);

                [scr addSubview:label];
            }
            
            y+= 37 + 15 ;
        }
        scr.contentSize = CGSizeMake(600, (37 + 15) *arr1.count);

        [CACUtility hideMBProgress:DEF_MyAppDelegate.window];

    } failture:^(id result) {
        [CACUtility hideMBProgress:DEF_MyAppDelegate.window];

    }];

}

-(void)sel:(UIButton *)sender
{
    int tag = (int)sender.tag - 1000;
    
    for (int i = 0; i <[self.arr2 count]; i++) {
        NSMutableDictionary *dic = (NSMutableDictionary *)self.arr2[i];

        UIButton *btn = [self.bgImagv viewWithTag:i + 1000];
        [btn setImage:DEF_IMAGE(@"danxuanti_unsel") forState:UIControlStateNormal];
        [dic setObject:@"0" forKey:@"flag"];
        if (i == tag) {
            [sender setImage:DEF_IMAGE(@"danxuanti_sel") forState:UIControlStateNormal];
            [dic setObject:@"1" forKey:@"flag"];
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
