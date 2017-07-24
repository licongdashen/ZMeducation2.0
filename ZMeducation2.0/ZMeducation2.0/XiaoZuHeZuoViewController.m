//
//  XiaoZuHeZuoViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/24.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "XiaoZuHeZuoViewController.h"

@interface XiaoZuHeZuoViewController ()
@property (nonatomic, strong)NSMutableDictionary *userInfo;

@end

@implementation XiaoZuHeZuoViewController

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
