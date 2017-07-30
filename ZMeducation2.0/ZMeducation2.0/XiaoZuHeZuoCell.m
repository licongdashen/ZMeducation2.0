//
//  XiaoZuHeZuoCell.m
//  ZMeducation2.0
//
//  Created by 李聪 on 2017/7/26.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "XiaoZuHeZuoCell.h"

@implementation XiaoZuHeZuoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
        [self addSubview:self.selBtn];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
