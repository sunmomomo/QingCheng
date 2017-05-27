//
//  CoursePlanDetailCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanDetailCell.h"

@interface CoursePlanDetailCell ()

{
    
    UILabel *_dateLabel;
    
    UILabel *_weekLabel;
    
    UILabel *_timeLabel;
    
    UILabel *_outTimeLabel;
    
}

@end

@implementation CoursePlanDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(80), Height320(40))];
        
        _dateLabel.textColor = UIColorFromRGB(0x666666);
        
        _dateLabel.font = AllFont(14);
        
        [self.contentView addSubview:_dateLabel];
        
        _weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(_dateLabel.right+Width320(2), _dateLabel.top, Width320(50), _dateLabel.height)];
        
        _weekLabel.textColor = UIColorFromRGB(0x666666);
        
        _weekLabel.font = AllFont(14);
        
        [self.contentView addSubview:_weekLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_weekLabel.right+Width320(2), 0, Width320(90), Height320(40))];
        
        _timeLabel.textColor = UIColorFromRGB(0x666666);
        
        _timeLabel.font = AllFont(14);
        
        [self.contentView addSubview:_timeLabel];
        
        _outTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(75), 0, Width320(48), Height320(40))];
        
        _outTimeLabel.textColor = UIColorFromRGB(0xbbbbbb);
        
        _outTimeLabel.font = AllFont(12);
        
        _outTimeLabel.text = @"已完成";
        
        _outTimeLabel.hidden = YES;
        
        _outTimeLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_outTimeLabel];
        
        UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), Height320(14), Width320(7), Height320(12))];
        
        arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:arrowImg];
        
    }
    
    return self;
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _time;
    
}

-(void)setDay:(NSString *)day
{
    
    _day = day;
    
    _dateLabel.text = _day;
    
}

-(void)setWeek:(NSString *)week
{
    
    _week = week;
    
    _weekLabel.text = [NSString stringWithFormat:@"%@，",_week];
    
}

-(void)setOutTime:(BOOL)outTime
{
    
    _outTime = outTime;
    
    _outTimeLabel.hidden = !_outTime;
    
    _weekLabel.textColor = _timeLabel.textColor = _dateLabel.textColor = _outTime?UIColorFromRGB(0xbbbbbb):UIColorFromRGB(0x333333);
    
}

@end
