//
//  TianKongTiViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/13.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "TianKongTiViewController.h"

@interface TianKongTiViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic, strong)NSMutableDictionary *result;

@property (nonatomic, weak) UITextView *tiwenLb;

@property (nonatomic, weak)UIScrollView *tiwenScro;

@property (nonatomic, strong) UITableView *tabv;

@property (nonatomic, strong) NSMutableArray *chaxunArr;

@property (nonatomic, weak) UIImageView *bgImagv;
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

//    UIImageView *bgImagv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, self.view.width - 30 - 175, self.view.height - 30 - 95)];
//    bgImagv.image = DEF_IMAGE(@"tiankongti_Bg");
//    bgImagv.userInteractionEnabled = YES;
//    [self.view addSubview:bgImagv];
//    self.bgImagv = bgImagv;
//    
//    UIImageView *imageTitle = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 80, 30)];
//    imageTitle.contentMode = UIViewContentModeScaleAspectFit;
//    imageTitle.image = DEF_IMAGE(@"tiankongti_title");
//    imageTitle.centerX = bgImagv.centerX;
//    [bgImagv addSubview:imageTitle];
//    
//    UIImageView *imagetouxiang = [[UIImageView alloc]initWithFrame:CGRectMake(35, 50, 65, 55)];
//    imagetouxiang.contentMode = UIViewContentModeScaleAspectFit;
//    imagetouxiang.image = DEF_IMAGE(@"tiankongti_touxiang");
//    [bgImagv addSubview:imagetouxiang];
//    
//    UIImageView *imagetiwen = [[UIImageView alloc]initWithFrame:CGRectMake(imagetouxiang.right + 16, 50, 1354/2, 55)];
//    imagetiwen.contentMode = UIViewContentModeScaleAspectFit;
//    imagetiwen.image = DEF_IMAGE(@"tiankongti_tiwen");
//    [bgImagv addSubview:imagetiwen];
//    
//    UILabel *tiwenLb = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, imagetiwen.width - 50, imagetiwen.height)];
//    tiwenLb.font = DEF_MyFont(16);
//    [imagetiwen addSubview:tiwenLb];
//    self.tiwenLb = tiwenLb;
//    
//    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(35, imagetouxiang.bottom + 24, 100, 18)];
//    titleLb.text = @"请在此答题 :";
//    titleLb.font = DEF_MyFont(16);
//    [bgImagv addSubview:titleLb];
//    
//    UIScrollView *tiwenScro = [[UIScrollView alloc]initWithFrame:CGRectMake(titleLb.right, titleLb.y, 1354/2, 55)];
//    tiwenScro.userInteractionEnabled = YES;
//    [bgImagv addSubview:tiwenScro];
//    self.tiwenScro = tiwenScro;
//    
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(55, tiwenScro.bottom + 35, 180, 30)];
//    [btn setImage:DEF_IMAGE(@"tiankongti_tijiao") forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
//    [bgImagv addSubview:btn];
//    
//    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(btn.right + 350, tiwenScro.bottom + 35, 180, 30)];
//    [btn1 setImage:DEF_IMAGE(@"tiankongti_chaxun") forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(chaxun) forControlEvents:UIControlEventTouchUpInside];
//    [bgImagv addSubview:btn1];
//    
//    self.tabv = [[UITableView alloc]initWithFrame:CGRectMake(25, btn.bottom + 15, self.view.width - 30 - 175 - 50, 350) style:UITableViewStylePlain];
//    self.tabv.delegate = self;
//    self.tabv.dataSource = self;
//    self.tabv.backgroundColor = [UIColor clearColor];
//    self.tabv.hidden = YES;
//    self.tabv.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [bgImagv addSubview:self.tabv];
//    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tabv.width, 35)];
//    self.tabv.tableHeaderView = view;
//    
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tabv.width, 2)];
//    lineView.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
//    [view addSubview:lineView];
//    
//    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 33, self.tabv.width, 2)];
//    lineView1.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
//    [view addSubview:lineView1];
//    
//    UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 60, 35)];
//    nameLb.font = DEF_MyFont(17);
//    nameLb.text = @"提交人";
//    [view addSubview:nameLb];
//    
//    UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(317, 0, 80, 35)];
//    contentLb.font = DEF_MyFont(17);
//    contentLb.text = @"提交内容";
//    [view addSubview:contentLb];
//    
//    UILabel *timeLb = [[UILabel alloc]initWithFrame:CGRectMake(640, 0, 80, 35)];
//    timeLb.font = DEF_MyFont(17);
//    timeLb.text = @"提交时间";
//    [view addSubview:timeLb];
//    
//    NSDictionary * dic = @{@"version"          :@"2.0.0",
//                           @"clientType"       :@"1001",
//                           @"signType"         :@"md5",
//                           @"timestamp"        :[CACUtility getNowTime],
//                           @"method"           :@"M2021",
//                           @"userId"           :self.userInfo[@"userId"],
//                           @"gradeId"          :self.userInfo[@"gradeId"],
//                           @"classId"          :self.userInfo[@"classId"],
//                           @"courseId"         :self.userInfo[@"courseId"],
//                           @"unitId"           :self.dic[@"unitId"],
//                           @"unitTypeId"       :self.dic[@"unitTypeId"],
//                           @"sign"             :[CACUtility getSignWithMethod:@"M2021"]};
//    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
//        self.result = result;
//        self.tiwenLb.text = self.result[@"title"];
//        NSString *str = self.result[@"content"];
//        NSString *str1 = [str stringByReplacingOccurrencesOfString:@"[" withString:@""];
//        NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"]" withString:@""];
//        
//        NSArray *array = [str2 componentsSeparatedByString:@","];
//        tiwenScro.contentSize = CGSizeMake(170*[array count], 55);
//        int count = 1;
//        float x = 0;
//        for (NSString *str in array) {
//            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(x, 0, 15, 18)];
//            lable.font = DEF_MyFont(16);
//            lable.text = [NSString stringWithFormat:@"%d.",count];
//            [tiwenScro addSubview:lable];
//            
//            UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake(lable.right, 0, 140, 55)];
//            imagV.image = DEF_IMAGE(@"tiankongti_shuru1");
//            imagV.userInteractionEnabled = YES;
//            [tiwenScro addSubview:imagV];
//            
//            UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(lable.right, 0, imagV.width, imagV.height)];
//            tv.text = str;
//            tv.backgroundColor = [UIColor clearColor];
//            [tiwenScro addSubview:tv];
//            
//            x += 170;
//            count += 1;
//        }
//    } failture:^(id result) {
//        
//    }];
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
    imagetiwen.userInteractionEnabled = YES;
    [bgImagv addSubview:imagetiwen];
    
    UITextView *tiwenLb = [[UITextView alloc]initWithFrame:CGRectMake(50, 0, imagetiwen.width - 30, imagetiwen.height)];
    tiwenLb.font = DEF_MyFont(16);
    tiwenLb.editable = NO;
    [imagetiwen addSubview:tiwenLb];
    self.tiwenLb = tiwenLb;
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(35, imagetouxiang.bottom + 24, 100, 18)];
    titleLb.text = @"请在此答题 :";
    titleLb.font = DEF_MyFont(16);
    [bgImagv addSubview:titleLb];
    
    UIScrollView *tiwenScro = [[UIScrollView alloc]initWithFrame:CGRectMake(titleLb.right, titleLb.y, 1354/2, 55)];
    tiwenScro.userInteractionEnabled = YES;
    [bgImagv addSubview:tiwenScro];
    self.tiwenScro = tiwenScro;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(55, tiwenScro.bottom + 35, 180, 30)];
    [btn setImage:DEF_IMAGE(@"tiankongti_tijiao") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(btn.right + 350, tiwenScro.bottom + 35, 180, 30)];
    [btn1 setImage:DEF_IMAGE(@"tiankongti_chaxun") forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(chaxun) forControlEvents:UIControlEventTouchUpInside];
    [bgImagv addSubview:btn1];
    
    self.tabv = [[UITableView alloc]initWithFrame:CGRectMake(25, btn.bottom + 15, self.view.width - 30 - 50, 350) style:UITableViewStylePlain];
    self.tabv.delegate = self;
    self.tabv.dataSource = self;
    self.tabv.backgroundColor = [UIColor clearColor];
    self.tabv.hidden = YES;
    self.tabv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgImagv addSubview:self.tabv];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tabv.width, 35)];
    self.tabv.tableHeaderView = view;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tabv.width, 2)];
    lineView.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [view addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 33, self.tabv.width, 2)];
    lineView1.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [view addSubview:lineView1];
    
    UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 60, 35)];
    nameLb.font = DEF_MyFont(17);
    nameLb.text = @"提交人";
    [view addSubview:nameLb];
    
    UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(317, 0, 80, 35)];
    contentLb.font = DEF_MyFont(17);
    contentLb.text = @"提交内容";
    [view addSubview:contentLb];
    
    UILabel *timeLb = [[UILabel alloc]initWithFrame:CGRectMake(640, 0, 80, 35)];
    timeLb.font = DEF_MyFont(17);
    timeLb.text = @"提交时间";
    [view addSubview:timeLb];
    
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
        
        NSArray *array = self.result[@"content"];
        tiwenScro.contentSize = CGSizeMake(170*[array count], 55);
        int count = 1;
        float x = 0;
        for (NSString *str in array) {
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(x, 0, 15, 18)];
            lable.font = DEF_MyFont(16);
            lable.text = [NSString stringWithFormat:@"%d.",count];
            [tiwenScro addSubview:lable];
            
            UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake(lable.right, 0, 140, 55)];
            imagV.image = DEF_IMAGE(@"tiankongti_shuru1");
            imagV.userInteractionEnabled = YES;
            [tiwenScro addSubview:imagV];
            
            UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(lable.right, 0, imagV.width, imagV.height)];
            tv.text = str;
            tv.font = DEF_MyFont(16);
            tv.backgroundColor = [UIColor clearColor];
            [tiwenScro addSubview:tv];
            
            x += 170;
            count += 1;
        }
    } failture:^(id result) {
        
    }];

}
-(void)tijiao
{

    NSMutableArray *str = [[NSMutableArray alloc]init];
    
    for (UIView *view in [self.tiwenScro subviews]) {
        if ([view isKindOfClass:[UITextView class]]) {
            UITextView *tv = (UITextView *)view;
            [str addObject:tv.text];
            NSLog(@"tttttttt%@",str);
            
        }
    }
    
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
                           @"content"          :[CACUtility dictionaryToJson:str],
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
        self.chaxunArr = result[@"contents"];
        [self.tabv reloadData];
        self.tabv.hidden = NO;
    } failture:^(id result) {
        [CACUtility showTips:@"提交失败"];
    }];
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
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.chaxunArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 69, self.tabv.width, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:lineView];
        
        UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 80, 70)];
        nameLb.font = DEF_MyFont(16);
        nameLb.numberOfLines = 3;
        nameLb.tag = 200;
        [cell.contentView addSubview:nameLb];
        
        UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(nameLb.right + 10, 0, 450, 70)];
        contentLb.font = DEF_MyFont(16);
        contentLb.numberOfLines = 3;
        contentLb.tag = 201;
        [cell.contentView addSubview:contentLb];
        
        UILabel *timeLb = [[UILabel alloc]initWithFrame:CGRectMake(contentLb.right + 20, 0, 140, 70)];
        timeLb.font = DEF_MyFont(16);
        timeLb.numberOfLines = 3;
        timeLb.tag = 202;
        [cell.contentView addSubview:timeLb];

    }
    UILabel *nameLb = [cell.contentView viewWithTag:200];
    nameLb.text = self.chaxunArr[indexPath.row][@"authorName"];
    
    UILabel *contentLb = [cell.contentView viewWithTag:201];
    contentLb.text = self.chaxunArr[indexPath.row][@"content"];
    
    UILabel *timeLb = [cell.contentView viewWithTag:202];
    timeLb.text = self.chaxunArr[indexPath.row][@"lastUpdateTime"];
    
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
