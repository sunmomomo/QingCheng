//
//  YFSignUpGroupDetaiMorelCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpGroupDetaiMorelCell.h"

@implementation YFSignUpGroupDetaiMorelCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat leftXX = (MSW - 12 - 80 - 4) / 2.0;
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftXX, 0, 80 ,45)];
        
        label.textColor = YFCellSubGrayTitleColor;
        
        label.font = FontSizeFY(13);
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = @"展开全部成员";
        
        [self.contentView addSubview:label];
        
        
        UIImageView *iV = [[UIImageView alloc] initWithFrame:CGRectMake(label.right + 4, 21, 12, 8)];
        
        [iV setImage:[UIImage imageNamed:@"AllDownArrow"]];
        
        [self.contentView addSubview:iV];

    }
    return self;
}



@end
