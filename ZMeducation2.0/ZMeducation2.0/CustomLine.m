//
//  CustomLine.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/7/11.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "CustomLine.h"

@interface CustomLine()

@property (nonatomic, strong)NSMutableArray * PointArr;


@end

@implementation CustomLine

-(instancetype)initWithPointArr:(NSMutableArray *)arr
{
    if (self = [super init]) {

        self.PointArr = arr;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    for (NSDictionary *dic in self.PointArr) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, 3);  //线宽
        CGContextSetAllowsAntialiasing(context, true);
        CGContextSetRGBStrokeColor(context, 171 / 255.0, 197 / 255.0, 203 / 255.0, 1.0);  //线的颜色
        CGContextBeginPath(context);
        
        CGContextMoveToPoint(context, [dic[@"x"] floatValue], [dic[@"y"] floatValue]);  //起点坐标
        CGContextAddLineToPoint(context, [dic[@"x1"] floatValue], [dic[@"y1"] floatValue]);   //终点坐标
        
        CGContextStrokePath(context);

    }
    
}

@end
