//
//  ZMBaseNavigationController.h
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/12.
//  Copyright © 2017年 licong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMBaseNavigationController : UINavigationController<UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@property(nonatomic,weak) UIViewController* currentShowVC;//防止一次触发多个手势时造成navigationBar的错乱甚至崩溃

@end
