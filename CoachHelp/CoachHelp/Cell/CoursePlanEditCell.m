//
//  CoursePlanEditCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanEditCell.h"

@interface CoursePlanEditCell ()

{
    
    UIView *_chooseBack;
    
    UIImageView *_chooseImg;
    
    UILabel *_dateLabel;
    
    UILabel *_weekLabel;
    
    UIButton *_timeButton;
    
    UILabel *_timeLabel;
    
    UILabel *_outTimeLabel;
    
}

@end

@implementation CoursePlanEditCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _chooseBack = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), Height320(12), Width320(16), Height320(16))];
        
        _chooseBack.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        _chooseBack.layer.cornerRadius = _chooseBack.width/2;
        
        _chooseBack.layer.masksToBounds = YES;
        
        _chooseBack.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        
        _chooseBack.layer.borderWidth = 1;
        
        [self.contentView addSubview:_chooseBack];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _chooseBack.width, _chooseBack.height)];
        
        _chooseImg.backgroundColor = UIColorFromRGB(0xffffff);
        
        _chooseImg.image = [UIImage imageNamed:@"selected"];
        
        _chooseImg.layer.cornerRadius = _chooseImg.width/2;
        
        _chooseImg.layer.masksToBounds = YES;
        
        _chooseImg.hidden = YES;
        
        [_chooseBack addSubview:_chooseImg];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_chooseBack.right+Width320(12), 0, Width320(73), Height320(42))];
        
        _dateLabel.textColor = UIColorFromRGB(0x666666);
        
        _dateLabel.font = AllFont(13);
        
        [self.contentView addSubview:_dateLabel];
        
        _weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(_dateLabel.right+Width320(5), _dateLabel.top, Width320(40), _dateLabel.height)];
        
        _weekLabel.textColor = UIColorFromRGB(0x666666);
        
        _weekLabel.font = AllFont(13);
        
        [self.contentView addSubview:_weekLabel];
        
        _timeButton = [[UIButton alloc]initWithFrame:CGRectMake(_weekLabel.right+Width320(30), 0, Width320(50), Height320(41))];
        
        [self.contentView addSubview:_timeButton];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(33), _timeButton.height)];
        
        _timeLabel.textColor = UIColorFromRGB(0x666666);
        
        _timeLabel.font = AllFont(13);
        
        [_timeButton addSubview:_timeLabel];
        
        _outTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(49), 0, Width320(40), Height320(42))];
        
        _outTimeLabel.textColor = UIColorFromRGB(0xbbbbbb);
        
        _outTimeLabel.font = AllFont(12);
        
        _outTimeLabel.text = @"已过期";
        
        _outTimeLabel.hidden = YES;
        
        [self.contentView addSubview:_outTimeLabel];
        
    }
    
    return self;
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _time;
    
    [_timeLabel autoWidth];
    
    [_timeButton changeWidth:_timeLabel.width+Width320(4)];
    
}

-(void)setDay:(NSString *)day
{
    
    _day = day;
    
    _dateLabel.text = _day;
    
}

-(void)setWeek:(NSString *)week
{
    
    _week = week;
    
    _weekLabel.text = _week;
    
}

-(void)setCanEdit:(BOOL)canEdit
{
    
    _canEdit = canEdit;
    
    if (!_canEdit) {
        
        self.userInteractionEnabled = NO;
        
        _chooseBack.hidden = YES;
        
        _dateLabel.textColor = _weekLabel.textColor =  _timeLabel.textColor = UIColorFromRGB(0xbbbbbb);
        
        _outTimeLabel.hidden = NO;
        
    }else
    {
        
        self.userInteractionEnabled = YES;
        
        _chooseBack.hidden = NO;
        
        _dateLabel.textColor = _weekLabel.textColor =  _timeLabel.textColor = UIColorFromRGB(0x666666);
        
        _outTimeLabel.hidden = YES;
        
    }
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    
    _indexPath = indexPath;
    
    _timeButton.indexPath = _indexPath;
    
}

-(void)setIsChoosed:(BOOL)isChoosed
{
    
    _isChoosed = isChoosed;
    
    if (_isChoosed) {
        
        _chooseImg.hidden = NO;
        
    }else
    {
        
        _chooseImg.hidden = YES;
        
    }
    
}


@end
