//
//  IntegralHistoryCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "IntegralHistoryCell.h"

@interface IntegralHistoryCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_timeLabel;
    
    UILabel *_placeLabel;
    
    UILabel *_awardLabel;
    
    UILabel *_summaryLabel;
    
    UILabel *_integralLabel;
    
    UILabel *_currentLabel;
    
}

@end

@implementation IntegralHistoryCell

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
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(200), Height320(19))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(15);
        
        [self.contentView addSubview:_titleLabel];
        
        UIImageView *timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), _titleLabel.bottom+Height320(12), Width320(12), Height320(12))];
        
        timeImg.image = [UIImage imageNamed:@"integral_time"];
        
        [self.contentView addSubview:timeImg];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(timeImg.right+Width320(7), _titleLabel.bottom+Height320(10), Width320(180), Height320(16))];
        
        _timeLabel.textColor = UIColorFromRGB(0xcccccc);
        
        _timeLabel.font = AllFont(12);
        
        [self.contentView addSubview:_timeLabel];
        
        UIImageView *awardImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), timeImg.bottom+Height320(4), Width320(12), Height320(12))];
        
        awardImg.image = [UIImage imageNamed:@"integral_award"];
        
        [self.contentView addSubview:awardImg];
        
        _awardLabel = [[UILabel alloc]initWithFrame:CGRectMake(_timeLabel.left, _timeLabel.bottom, _timeLabel.width, Height320(16))];
        
        _awardLabel.textColor = UIColorFromRGB(0xcccccc);
        
        _awardLabel.font = AllFont(12);
        
        [self.contentView addSubview:_awardLabel];
        
        UIImageView *placeImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), awardImg.bottom+Height320(4), Width320(12), Height320(12))];
        
        placeImg.image = [UIImage imageNamed:@"integral_place"];
        
        [self.contentView addSubview:placeImg];
        
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_awardLabel.left, _awardLabel.bottom, _awardLabel.width, Height320(16))];
        
        _placeLabel.textColor = UIColorFromRGB(0xcccccc);
        
        _placeLabel.font = AllFont(12);
        
        [self.contentView addSubview:_placeLabel];
        
        UIImageView *summaryImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), placeImg.bottom+Height320(4), Width320(12), Height320(12))];
        
        summaryImg.image = [UIImage imageNamed:@"integral_summary"];
        
        [self.contentView addSubview:summaryImg];
        
        _summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(_placeLabel.left, _placeLabel.bottom+Height320(2), _placeLabel.width, Height320(16))];
        
        _summaryLabel.textColor = UIColorFromRGB(0xcccccc);
        
        _summaryLabel.font = AllFont(12);
        
        _summaryLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_summaryLabel];
        
        _integralLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(91), Height320(15), Width320(75), Height320(22))];
        
        _integralLabel.textAlignment = NSTextAlignmentRight;
        
        _integralLabel.font = AllFont(20);
        
        [self.contentView addSubview:_integralLabel];
        
        _currentLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(130), _integralLabel.bottom+Height320(5), Width320(114), Height320(16))];
        
        _currentLabel.textColor = UIColorFromRGB(0xcccccc);
        
        _currentLabel.font = AllFont(12);
        
        _currentLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_currentLabel];
        
    }
    
    return self;
    
}

-(void)setIntegral:(float)integral
{
    
    _integral = integral;
    
    _integralLabel.text = [NSString formatStringWithFloat:_integral];
    
    _integralLabel.textColor = _integral>0?UIColorFromRGB(0x0DB14B):UIColorFromRGB(0xEA6161);
    
}

-(void)setCurrentIntegral:(float)currentIntegral
{
    
    _currentIntegral = currentIntegral;
    
    _currentLabel.text = [NSString stringWithFormat:@"当前积分  %@",[NSString formatStringWithFloat:_currentIntegral]];
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _time;
    
}

-(void)setSummary:(NSString *)summary
{
    
    _summary = summary;
    
    _summaryLabel.text = _summary;
    
    CGSize size = [_summary boundingRectWithSize:CGSizeMake(Width320(180), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    [_summaryLabel changeHeight:size.height];
    
}

-(void)setAward:(NSString *)award
{
    
    _award = award;
    
    _awardLabel.text = _award;
    
}

-(void)setPlace:(NSString *)place
{
    
    _place = place;
    
    _placeLabel.text = _place;
    
}

@end
