//
//  XieZuoViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/13.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "XieZuoViewController.h"
#import "CustomLine.h"

@interface XieZuoViewController ()

@property (nonatomic, strong)UIButton *btn1;

@property (nonatomic, strong)UIButton *btn2;

@property (nonatomic, strong)UIButton *btn3;

@property (nonatomic, strong)UIView *gousiBackView;

@property (nonatomic, strong)UIView *wendangBackView;

@property (nonatomic, strong)UIView *ketangBackView;

@property (nonatomic, strong)UIScrollView *gousiScro;
@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic,strong) NSMutableArray *M2009Arr;

@property (nonatomic, weak) UIScrollView *scro;

@end

@implementation XieZuoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userInfo = [DEF_UserDefaults objectForKey:SAVE_USERINFO];

    self.M2009Arr = [[NSMutableArray alloc]init];
    
    UIImageView *imagvBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 95)];
    imagvBg.image = DEF_IMAGENAME(@"xiezuo_bg");
    imagvBg.userInteractionEnabled = YES;
    [self.view addSubview:imagvBg];
    
    UIScrollView *scro = [[UIScrollView alloc]initWithFrame:CGRectMake(40, 23, DEF_DEVICE_WIDTH - 80, 30)];
    [self.view addSubview:scro];
    self.scro = scro;
    
//    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(335, 23, 115, 30)];
//    btn1.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
//    btn1.layer.cornerRadius = 15;
//    btn1.layer.borderWidth = 2;
//    btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
//    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn1 setTitle:@"我的构思" forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(action1) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn1];
//    self.btn1 = btn1;
//    
//    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.right + 5, 23, 115, 30)];
//    btn2.backgroundColor = [UIColor clearColor];
//    btn2.layer.cornerRadius = 15;
//    btn2.layer.borderWidth = 2;
//    btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
//    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn2 setTitle:@"我的文档" forState:UIControlStateNormal];
//    [btn2 addTarget:self action:@selector(action2) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn2];
//    self.btn2 = btn2;
//    
//    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(btn2.right + 5, 23, 115, 30)];
//    btn3.backgroundColor = [UIColor clearColor];
//    btn3.layer.cornerRadius = 15;
//    btn3.layer.borderWidth = 2;
//    btn3.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
//    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn3 setTitle:@"我的课堂" forState:UIControlStateNormal];
//    [btn3 addTarget:self action:@selector(action3) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn3];
//    self.btn3 = btn3;
    
    self.gousiBackView = [[UIView alloc]initWithFrame:CGRectMake(0, scro.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - scro.bottom)];
    self.gousiBackView.hidden = YES;
    [self.view addSubview:self.gousiBackView];
    
    self.wendangBackView = [[UIView alloc]initWithFrame:CGRectMake(0, scro.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - scro.bottom)];
    self.wendangBackView.hidden = YES;
    [self.view addSubview:self.wendangBackView];
    
    self.ketangBackView = [[UIView alloc]initWithFrame:CGRectMake(0, scro.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - scro.bottom)];
    self.ketangBackView.hidden = YES;
    [self.view addSubview:self.ketangBackView];
    
    
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2009",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"typeId"           :@"2",
                            @"sign"             :[CACUtility getSignWithMethod:@"M2009"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        for (NSMutableDictionary *dic in result[@"modules"]) {
            for (NSMutableDictionary *dic1 in dic[@"units"]) {
                [self.M2009Arr addObject:dic1];
            }
        }
        
        int x = 0;
        for (int i = 0; i< self.M2009Arr.count; i++) {
            NSMutableDictionary *dic = self.M2009Arr[i];
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, 0, 115, 30)];
            btn.layer.cornerRadius = 15;
            btn.layer.borderWidth = 2;
            btn.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
            [btn setTitle:dic[@"unitName"] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
            btn.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = -100 + i;
            [self.scro addSubview:btn];
            
            x += 120;
            
            self.scro.contentSize = CGSizeMake(x, 30);
        }
    } failture:^(id result) {
        
    }];
    
    
}

