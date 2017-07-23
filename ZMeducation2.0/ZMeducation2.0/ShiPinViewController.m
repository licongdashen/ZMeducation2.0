//
//  ShiPinViewController.m
//  ZMeducation2.0
//
//  Created by 李聪 on 2017/7/23.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "ShiPinViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface ShiPinViewController ()
{
    AVPlayer *player;
    AVPlayerLayer *showVodioLayer;
    
}
@property (nonatomic, strong)UIWebView *web;

@end

@implementation ShiPinViewController
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

-(void)dealloc
{
    
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

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    NSLog(@"%@",change[@"new"]);
    AVPlayerItemStatus status = [change[@"new"] integerValue];
    switch (status) {
        case AVPlayerItemStatusUnknown: {
            NSLog(@"未知状态");
            break;
        }
        case AVPlayerItemStatusReadyToPlay: {
            NSLog(@"视频的总时长%f", CMTimeGetSeconds(player.currentItem.duration));
            
            break;
        }
        case AVPlayerItemStatusFailed: {
            NSLog(@"加载失败");
            break;
        }
    }
    
    
}
//快进
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //快进
    //跳到某一个进度的方法：seekToTime:
    //得到当前的时间 + 快进的时间
    
    
    //获得当前播放的时间 （秒）
    Float64 cur =  CMTimeGetSeconds(player.currentTime);
    cur ++;
    [player seekToTime:CMTimeMake(cur, 1)];
    
}

-(void)itemDidPlayToEndTime:(NSNotification *)not{
    NSLog(@"播放结束");
    [player seekToTime:kCMTimeZero];
    
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
