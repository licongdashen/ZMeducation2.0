//
//  dianpingliulanCell.m
//  ZMeducation2.0
//
//  Created by 李聪 on 2017/8/14.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "dianpingliulanCell.h"

@implementation dianpingliulanCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selBtn = [[UIButton alloc]initWithFrame:CGRectMake(680, 3, 80, 34)];
        [self.selBtn setImage:DEF_IMAGE(@"icon_more") forState:UIControlStateNormal];
        [self addSubview:self.selBtn];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
