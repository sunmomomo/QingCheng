//
//  YFSignUpAttendanceEmptyCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpAttendanceEmptyCell.h"

@implementation YFSignUpAttendanceEmptyCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iV = [[UIImageView alloc] initWithFrame:CGRectMake((MSW - 24)/2.0, 99, 24, 20)];
        
        [iV setImage:[UIImage imageNamed:@"competionNoBegin"]];
        
        [self.contentView addSubview:iV];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, iV.bottom + 8, MSW - 30,18 )];
        
        label.textColor = YFCellSubGrayTitleColor;
        
        label.font = FontSizeFY(13);
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = @"比赛还未开始，3天后再来吧";
        
        [self.contentView addSubview:label];
        
        self.dayLabel = label;
    }
    return self;
}


@end
