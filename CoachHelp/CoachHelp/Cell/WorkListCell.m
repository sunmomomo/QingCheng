//
//  WorkListCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "WorkListCell.h"

@interface WorkListCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_timeLabel;
    
    UIImageView *_iconView;
    
    UIView *_hideBack;
    
    UIImageView *_certificateImgView;
    
    UIImageView *_arrowView;
    
}

@end

@implementation WorkListCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(40), Height320(40))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(8), Height320(20), Width320(196), Height320(18.7))];
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), Width320(200), Height320(15))];
        
        _timeLabel.textColor = UIColorFromRGB(0x666666);
        
        _timeLabel.font = AllFont(11);
        
        [self.contentView addSubview:_timeLabel];
        
        _certificateImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(42), Height320(41), Width320(14), Height320(14))];
        
        _certificateImgView.layer.cornerRadius = _certificateImgView.width/2;
        
        _certificateImgView.layer.masksToBounds = YES;
        
        _certificateImgView.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _certificateImgView.layer.borderWidth = 1;
        
        _certificateImgView.image = [UIImage imageNamed:@"ic_qc_identify"];
        
        _certificateImgView.center = CGPointMake(_certificateImgView.center.x, _titleLabel.center.y);

        [self.contentView addSubview:_certificateImgView];
        
        _arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(25), Height320(19.5), Width320(6.7), Height320(10.7))];
        
        _arrowView.image = [UIImage imageNamed:@"cellarrow"];
        
        _arrowView.center = CGPointMake(_arrowView.center.x, Height320(33.5));
        
        [self.contentView addSubview:_arrowView];
        
        _hideBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _arrowView.left, Height320(72))];
        
        _hideBack.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.6];
        
        [self.contentView addSubview:_hideBack];
        
    }
    
    return self;
    
}


-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    [_titleLabel autoWidth];
    
    if (_titleLabel.right+Width320(5)+_certificateImgView.width>_arrowView.left) {
        
        [_titleLabel changeWidth:_arrowView.left-_certificateImgView.width-Width320(5)];
        
    }
    
    [_certificateImgView changeLeft:_titleLabel.right+Width320(5)];
    
}

-(void)setCity:(NSString *)city
{
    
    _city = city;
    
    if (_title.length && _city.length) {
        
        NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@|%@",_title,_city]];
        
        [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x666666) range:NSMakeRange(astr.length-_city.length-1, _city.length+1)];
        
        [astr addAttribute:NSFontAttributeName value:STFont(13) range:NSMakeRange(astr.length-_city.length-1, _city.length+1)];
        
        _titleLabel.attributedText = astr;
        
    }
    
    _titleLabel.numberOfLines = 0;
    
    CGSize size = [_titleLabel sizeThatFits:CGSizeMake(MSW-Width320(25)-_titleLabel.left, self.height)];
    
    [_titleLabel changeWidth:size.width];
    
    [_titleLabel changeHeight:size.height];
    
    [_certificateImgView changeLeft:_titleLabel.right+Width320(5)];
    
}

-(void)setTime:(NSString *)time
{
    
    _timeLabel.text = time;
    
}

-(void)setIsCertificated:(BOOL)isCertificated
{
    
    _isCertificated = isCertificated;
    
    _certificateImgView.hidden = !_isCertificated;
    
}

-(void)setIcon:(NSURL *)icon
{
    
    _icon = icon;
    
    [_iconView sd_setImageWithURL:_icon];
    
}

-(void)setIsHide:(BOOL)isHide
{
    
    _isHide = isHide;
    
    _hideBack.hidden = !isHide;
    
    if (_isHide) {
        
        _timeLabel.text = @"已隐藏";
        
    }
    
}


@end
