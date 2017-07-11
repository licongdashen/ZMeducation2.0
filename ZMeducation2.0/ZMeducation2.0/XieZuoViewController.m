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
                           @"level2"           :@"6",
                           @"level3"           :@"4",
                           @"level4"           :@"2"};
    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
        
        self.gousiScro.contentSize = CGSizeMake(2000, 2000);
        self.gousiScro.contentOffset = CGPointMake(self.gousiScro.contentSize.width/2 - self.gousiScro.size.width/2, self.gousiScro.contentSize.height/2 - self.gousiScro.size.height/2);
        
        UIView *level1 = [[UIView alloc]initWithFrame:CGRectMake(self.gousiScro.contentSize.width/2 - 120, self.gousiScro.contentSize.height/2 - 62, 240, 125)];
        level1.backgroundColor = [UIColor redColor];
        [self.gousiScro addSubview:level1];
        
        NSArray *arr2 = result[@"list"][0][@"list"];
        double jiaodu = 360/[arr2 count];
    
        NSMutableArray *point2 = [[NSMutableArray alloc]init];
        double jiaodu1 = jiaodu;
        
        if (jiaodu <= 90) {
            float x = level1.centerX;
            float y = level1.centerY - 300;
            
            float x1 = x;
            float y1 = y;
            
            [point2 addObject:@{@"x":[NSString stringWithFormat:@"%f",x1],@"y":[NSString stringWithFormat:@"%f",y1]}];
            for (int i = 0; i < [arr2 count]; i ++) {

                if (jiaodu1 < 90) {
                    x1 = x + 300*sin(jiaodu);
                    y1 = y + (300 + 300*cos(jiaodu));
                }else if (jiaodu1 > 90&&jiaodu1 < 180){
//                    x1 = x + 300*cos(jiaodu - 90);
//                    y1 = y + (300 + 300*sin(jiaodu - 90));
                }else if (jiaodu1 == 90){
//                    x1 = x - 300;
//                    y1 = y + 300;
                }else if (jiaodu1 == 180){
//                    x1 = x;
//                    y1 = y + 600;
                }else if (jiaodu1 > 180&& jiaodu1 < 270){
//                    x1 = x + 300*cos(270 - jiaodu1);
//                    y1 = y + (300 + 300*sin(270 - jiaodu1));
                }else if (jiaodu1 == 270){
//                    x1 = x + 300;
//                    y1 = y + 300;
                }else if (jiaodu1 > 270 && jiaodu1 > 360){
//                    x1 = x + 300*cos(jiaodu - 270);
//                    y1 = y + (300 + 300*sin(jiaodu - 270));
                }
                [point2 addObject:@{@"x":[NSString stringWithFormat:@"%f",x1],@"y":[NSString stringWithFormat:@"%f",y1]}];
                x1 = x;
                y1 = y;
                jiaodu1 += jiaodu;
            }
        }
        
        for (NSDictionary *dic in point2) {
        
            CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake([dic[@"x"] floatValue], [dic[@"y"] floatValue])];
            line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
            [self.gousiScro addSubview:line];
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
