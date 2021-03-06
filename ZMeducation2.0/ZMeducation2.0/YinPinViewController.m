//
//  YinPinViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/13.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "YinPinViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface YinPinViewController ()
{
    AVPlayer *player;
    AVPlayerLayer *showVodioLayer;
}

@end

@implementation YinPinViewController

-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.dic = dic;
    }
    return self;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [player play];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [player pause];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DEF_IPA,self.dic[@"unitURL"]]]];
    
    //2、创建播放器
    player = [AVPlayer playerWithPlayerItem:playerItem];
    
    //3、创建视频显示的图层
    showVodioLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    showVodioLayer.frame = CGRectMake(0, 0, self.view.width - 175, self.view.height - 95);
    [self.view.layer addSublayer:showVodioLayer];
    [player play];
    
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DEF_IPA,dic[@"unitURL"]]]];
    //2、创建播放器
    player = [AVPlayer playerWithPlayerItem:playerItem];
    [showVodioLayer setPlayer:player];
    [player play];
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
