//
//  YFBaseCell.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseCell.h"
#import "YFAppConfig.h"

@implementation YFBaseCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = YFMainBackColor;
    self.contentView.backgroundColor = YFMainBackColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
