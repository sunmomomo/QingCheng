//
//  CourseReportCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/13.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "CourseReportCell.h"

@interface CourseReportCell ()

{
    
    UILabel *_dayLabel;
    
    UILabel *_monthLabel;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UILabel *_userLabel;
    
    UIImageView *_imgView;
    
    UIImageView *_typeImg;
    
    UIView *_lineView;
    
    UILabel *_realPriceLabel;
    
}

@end

@implementation CourseReportCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(73), 0, 1, Height320(83))];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.contentView addSubview:sep];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width320(48), Width320(48))];
        
        _imgView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
        _imgView.layer.borderColor = UIColorFromRGB(0xf4f4f4).CGColor;
        
        _imgView.layer.borderWidth = 1;
        
        _imgView.center = sep.center;
        
        [self.contentView addSubview:_imgView];
        
        _typeImg = [[UIImageView alloc]initWithFrame:CGRectMake(_imgView.right-Width320(15), _imgView.bottom-Height320(15), Width320(15), Height320(15))];
        
        _typeImg.layer.cornerRadius = _typeImg.width/2;
        
        [self.contentView addSubview:_typeImg];
        
        _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(2), Height320(19), Width320(48), Height320(28))];
        
        _dayLabel.textColor = UIColorFromRGB(0x666666);
        
        _dayLabel.font = AllFont(25);
        
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_dayLabel];
        
        _monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(4), _dayLabel.bottom, Width320(45), Height320(18))];
        
        _monthLabel.font = AllFont(12);
        
        _monthLabel.textColor = UIColorFromRGB(0x999999);
        
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_monthLabel];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(7), Height320(14), Width320(205), Height320(18))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x666666);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), _titleLabel.width, Height320(14))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.font =AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _userLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _subtitleLabel.bottom+Height320(3), _subtitleLabel.width, Height320(14))];
        
        _userLabel.textColor = UIColorFromRGB(0x999999);
        
        _userLabel.font =AllFont(12);
        
        [self.contentView addSubview:_userLabel];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(83)-1, MSW, 1)];
        
        _lineView.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [self.contentView addSubview:_lineView];
        
        _realPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(120), Height320(50), Width320(102), Height320(17))];
        
        _realPriceLabel.textColor = UIColorFromRGB(0xf9944e);
        
        _realPriceLabel.font = AllFont(12);
        
        _realPriceLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_realPriceLabel];
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(13), Height320(56), Width320(5), Height320(8))];
        
        arrow.image = [[UIImage imageNamed:@"cellarrow"]imageWithTintColor:UIColorFromRGB(0xF9944E)];
        
        [self.contentView addSubview:arrow];
        
        arrow.center = CGPointMake(arrow.center.x, _realPriceLabel.center.y);
        
    }
    
    return self;
    
}

-(void)setRealPrice:(float)realPrice
{
    
    _realPrice = realPrice;
    
    NSString *str = [NSString stringWithFormat:@"实收  ￥%.2f",_realPrice];
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xbbbbbb) range:NSMakeRange(0, 2)];
    
    _realPriceLabel.attributedText = astr;
    
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
        
    }else
    {
        
        _monthLabel.hidden = YES;
        
        _dayLabel.hidden = YES;
        
    }
    
}

-(void)setSectionLast:(BOOL)sectionLast
{
    
    _sectionLast = sectionLast;
    
    if (_sectionLast) {
        
        [_lineView changeLeft:0];
        
        [_lineView changeWidth:MSW];
        
    }else
    {
        
        [_lineView changeLeft:Width320(73)];
        
        [_lineView changeWidth:MSW-Width320(73)];
        
    }
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setStartTime:(NSString *)startTime
{
    
    _startTime = [startTime substringToIndex:5];
    
    if (_startTime.length && _endTime.length) {
        
        _subtitleLabel.text = [NSString stringWithFormat:@"%@-%@",_startTime,_endTime];
        
    }
    
}

-(void)setEndTime:(NSString *)endTime
{
    
    _endTime = [endTime substringToIndex:5];
    
    if (_startTime.length && _endTime.length) {
        
        _subtitleLabel.text = [NSString stringWithFormat:@"%@-%@",_startTime,_endTime];
        
    }
    
}

-(void)setShopName:(NSString *)shopName
{
    
    _shopName = shopName;
    
    if (_startTime.length && _endTime.length && _shopName.length) {
        
        _subtitleLabel.text = [NSString stringWithFormat:@"%@-%@   %@",_startTime,_endTime,_shopName];
        
    }
    
}

-(void)setUserText:(NSString *)userText
{
    
    _userText = userText;
    
    if (_userText.length) {
        
        _userLabel.text = _userText;
        
    }
    
}

-(void)setImgUrl:(NSURL *)imgUrl
{
    
    _imgUrl = imgUrl;
    
    [_imgView sd_setImageWithURL:_imgUrl placeholderImage:[UIImage imageNamed:@"img_default_course"]];
    
}

-(void)setCourseType:(CourseType)courseType
{
    
    _courseType = courseType;
    
    _typeImg.image = [UIImage imageNamed:_courseType == CourseTypeGroup?@"course_group":@"course_private"];
    
}

@end
