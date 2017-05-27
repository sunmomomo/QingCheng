//
//  CheckinReportCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinReportCell.h"

@interface CheckinReportCell ()

{
    
    UILabel *_dayLabel;
    
    UILabel *_monthLabel;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UILabel *_cardLabel;
    
    UIImageView *_imgView;
    
    UILabel *_typeLabel;
    
    UILabel *_checkoutLabel;
    
    UIView *_lineView;
    
}

@end

@implementation CheckinReportCell

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
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(73), 0, 1, Height320(97))];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.contentView addSubview:sep];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width320(48), Width320(48))];
        
        _imgView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imgView.layer.masksToBounds = YES;
        
        _imgView.center = sep.center;
        
        _imgView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
        
        _imgView.layer.borderWidth = OnePX;
        
        [self.contentView addSubview:_imgView];
        
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(72), Height320(16), Width320(60), Height320(16))];
        
        _typeLabel.textColor = UIColorFromRGB(0x999999);
        
        _typeLabel.textAlignment = NSTextAlignmentRight;
        
        _typeLabel.font = AllFont(12);
        
        [self.contentView addSubview:_typeLabel];
        
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
        
        _cardLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _subtitleLabel.bottom+Height320(3), _subtitleLabel.width, Height320(14))];
        
        _cardLabel.textColor = UIColorFromRGB(0x999999);
        
        _cardLabel.font =AllFont(12);
        
        [self.contentView addSubview:_cardLabel];
        
        _checkoutLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cardLabel.left, _cardLabel.bottom+Height320(3), _cardLabel.width, Height320(14))];
        
        _checkoutLabel.textColor = UIColorFromRGB(0x999999);
        
        _checkoutLabel.font = AllFont(12);
        
        [self.contentView addSubview:_checkoutLabel];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(97)-1, MSW, 1)];
        
        _lineView.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [self.contentView addSubview:_lineView];
        
    }
    
    return self;
    
}

-(void)setCheckoutTime:(NSString *)checkoutTime
{
    
    _checkoutTime = checkoutTime;
    
    _checkoutLabel.text = [NSString stringWithFormat:@"签出时间：%@",_checkoutTime.length?_checkoutTime:@""];
    
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

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    _subtitleLabel.text = _subtitle;
    
}

-(void)setCardText:(NSString *)cardText
{
    
    _cardText = cardText;
    
    _cardLabel.text = _cardText;
    
}

-(void)setImgURL:(NSURL *)imgURL
{
    
    _imgURL = imgURL;
    
    [_imgView sd_setImageWithURL:_imgURL placeholderImage:[UIImage imageNamed:@"img_default_checkinphoto"]];
    
}

-(void)setCheckinType:(CheckinType)checkinType
{
    
    _checkinType = checkinType;
    
    _typeLabel.text = _checkinType == CheckinTypeCheckin ||_checkinType == CheckinTypeUncheckout?@"暂未签出":_checkinType == CheckinTypeCheckout?@"已签出":@"已撤销";
    
}

@end
