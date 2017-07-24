//
//  LunTanCell.m
//  ZMeducation2.0
//
//  Created by 李聪 on 2017/7/23.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "LunTanCell.h"

@implementation LunTanCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.btn = [[UIButton alloc]initWithFrame:CGRectMake(680, 10, 30, 30)];
        [self.btn setImage:DEF_IMAGE(@"luntan_dianzan") forState:UIControlStateNormal];
        [self addSubview:self.btn];

        self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.btn.right + 10, 10, 30, 30)];
        [self.btn1 setImage:DEF_IMAGE(@"luntan_dingzhi") forState:UIControlStateNormal];
        [self addSubview:self.btn1];
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
