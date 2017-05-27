//
//  CoursePlanDetailWeekCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanDetailWeekCell.h"

@interface CoursePlanDetailWeekCell ()

{
    
    UILabel *_weekLabel;
    
    UILabel *_timeLabel;
    
}

@end

@implementation CoursePlanDetailWeekCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(16), 0, MSW/2-Width(20), Height(44))];
        
        _weekLabel.textColor = UIColorFromRGB(0x333333);
        
        _weekLabel.font = AllFont(14);
        
        [self.contentView addSubview:_weekLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW/2+Width(20), 0, MSW/2-Width(47), Height(44))];
        
        _timeLabel.textColor = UIColorFromRGB(0x999999);
        
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
        _timeLabel.font = AllFont(14);
        
        [self.contentView addSubview:_timeLabel];
        
        UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width(23), Height(16), Width(6), Height(12))];
        
        arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:arrowImg];
        
    }
    
    return self;
    
}

-(void)setWeek:(NSString *)week
{
    
    _week = week;
    
    _weekLabel.text = _week;
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _time;
    
}

@end
