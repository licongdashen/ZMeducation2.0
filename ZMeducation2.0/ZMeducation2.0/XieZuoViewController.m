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

@end

@implementation XieZuoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imagvBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 95)];
    imagvBg.image = DEF_IMAGENAME(@"xiezuo_bg");
    imagvBg.userInteractionEnabled = YES;
    [self.view addSubview:imagvBg];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(335, 23, 115, 30)];
    btn1.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    btn1.layer.cornerRadius = 15;
    btn1.layer.borderWidth = 2;
    btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"我的构思" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(action1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    self.btn1 = btn1;
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.right + 5, 23, 115, 30)];
    btn2.backgroundColor = [UIColor clearColor];
    btn2.layer.cornerRadius = 15;
    btn2.layer.borderWidth = 2;
    btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"我的文档" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(action2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    self.btn2 = btn2;
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(btn2.right + 5, 23, 115, 30)];
    btn3.backgroundColor = [UIColor clearColor];
    btn3.layer.cornerRadius = 15;
    btn3.layer.borderWidth = 2;
    btn3.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setTitle:@"我的课堂" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(action3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    self.btn3 = btn3;
    
    self.gousiBackView = [[UIView alloc]initWithFrame:CGRectMake(0, btn1.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - btn1.bottom)];
    [self.view addSubview:self.gousiBackView];
    
    self.wendangBackView = [[UIView alloc]initWithFrame:CGRectMake(0, btn1.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - btn1.bottom)];
    self.wendangBackView.hidden = YES;
    [self.view addSubview:self.wendangBackView];
    
    self.ketangBackView = [[UIView alloc]initWithFrame:CGRectMake(0, btn1.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - btn1.bottom)];
    self.ketangBackView.hidden = YES;
    [self.view addSubview:self.ketangBackView];
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(30, 40, 250, 70)];
    imagv.contentMode = UIViewContentModeScaleAspectFit;
    imagv.clipsToBounds = YES;
    imagv.image = DEF_IMAGE(@"gousi_Bg");
    [self.gousiBackView addSubview:imagv];
    
    self.gousiScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.gousiBackView.width, self.gousiBackView.height - 100)];
    self.gousiScro.alwaysBounceVertical = YES;
    self.gousiScro.alwaysBounceHorizontal = YES;
    [self.gousiBackView addSubview:self.gousiScro];

    
    NSDictionary * dic = @{
                           @"method"           :@"M301",
                           @"level2"           :@"7",
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
        
        int count = 3;
        
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
                        
                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x1, y1)];
                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",x1],@"y":[NSString stringWithFormat:@"%f",y1]}];
                        y1 += 600/([arr2 count]/2 - 1);
                        
                    }else{
                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x2, y2)];
                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",x2],@"y":[NSString stringWithFormat:@"%f",y2]}];

                        y2 += 600/([arr2 count]/2 - 1);
                    }
                }
                
            }else{
                
                float x1 = level1.centerX - 300;
                float x2 = level1.centerX + 300;
                float y1 = level1.centerY - 300;
                float y2 = level1.centerY - 300;
                
                CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(level1.centerX, level1.centerY - 300)];
                line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                [self.gousiScro addSubview:line];
                
                [pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",level1.centerX],@"y":[NSString stringWithFormat:@"%f",level1.centerY - 300]}];

                NSMutableArray *tempArr = [[NSMutableArray alloc]initWithArray:arr2];
                [tempArr removeObjectAtIndex:0];
                
                for (int i = 0; i < [tempArr count]; i ++) {
                    if (i < [tempArr count]/2) {
                        
                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x1, y1)];
                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",x1],@"y":[NSString stringWithFormat:@"%f",y1]}];

                        y1 += 600/([tempArr count]/2 - 1);
                    }else{
                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x2, y2)];
                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",x2],@"y":[NSString stringWithFormat:@"%f",y2]}];

                        y2 += 600/([tempArr count]/2 - 1);
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
                        
                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x1, y1)];
                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",x1],@"y":[NSString stringWithFormat:@"%f",y1]}];
                       
                        for (NSDictionary *dic in arr3) {
                            
                            CustomLine *line1 = [[CustomLine alloc]initWithStartPoint:CGPointMake(x1, y1) EndPoint:CGPointMake(xx1, yy1)];
                            line1.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                            [self.gousiScro addSubview:line1];
                            
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
                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x2, y2)];
                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",x2],@"y":[NSString stringWithFormat:@"%f",y2]}];
                        
                        for (NSDictionary *dic in arr3) {
                            
                            CustomLine *line1 = [[CustomLine alloc]initWithStartPoint:CGPointMake(x2, y2) EndPoint:CGPointMake(xx2, yy2)];
                            line1.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                            [self.gousiScro addSubview:line1];
                            
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

                CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(level1.centerX, level1.centerY - 300)];
                line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                [self.gousiScro addSubview:line];
                [pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",level1.centerX],@"y":[NSString stringWithFormat:@"%f",level1.centerY - 300]}];
                
                NSDictionary *dic = [arr2 objectAtIndex:0];
                NSArray *arr4 = dic[@"list"];
                
                float xxx = level1.centerX + 200;
                float yyy = level1.centerY - 600;

                for (int i = 0; i < [arr4 count]; i ++) {
                    CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY - 300) EndPoint:CGPointMake(xxx, yyy)];
                    line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                    [self.gousiScro addSubview:line];
                    
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
                        
                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x1, y1)];
                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",x1],@"y":[NSString stringWithFormat:@"%f",y1]}];
                        
                        for (NSDictionary *dic in arr3) {
                            
                            CustomLine *line1 = [[CustomLine alloc]initWithStartPoint:CGPointMake(x1, y1) EndPoint:CGPointMake(xx1, yy1)];
                            line1.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                            [self.gousiScro addSubview:line1];
                            
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
                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x2, y2)];
                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                        [self.gousiScro addSubview:line];
                        [pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",x2],@"y":[NSString stringWithFormat:@"%f",y2]}];
                        
                        for (NSDictionary *dic in arr3) {
                            
                            CustomLine *line1 = [[CustomLine alloc]initWithStartPoint:CGPointMake(x2, y2) EndPoint:CGPointMake(xx2, yy2)];
                            line1.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
                            [self.gousiScro addSubview:line1];
                            
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
