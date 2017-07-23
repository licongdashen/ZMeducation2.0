//
//  PdfViewController.m
//  ZMeducation2.0
//
//  Created by 李聪 on 2017/7/23.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "PdfViewController.h"

@interface PdfViewController ()
{
    UIWebView *web;
}

@end

@implementation PdfViewController
-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.dic = dic;
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width - 175, self.view.height - 95)];
    NSURL *pdfURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DEF_IPA,self.dic[@"unitURL"]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:pdfURL];
    [web setScalesPageToFit:YES];
    [web loadRequest:request];
    [self.view addSubview:web];
    
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    NSURL *pdfURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DEF_IPA,dic[@"unitURL"]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:pdfURL];
    [web loadRequest:request];

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
