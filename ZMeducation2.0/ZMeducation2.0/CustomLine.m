//
//  CustomLine.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/11.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "CustomLine.h"

@interface CustomLine()

@property (nonatomic)CGPoint startPoint;

@property (nonatomic)CGPoint endPoint;

@end

@implementation CustomLine

-(instancetype)initWithStartPoint:(CGPoint)spoint EndPoint:(CGPoint)epoint;
{
    if (self = [super init]) {
        self.startPoint = spoint;
        self.endPoint = epoint;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 3);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 171 / 255.0, 197 / 255.0, 203 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y);  //起点坐标
    CGContextAddLineToPoint(context, self.endPoint.x, self.endPoint.y);   //终点坐标
    
    CGContextStrokePath(context);
}

@end
