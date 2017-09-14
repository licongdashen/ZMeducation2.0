//
//  ImageDetailViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/9/14.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "ImageDetailViewController.h"

@interface ImageDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIView *navView;

@property (nonatomic, strong)UIPageControl *pageControl;

@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 64)];
    self.navView.backgroundColor = DEF_COLOR_RGB(0, 154, 221);
    [self.view addSubview:self.navView];

    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 23, 65, 30)];
    [backBtn setTitle:@"返回" forState:0];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:backBtn];
    
    UIScrollView *scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 65, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 65)];
    scro.pagingEnabled = YES;
    scro.delegate = self;
    [self.view addSubview:scro];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(0, DEF_DEVICE_HEIGHT - 50, 200, 20);//指定位置大小
    _pageControl.centerX = self.view.centerX;
    _pageControl.numberOfPages = self.arr.count;
    [self.view addSubview:_pageControl];
    
    int x = 0;
    for (int i = 0; i < self.arr.count; i++) {
        
        UIImageView *imav = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, DEF_DEVICE_WIDTH, scro.height)];
        [imav sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DEF_IPA,self.arr[i][@"fileUrl"]]]];
        imav.contentMode = UIViewContentModeScaleAspectFit;
        imav.clipsToBounds = YES;
        [scro addSubview:imav];
        
        x += DEF_DEVICE_WIDTH;
        
        scro.contentSize = CGSizeMake(self.arr.count * DEF_DEVICE_WIDTH, scro.height);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
        // 设置页码
    _pageControl.currentPage = page;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