-(void)action:(UIButton *)sender
{
    for (UIView *view in [self.scro subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.backgroundColor = [UIColor clearColor];
            btn.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    sender.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    sender.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    int tag = (int)sender.tag + 100;
    
    if ([self.M2009Arr[tag][@"unitName"] isEqualToString:@"我的构思"]) {
        self.gousiBackView.hidden = NO;
        self.wendangBackView.hidden = YES;
        self.ketangBackView.hidden = YES;
        [self loadGousi];
    }else if ([self.M2009Arr[tag][@"unitName"] isEqualToString:@"我的文稿"]) {
        self.gousiBackView.hidden = YES;
        self.wendangBackView.hidden = NO;
        self.ketangBackView.hidden = YES;
    }else{
        self.gousiBackView.hidden = YES;
        self.wendangBackView.hidden = YES;
        self.ketangBackView.hidden = NO;
    }

}

-(void)loadGousi
{
    for (UIView *view in [self.gousiBackView subviews]) {
        [view removeFromSuperview];
    }
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(30, 40, 250, 70)];
    imagv.contentMode = UIViewContentModeScaleAspectFit;
    imagv.clipsToBounds = YES;
    imagv.image = DEF_IMAGE(@"gousi_Bg");
    [self.gousiBackView addSubview:imagv];
    
    self.gousiScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, self.gousiBackView.width, self.gousiBackView.height - 110)];
    self.gousiScro.alwaysBounceVertical = YES;
    self.gousiScro.alwaysBounceHorizontal = YES;
    [self.gousiBackView addSubview:self.gousiScro];
    
    NSDictionary * dic = @{
                           @"method"           :@"M301",
                           @"level2"           :@"6",
                           @"level3"           :@"4",
                           @"level4"           :@"2"};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        
        self.gousiScro.contentSize = CGSizeMake(2000, 3000);
        self.gousiScro.contentOffset = CGPointMake(self.gousiScro.contentSize.width/2 - self.gousiScro.size.width/2, self.gousiScro.contentSize.height/2 - self.gousiScro.size.height/2);
        
        UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.gousiScro.contentSize.width/2 - 120, self.gousiScro.contentSize.height/2 - 62, 240, 125)];
        level1.userInteractionEnabled = YES;
        level1.image = DEF_IMAGE(@"gousi_yun");
        level1.contentMode = UIViewContentModeScaleAspectFill;
        level1.backgroundColor = [UIColor whiteColor];
        level1.clipsToBounds = YES;
        [self.gousiScro addSubview:level1];
        
        int count = 2;
        
        if (count == 2) {
            NSMutableArray *arr2 = result[@"list"][0][@"list"];
            NSMutableArray *pointArr = [[NSMutableArray alloc]init];
            
            if ([arr2 count]%2 == 0) {
                
                float x1 = level1.centerX - 300;
                float x2 = level1.centerX + 300;
                float y1 = level1.centerY - 300;
                float y2 = level1.centerY - 300;
                for (int i = 0; i < [arr2 count]; i ++) {
                    if (i < [arr2 count]/2) {
                        
                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x1, y1)];
                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        //                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x1],@"y1":[NSString stringWithFormat:@"%f",y1],
                                              @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY]}];
                        y1 += 600/([arr2 count]/2 - 1);
                        
                    }else{
                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x2, y2)];
                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        //                        [self.gousiScro addSubview:line];
                        //[pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",x2],@"y":[NSString stringWithFormat:@"%f",y2]}];
                        
                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x2],@"y1":[NSString stringWithFormat:@"%f",y2],
                                              @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY]}];
                        y2 += 600/([arr2 count]/2 - 1);
                    }
                }
                
            }else{
                
                float x1 = level1.centerX - 300;
                float x2 = level1.centerX + 300;
                float y1 = level1.centerY - 300;
                float y2 = level1.centerY - 300;
                
                //                CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(level1.centerX, level1.centerY - 300)];
                //                line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                //                [self.gousiScro addSubview:line];
                
                [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",level1.centerX],@"y1":[NSString stringWithFormat:@"%f",level1.centerY - 300],
                                      @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY]}];
                
                
                NSMutableArray *tempArr = [[NSMutableArray alloc]initWithArray:arr2];
                [tempArr removeObjectAtIndex:0];
                
                for (int i = 0; i < [tempArr count]; i ++) {
                    if (i < [tempArr count]/2) {
                        
                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x1, y1)];
                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        //                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x1],@"y1":[NSString stringWithFormat:@"%f",y1],
                                              @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY]}];
                        
                        y1 += 600/([tempArr count]/2 - 1);
                    }else{
                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x2, y2)];
                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        //                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x2],@"y1":[NSString stringWithFormat:@"%f",y2],
                                              @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY]}];
                        
                        y2 += 600/([tempArr count]/2 - 1);
                    }
                }
                
            }
            
            CustomLine *line = [[CustomLine alloc]initWithPointArr:pointArr];
            line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
            [self.gousiScro addSubview:line];

            for (NSDictionary *dicc in pointArr) {
                
                UIImageView *level11 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
                level11.userInteractionEnabled = YES;
                level11.image = DEF_IMAGE(@"gousi_yun");
                level11.contentMode = UIViewContentModeScaleAspectFill;
                level11.backgroundColor = [UIColor whiteColor];
                level11.clipsToBounds = YES;
                level11.centerX = [dicc[@"x1"] floatValue];
                level11.centerY = [dicc[@"y1"] floatValue];
                [self.gousiScro addSubview:level11];
            }
            
            
            [self.gousiScro bringSubviewToFront:level1];
            
        }else if (count == 3){
            
            NSMutableArray *arr2 = result[@"list"][0][@"list"];
            NSMutableArray *pointArr = [[NSMutableArray alloc]init];
            
            if ([arr2 count]%2 == 0) {
                
                int count = 0;
                
                for (NSDictionary *dic in arr2) {
                    NSArray *arr3 = dic[@"list"];
                    for (NSDictionary *dic in arr3) {
                        count += 1;
                    }
                }
                
                float x1 = level1.centerX - 300;
                float x2 = level1.centerX + 300;
                float y1 = level1.centerY - 300;
                float y2 = level1.centerY - 300;
                
                float xx1 = x1 - 300;
                float yy1 = level1.centerY - (150*count/4);
                
                float xx2 = x2 + 300;
                float yy2 = level1.centerY - (150*count/4);
                
                for (int i = 0; i < [arr2 count]; i ++) {
                    
                    NSMutableDictionary *dic = arr2[i];
                    NSArray *arr3 = dic[@"list"];
                    
                    if (i < [arr2 count]/2) {
                        
                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x1, y1)];
                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        //                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x1],@"y1":[NSString stringWithFormat:@"%f",y1],
                                              @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY]}];
                        
                        for (NSDictionary *dic in arr3) {
                            
                            //                            CustomLine *line1 = [[CustomLine alloc]initWithStartPoint:CGPointMake(x1, y1) EndPoint:CGPointMake(xx1, yy1)];
                            //                            line1.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                            //                            [self.gousiScro addSubview:line1];
                            [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",xx1],@"y1":[NSString stringWithFormat:@"%f",yy1],
                                                  @"x"  :[NSString stringWithFormat:@"%f",x1],@"y" :[NSString stringWithFormat:@"%f",y1]}];
                            
                            UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
                            level1.userInteractionEnabled = YES;
                            level1.image = DEF_IMAGE(@"gousi_yun");
                            level1.contentMode = UIViewContentModeScaleAspectFill;
                            level1.backgroundColor = [UIColor whiteColor];
                            level1.clipsToBounds = YES;
                            level1.centerX = xx1;
                            level1.centerY = yy1;
                            [self.gousiScro addSubview:level1];
                            
                            yy1 += 150;
                        }
                        y1 += 600/([arr2 count]/2 - 1);
                        
                    }else{
                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x2, y2)];
                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        //                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x2],@"y1":[NSString stringWithFormat:@"%f",y2],
                                              @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY]}];
                        
                        for (NSDictionary *dic in arr3) {
                            
                            //                            CustomLine *line1 = [[CustomLine alloc]initWithStartPoint:CGPointMake(x2, y2) EndPoint:CGPointMake(xx2, yy2)];
                            //                            line1.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                            //                            [self.gousiScro addSubview:line1];
                            
                            [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",xx2],@"y1":[NSString stringWithFormat:@"%f",yy2],
                                                  @"x"  :[NSString stringWithFormat:@"%f",x2],@"y" :[NSString stringWithFormat:@"%f",y2]}];
                            
                            UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
                            level1.userInteractionEnabled = YES;
                            level1.image = DEF_IMAGE(@"gousi_yun");
                            level1.contentMode = UIViewContentModeScaleAspectFill;
                            level1.backgroundColor = [UIColor whiteColor];
                            level1.clipsToBounds = YES;
                            level1.centerX = xx2;
                            level1.centerY = yy2;
                            [self.gousiScro addSubview:level1];
                            
                            yy2 += 150;
                        }
                        
                        y2 += 600/([arr2 count]/2 - 1);
                    }
                }
                
                CustomLine *line = [[CustomLine alloc]initWithPointArr:pointArr];
                line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                [self.gousiScro addSubview:line];
                
                for (UIView *view in [self.gousiScro subviews]) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        [self.gousiScro bringSubviewToFront:view];
                    }
                }
            }else{
                
                int count = 0;
                
                for (NSDictionary *dic in arr2) {
                    NSArray *arr3 = dic[@"list"];
                    for (NSDictionary *dic in arr3) {
                        count += 1;
                    }
                }
                
                float x1 = level1.centerX - 300;
                float x2 = level1.centerX + 300;
                float y1 = level1.centerY - 300;
                float y2 = level1.centerY - 300;
                
                float xx1 = x1 - 300;
                float yy1 = level1.centerY - (150*count/4);
                
                float xx2 = x2 + 300;
                float yy2 = level1.centerY - (150*count/4);
                
                //                CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(level1.centerX, level1.centerY - 300)];
                //                line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                //                [self.gousiScro addSubview:line];
                [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",level1.centerX],@"y1":[NSString stringWithFormat:@"%f",level1.centerY - 300],
                                      @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY]}];
                
                NSDictionary *dic = [arr2 objectAtIndex:0];
                NSArray *arr4 = dic[@"list"];
                
                float xxx = level1.centerX + 200;
                float yyy = level1.centerY - 600;
                
                for (int i = 0; i < [arr4 count]; i ++) {
                    //                    CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY - 300) EndPoint:CGPointMake(xxx, yyy)];
                    //                    line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                    //                    [self.gousiScro addSubview:line];
                    
                    [pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",level1.centerX],@"y":[NSString stringWithFormat:@"%f",level1.centerY - 300],
                                          @"x1"  :[NSString stringWithFormat:@"%f",xxx],@"y1" :[NSString stringWithFormat:@"%f",yyy]}];
                    
                    UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
                    level1.userInteractionEnabled = YES;
                    level1.image = DEF_IMAGE(@"gousi_yun");
                    level1.contentMode = UIViewContentModeScaleAspectFill;
                    level1.backgroundColor = [UIColor whiteColor];
                    level1.clipsToBounds = YES;
                    level1.centerX = xxx;
                    level1.centerY = yyy;
                    [self.gousiScro addSubview:level1];
                    yyy -= 150;
                }
                
                NSMutableArray *tempArr = [[NSMutableArray alloc]initWithArray:arr2];
                [tempArr removeObjectAtIndex:0];
                
                for (int i = 0; i < [tempArr count]; i ++) {
                    NSMutableDictionary *dic = tempArr[i];
                    NSArray *arr3 = dic[@"list"];
                    if (i < [tempArr count]/2) {
                        
                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x1, y1)];
                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        //                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x1],@"y1":[NSString stringWithFormat:@"%f",y1],
                                              @"x" :[NSString stringWithFormat:@"%f",level1.centerX],@"y":[NSString stringWithFormat:@"%f",level1.centerY]}];
                        
                        for (NSDictionary *dic in arr3) {
                            
                            //                            CustomLine *line1 = [[CustomLine alloc]initWithStartPoint:CGPointMake(x1, y1) EndPoint:CGPointMake(xx1, yy1)];
                            //                            line1.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                            //                            [self.gousiScro addSubview:line1];
                            
                            [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",xx1],@"y1":[NSString stringWithFormat:@"%f",yy1],
                                                  @"x" :[NSString stringWithFormat:@"%f",x1],@"y":[NSString stringWithFormat:@"%f",y1]}];
                            
                            UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
                            level1.userInteractionEnabled = YES;
                            level1.image = DEF_IMAGE(@"gousi_yun");
                            level1.contentMode = UIViewContentModeScaleAspectFill;
                            level1.backgroundColor = [UIColor whiteColor];
                            level1.clipsToBounds = YES;
                            level1.centerX = xx1;
                            level1.centerY = yy1;
                            [self.gousiScro addSubview:level1];
                            
                            yy1 += 150;
                        }
                        
                        y1 += 600/([tempArr count]/2 - 1);
                    }else{
                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x2, y2)];
                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        //                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x2],@"y1":[NSString stringWithFormat:@"%f",y2],
                                              @"x" :[NSString stringWithFormat:@"%f",level1.centerX],@"y":[NSString stringWithFormat:@"%f",level1.centerY]}];
                        
                        for (NSDictionary *dic in arr3) {
                            
                            //                            CustomLine *line1 = [[CustomLine alloc]initWithStartPoint:CGPointMake(x2, y2) EndPoint:CGPointMake(xx2, yy2)];
                            //                            line1.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                            //                            [self.gousiScro addSubview:line1];
                            
                            [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",xx2],@"y1":[NSString stringWithFormat:@"%f",yy2],
                                                  @"x" :[NSString stringWithFormat:@"%f",x2],@"y":[NSString stringWithFormat:@"%f",y2]}];
                            
                            UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
                            level1.userInteractionEnabled = YES;
                            level1.image = DEF_IMAGE(@"gousi_yun");
                            level1.contentMode = UIViewContentModeScaleAspectFill;
                            level1.backgroundColor = [UIColor whiteColor];
                            level1.clipsToBounds = YES;
                            level1.centerX = xx2;
                            level1.centerY = yy2;
                            [self.gousiScro addSubview:level1];
                            
                            yy2 += 150;
                        }
                        
                        y2 += 600/([tempArr count]/2 - 1);
                    }
                }
                
                CustomLine *line = [[CustomLine alloc]initWithPointArr:pointArr];
                line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                [self.gousiScro addSubview:line];
                
                for (UIView *view in [self.gousiScro subviews]) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        [self.gousiScro bringSubviewToFront:view];
                    }
                }
                
            }
            
            for (NSDictionary *dicc in pointArr) {
                
                UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
                level1.userInteractionEnabled = YES;
                level1.image = DEF_IMAGE(@"gousi_yun");
                level1.contentMode = UIViewContentModeScaleAspectFill;
                level1.backgroundColor = [UIColor whiteColor];
                level1.clipsToBounds = YES;
                level1.centerX = [dicc[@"x"] floatValue];
                level1.centerY = [dicc[@"y"] floatValue];
                [self.gousiScro addSubview:level1];
            }
            
            [self.gousiScro bringSubviewToFront:level1];
            
        }
        
    } failture:^(id result) {
        
    }];

}

-(void)action1
{
    self.btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    self.btn1.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    self.btn2.backgroundColor = [UIColor clearColor];
    self.btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.btn3.backgroundColor = [UIColor clearColor];
    self.btn3.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.gousiBackView.hidden = NO;
    self.wendangBackView.hidden = YES;
    self.ketangBackView.hidden = YES;

}

-(void)action2
{
    self.btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    self.btn2.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    [self.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.btn1.backgroundColor = [UIColor clearColor];
    self.btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.btn3.backgroundColor = [UIColor clearColor];
    self.btn3.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.gousiBackView.hidden = YES;
    self.wendangBackView.hidden = NO;
    self.ketangBackView.hidden = YES;
}

-(void)action3
{
    self.btn3.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    self.btn3.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    [self.btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.btn2.backgroundColor = [UIColor clearColor];
    self.btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.btn1.backgroundColor = [UIColor clearColor];
    self.btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.gousiBackView.hidden = YES;
    self.wendangBackView.hidden = YES;
    self.ketangBackView.hidden = NO;
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
