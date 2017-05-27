//
//  CoursePlanAddCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanAddCell.h"

@interface CoursePlanAddCell ()

{
    
    UIButton *_weekButton;
    
    UILabel *_weekLabel;
    
    UIImageView *_weekArrow;
    
    UIButton *_timeButton;
    
    UILabel *_timeLabel;
    
    UIImageView *_timeArrow;
    
    UIButton *_deleteButton;
    
}

@end

@implementation CoursePlanAddCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _weekButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(120), Height320(44))];
        
        [_weekButton setTitle:@"选择星期" forState:UIControlStateNormal];
        
        [_weekButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        
        _weekButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        _weekButton.titleLabel.font = AllFont(14);
        
        [_weekButton addTarget:self.delegate action:@selector(cellWeekClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_weekButton];
        
        _weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(42), _weekButton.height)];
        
        _weekLabel.textColor = UIColorFromRGB(0x666666);
        
        _weekLabel.font = AllFont(14);
        
        [_weekButton addSubview:_weekLabel];
        
        _weekArrow = [[UIImageView alloc]initWithFrame:CGRectMake(_weekLabel.right+Width320(6), Height320(19), Width320(12), Height320(7.4))];
        
        _weekArrow.image = [UIImage imageNamed:@"downarrow"];
        
        [_weekButton addSubview:_weekArrow];
        
        _weekArrow.hidden = YES;
        
        UIView *weekLine = [[UIView alloc]initWithFrame:CGRectMake(0, _weekButton.height-1, _weekButton.width, 1)];
        
        weekLine.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [_weekButton addSubview:weekLine];
        
        _timeButton = [[UIButton alloc]initWithFrame:CGRectMake(_weekButton.right+Width320(16), 0, _weekButton.width, _weekButton.height)];
        
        [_timeButton setTitle:@"选择时间" forState:UIControlStateNormal];
        
        [_timeButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        
        _timeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        _timeButton.titleLabel.font = AllFont(14);
        
        [_timeButton addTarget:self.delegate action:@selector(cellTimeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_timeButton];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(44), _timeButton.height)];
        
        _timeLabel.textColor = UIColorFromRGB(0x666666);
        
        _timeLabel.font = AllFont(14);
        
        [_timeButton addSubview:_timeLabel];
        
        _timeArrow = [[UIImageView alloc]initWithFrame:CGRectMake(_timeLabel.right+Width320(7), _weekArrow.top, _weekArrow.width, _weekArrow.height)];
        
        _timeArrow.image = [UIImage imageNamed:@"downarrow"];
        
        [_timeButton addSubview:_timeArrow];
        
        _timeArrow.hidden = YES;
        
        UIView *timeLine = [[UIView alloc]initWithFrame:weekLine.frame];
        
        timeLine.backgroundColor = weekLine.backgroundColor;
        
        [_timeButton addSubview:timeLine];
        
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(48), 0, Width320(48), Height320(44))];
        
        [self.contentView addSubview:_deleteButton];
        
        [_deleteButton addTarget:self.delegate action:@selector(cellDelete:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *deleteImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(14), Width320(16), Height320(16))];
        
        deleteImg.image = [UIImage imageNamed:@"btn_delete"];
        
        [_deleteButton addSubview:deleteImg];
        
    }
    
    return self;
    
}

-(void)setWeek:(NSString *)week
{
    
    _week = week;
    
    _weekLabel.text = _week;
    
    if (_week.length) {
        
        [_weekButton setTitle:@"" forState:UIControlStateNormal];
        
        _weekArrow.hidden = NO;
        
    }else
    {
        
        _weekArrow.hidden = YES;
        
        [_weekButton setTitle:@"选择星期" forState:UIControlStateNormal];
        
    }
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _time;
    
    if (_time.length) {
        
        [_timeLabel autoWidth];
        
        [_timeArrow changeLeft:_timeLabel.right+Width320(7)];
        
        _timeArrow.hidden = NO;
        
        [_timeButton setTitle:@"" forState:UIControlStateNormal];
        
    }else
    {
        
        _timeArrow.hidden = YES;
        
        [_timeButton setTitle:@"选择时间" forState:UIControlStateNormal];
        
    }
    
}

-(void)setTag:(NSInteger)tag
{
    
    [super setTag:tag];
    
    _weekButton.tag = tag;
    
    _timeButton.tag = tag;
    
    _deleteButton.tag = tag;
    
}

@end
