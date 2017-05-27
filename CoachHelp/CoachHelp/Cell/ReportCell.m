//
//  ReportCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/13.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ReportCell.h"

@interface ReportCell ()

{
    
    UILabel *_dayLabel;
    
    UILabel *_monthLabel;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_imgView;
    
    UIView *_lineView;
    
}

@end

@implementation ReportCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(68.5), 0, 1, Height320(63.5))];
        
        sep.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [self.contentView addSubview:sep];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        _imgView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
        _imgView.layer.borderColor = UIColorFromRGB(0xf4f4f4).CGColor;
        
        _imgView.layer.borderWidth = 1;
        
        _imgView.center = sep.center;
        
        [self.contentView addSubview:_imgView];
        
        _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(2.5), Height320(11.3), Width320(48), Height320(26))];
        
        _dayLabel.textColor = UIColorFromRGB(0x666666);
        
        _dayLabel.font = AllFont(23);
        
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_dayLabel];
        
        _monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(3.9), _dayLabel.bottom, Width320(45), Height320(17.7))];
        
        _monthLabel.font = AllFont(11);
        
        _monthLabel.textColor = UIColorFromRGB(0x999999);
        
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_monthLabel];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(7), Height320(13.3), Width320(205), Height320(18))];
        
        _titleLabel.font = AllFont(15);
        
        _titleLabel.textColor = UIColorFromRGB(0x666666);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), _titleLabel.width, Height320(14))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.font =AllFont(11);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 1)];
        
        _lineView.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [self.contentView addSubview:_lineView];
        
    }
    
    return self;
    
}

-(void)setMonth:(NSString *)month
{
    
    _month = month;
    
    if (_sectionFirst) {
        
        _monthLabel.text = month;
        
    }
    
}

-(void)setDay:(NSString *)day
{
    
    _day = day;
    
    if (_sectionFirst) {
    
        _dayLabel.text = _day;
        
    }
    
}

-(void)setSectionFirst:(BOOL)sectionFirst
{
    
    _sectionFirst = sectionFirst;
    
    if (_sectionFirst) {
        
        _monthLabel.hidden = NO;
        
        _dayLabel.hidden = NO;
        
        [_lineView changeLeft:0];
        
        [_lineView changeWidth:MSW];
        
    }else
    {
        
        _monthLabel.hidden = YES;
        
        _dayLabel.hidden = YES;
        
        [_lineView changeLeft:Width320(68.5)];
        
        [_lineView changeWidth:MSW-Width320(68.5)];
        
    }
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setStartTime:(NSString *)startTime
{
    
    if (startTime.length>=5) {
        
        _startTime = [startTime substringToIndex:5];
        
        if (_startTime.length && _endTime.length && _peopleNum) {
            
            _subtitleLabel.text = [NSString stringWithFormat:@"%@-%@   %ld人",_startTime,_endTime,(long)_peopleNum];
            
        }
        
    }
    
}

-(void)setEndTime:(NSString *)endTime
{
    
    _endTime = [endTime substringToIndex:5];
    
    if (_startTime.length && _endTime.length && _peopleNum) {
        
        _subtitleLabel.text = [NSString stringWithFormat:@"%@-%@   %ld人",_startTime,_endTime,(long)_peopleNum];
        
    }
    
}

-(void)setPeopleNum:(NSInteger)peopleNum
{
    
    _peopleNum = peopleNum;
    
    if (_startTime.length && _endTime.length && _peopleNum) {
        
        _subtitleLabel.text = [NSString stringWithFormat:@"%@-%@   %ld人",_startTime,_endTime,(long)_peopleNum];
        
    }
    
}

-(void)setImgUrl:(NSURL *)imgUrl
{
    
    _imgUrl = imgUrl;
    
    [_imgView sd_setImageWithURL:_imgUrl placeholderImage:[UIImage imageNamed:@"img_default_course"]];
    
}

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    _subtitleLabel.text = _subtitle;
    
}

@end
